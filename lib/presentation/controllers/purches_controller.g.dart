// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purches_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// AsyncNotifier untuk saldo pada fitur purches.
///
/// `build` melakukan fetch saldo awal. Saldo dapat di-refresh dengan
/// `ref.invalidate(purchesBalanceProvider)` setelah transaksi berhasil.

@ProviderFor(PurchesBalance)
final purchesBalanceProvider = PurchesBalanceProvider._();

/// AsyncNotifier untuk saldo pada fitur purches.
///
/// `build` melakukan fetch saldo awal. Saldo dapat di-refresh dengan
/// `ref.invalidate(purchesBalanceProvider)` setelah transaksi berhasil.
final class PurchesBalanceProvider
    extends $AsyncNotifierProvider<PurchesBalance, String> {
  /// AsyncNotifier untuk saldo pada fitur purches.
  ///
  /// `build` melakukan fetch saldo awal. Saldo dapat di-refresh dengan
  /// `ref.invalidate(purchesBalanceProvider)` setelah transaksi berhasil.
  PurchesBalanceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'purchesBalanceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$purchesBalanceHash();

  @$internal
  @override
  PurchesBalance create() => PurchesBalance();
}

String _$purchesBalanceHash() => r'3c12e2d2fbef5f53b7d6bf6ce50cd7ecf9814d0c';

/// AsyncNotifier untuk saldo pada fitur purches.
///
/// `build` melakukan fetch saldo awal. Saldo dapat di-refresh dengan
/// `ref.invalidate(purchesBalanceProvider)` setelah transaksi berhasil.

abstract class _$PurchesBalance extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<String>, String>,
        AsyncValue<String>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// AsyncNotifier untuk aksi pembayaran/transaksi layanan.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [purches] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
/// Setelah transaksi berhasil, saldo di-refresh melalui invalidasi provider
/// saldo.

@ProviderFor(PurchesAction)
final purchesActionProvider = PurchesActionProvider._();

/// AsyncNotifier untuk aksi pembayaran/transaksi layanan.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [purches] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
/// Setelah transaksi berhasil, saldo di-refresh melalui invalidasi provider
/// saldo.
final class PurchesActionProvider
    extends $AsyncNotifierProvider<PurchesAction, void> {
  /// AsyncNotifier untuk aksi pembayaran/transaksi layanan.
  ///
  /// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
  /// [purches] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
  /// Setelah transaksi berhasil, saldo di-refresh melalui invalidasi provider
  /// saldo.
  PurchesActionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'purchesActionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$purchesActionHash();

  @$internal
  @override
  PurchesAction create() => PurchesAction();
}

String _$purchesActionHash() => r'fc7a76cc676c3757e281ef97b58c830ad04e296b';

/// AsyncNotifier untuk aksi pembayaran/transaksi layanan.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [purches] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
/// Setelah transaksi berhasil, saldo di-refresh melalui invalidasi provider
/// saldo.

abstract class _$PurchesAction extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<void>, void>,
        AsyncValue<void>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
