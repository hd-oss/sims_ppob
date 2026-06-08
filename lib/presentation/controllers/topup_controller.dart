import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/async_value_x.dart';
import '../../common/result_state.dart';
import '../../di/usecase_providers.dart';
import '../../domain/usecases/topup_usecase.dart';

part 'topup_controller.g.dart';

/// AsyncNotifier untuk saldo pada fitur top up.
///
/// `build` melakukan fetch saldo awal. Saldo dapat di-refresh dengan
/// `ref.invalidate(topupBalanceProvider)` setelah top up berhasil.
@riverpod
class TopupBalance extends _$TopupBalance {
  @override
  FutureOr<String> build() async {
    final result = await ref.watch(topupUseCaseProvider).getBalance();
    return unwrapEither(result) ?? '0';
  }
}

/// AsyncNotifier untuk aksi top up.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [topup] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
/// Setelah top up berhasil, saldo di-refresh melalui invalidasi provider saldo.
@riverpod
class TopupAction extends _$TopupAction {
  @override
  FutureOr<void> build() {} // idle; tidak fetch saat init

  /// Menjalankan top up sejumlah [amount]. Hasil `Either` dari usecase
  /// dikonversi ke `AsyncValue` melalui `unwrapEither` di dalam
  /// `AsyncValue.guard`. Saat berhasil, saldo di-refresh.
  Future<void> topup(String amount) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result =
          await ref.read(topupUseCaseProvider).topupEvent(amount);
      unwrapEither(result);
    });

    // Picu refresh saldo setelah top up berhasil.
    if (!state.hasError) {
      ref.invalidate(topupBalanceProvider);
      // Catatan: saldo dashboard (`balanceControllerProvider`) akan
      // di-invalidate di sini setelah fitur dashboard dimigrasikan (task 11).
    }
  }
}

// ---------------------------------------------------------------------------
// Artefak lama (StateNotifier) dipertahankan sementara agar aplikasi tetap
// dapat dikompilasi selama transisi. Akan dihapus pada langkah pembersihan
// (lihat task 7.2 / 14).
// ---------------------------------------------------------------------------

class TopupState {
  final ResultState<String>? topupResult;
  final ResultState<String>? balanceData;

  TopupState({
    this.topupResult,
    this.balanceData,
  });

  TopupState copyWith({
    ResultState<String>? topupResult,
    ResultState<String>? balanceData,
  }) {
    return TopupState(
        balanceData: balanceData ?? this.balanceData,
        topupResult: topupResult ?? this.topupResult);
  }
}

class TopupController extends StateNotifier<TopupState> {
  final TopupUseCase topupUseCase;
  TopupController(this.topupUseCase) : super(TopupState());

  Future<void> initState() async {
    state = state.copyWith(balanceData: ResultState.loading());
    try {
      final result = await topupUseCase.getBalance();
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

  Future<void> topupEvent(String amount) async {
    state = state.copyWith(topupResult: ResultState.loading(amount));

    try {
      final result = await topupUseCase.topupEvent(amount);
      state = state.copyWith(
        topupResult: result.fold(
          (message) => ResultState.error(message, amount),
          (data) => ResultState.success(data),
        ),
      );
      initState();
    } catch (e) {
      state =
          state.copyWith(topupResult: ResultState.error(e.toString(), amount));
    }
  }
}
