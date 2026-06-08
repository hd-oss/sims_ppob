import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/async_value_x.dart';
import '../../di/usecase_providers.dart';

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
