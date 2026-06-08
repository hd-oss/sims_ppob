import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/async_value_x.dart';
import '../../common/result_state.dart';
import '../../di/usecase_providers.dart';
import '../../domain/usecases/purches_usecase.dart';

part 'purches_controller.g.dart';

/// AsyncNotifier untuk saldo pada fitur purches.
///
/// `build` melakukan fetch saldo awal. Saldo dapat di-refresh dengan
/// `ref.invalidate(purchesBalanceProvider)` setelah transaksi berhasil.
@riverpod
class PurchesBalance extends _$PurchesBalance {
  @override
  FutureOr<String> build() async {
    final result = await ref.watch(purchesUseCaseProvider).getBalance();
    return unwrapEither(result) ?? '0';
  }
}

/// AsyncNotifier untuk aksi pembayaran/transaksi layanan.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [purches] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
/// Setelah transaksi berhasil, saldo di-refresh melalui invalidasi provider
/// saldo.
@riverpod
class PurchesAction extends _$PurchesAction {
  @override
  FutureOr<void> build() {} // idle; tidak fetch saat init

  /// Menjalankan transaksi pembayaran layanan dengan kode [serviceCode].
  /// Hasil `Either` dari usecase dikonversi ke `AsyncValue` melalui
  /// `unwrapEither` di dalam `AsyncValue.guard`. Saat berhasil, saldo
  /// di-refresh.
  Future<void> purches(String serviceCode) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result =
          await ref.read(purchesUseCaseProvider).purchesEvent(serviceCode);
      unwrapEither(result);
    });

    // Picu refresh saldo setelah transaksi berhasil.
    if (!state.hasError) {
      ref.invalidate(purchesBalanceProvider);
      // Catatan: saldo dashboard (`balanceControllerProvider`) akan
      // di-invalidate di sini setelah fitur dashboard dimigrasikan (task 11).
    }
  }
}

// ---------------------------------------------------------------------------
// Artefak lama (StateNotifier) dipertahankan sementara agar aplikasi tetap
// dapat dikompilasi selama transisi. Akan dihapus pada langkah pembersihan
// (lihat task 8.2 / 14).
// ---------------------------------------------------------------------------

class PurchesState {
  final ResultState<String>? purchesResult;
  final ResultState<String>? balanceData;

  PurchesState({
    this.purchesResult,
    this.balanceData,
  });

  PurchesState copyWith({
    ResultState<String>? purchesResult,
    ResultState<String>? balanceData,
  }) {
    return PurchesState(
        balanceData: balanceData ?? this.balanceData,
        purchesResult: purchesResult ?? this.purchesResult);
  }
}

class PurchesController extends StateNotifier<PurchesState> {
  final PurchesUseCase purchesUseCase;
  PurchesController(this.purchesUseCase) : super(PurchesState());

  Future<void> initState() async {
    state = state.copyWith(balanceData: ResultState.loading());
    try {
      final result = await purchesUseCase.getBalance();
      state = state.copyWith(
        balanceData: result.fold(
          (message) => ResultState.error(message),
          (data) => ResultState.success(data),
        ),
      );
    } catch (e) {
      state = state.copyWith(balanceData: ResultState.error(e.toString()));
    }
  }

  Future<void> purchesEvent(String serviceCode) async {
    state = state.copyWith(purchesResult: ResultState.loading(serviceCode));

    try {
      final result = await purchesUseCase.purchesEvent(serviceCode);
      state = state.copyWith(
        purchesResult: result.fold(
          (message) => ResultState.error(message, serviceCode),
          (data) => ResultState.success(data),
        ),
      );
      initState();
    } catch (e) {
      state = state.copyWith(
          purchesResult: ResultState.error(e.toString(), serviceCode));
    }
  }
}
