// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// AsyncNotifier untuk saldo pada fitur top up.
///
/// `build` melakukan fetch saldo awal. Saldo dapat di-refresh dengan
/// `ref.invalidate(topupBalanceProvider)` setelah top up berhasil.

@ProviderFor(TopupBalance)
final topupBalanceProvider = TopupBalanceProvider._();

/// AsyncNotifier untuk saldo pada fitur top up.
///
/// `build` melakukan fetch saldo awal. Saldo dapat di-refresh dengan
/// `ref.invalidate(topupBalanceProvider)` setelah top up berhasil.
final class TopupBalanceProvider
    extends $AsyncNotifierProvider<TopupBalance, String> {
  /// AsyncNotifier untuk saldo pada fitur top up.
  ///
  /// `build` melakukan fetch saldo awal. Saldo dapat di-refresh dengan
  /// `ref.invalidate(topupBalanceProvider)` setelah top up berhasil.
  TopupBalanceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'topupBalanceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$topupBalanceHash();

  @$internal
  @override
  TopupBalance create() => TopupBalance();
}

String _$topupBalanceHash() => r'fd926f87dbe797f401f4443e3cb8eaceded66330';

/// AsyncNotifier untuk saldo pada fitur top up.
///
/// `build` melakukan fetch saldo awal. Saldo dapat di-refresh dengan
/// `ref.invalidate(topupBalanceProvider)` setelah top up berhasil.

abstract class _$TopupBalance extends $AsyncNotifier<String> {
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

/// AsyncNotifier untuk aksi top up.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [topup] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
/// Setelah top up berhasil, saldo di-refresh melalui invalidasi provider saldo.

@ProviderFor(TopupAction)
final topupActionProvider = TopupActionProvider._();

/// AsyncNotifier untuk aksi top up.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [topup] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
/// Setelah top up berhasil, saldo di-refresh melalui invalidasi provider saldo.
final class TopupActionProvider
    extends $AsyncNotifierProvider<TopupAction, void> {
  /// AsyncNotifier untuk aksi top up.
  ///
  /// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
  /// [topup] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
  /// Setelah top up berhasil, saldo di-refresh melalui invalidasi provider saldo.
  TopupActionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'topupActionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$topupActionHash();

  @$internal
  @override
  TopupAction create() => TopupAction();
}

String _$topupActionHash() => r'98bd96a0bfe400a71f9d89c2b9578d4780155d5b';

/// AsyncNotifier untuk aksi top up.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [topup] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
/// Setelah top up berhasil, saldo di-refresh melalui invalidasi provider saldo.

abstract class _$TopupAction extends $AsyncNotifier<void> {
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
