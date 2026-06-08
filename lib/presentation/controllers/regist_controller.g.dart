// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regist_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier state UI lokal untuk halaman registrasi.

@ProviderFor(RegistUi)
final registUiProvider = RegistUiProvider._();

/// Notifier state UI lokal untuk halaman registrasi.
final class RegistUiProvider
    extends $NotifierProvider<RegistUi, RegistUiState> {
  /// Notifier state UI lokal untuk halaman registrasi.
  RegistUiProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'registUiProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$registUiHash();

  @$internal
  @override
  RegistUi create() => RegistUi();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegistUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegistUiState>(value),
    );
  }
}

String _$registUiHash() => r'e1ae0af3d41f5bc2dd6a37b9c784eaf0a2465614';

/// Notifier state UI lokal untuk halaman registrasi.

abstract class _$RegistUi extends $Notifier<RegistUiState> {
  RegistUiState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RegistUiState, RegistUiState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<RegistUiState, RegistUiState>,
        RegistUiState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// AsyncNotifier untuk aksi registrasi pengguna.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [regist] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.

@ProviderFor(RegistAuth)
final registAuthProvider = RegistAuthProvider._();

/// AsyncNotifier untuk aksi registrasi pengguna.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [regist] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
final class RegistAuthProvider
    extends $AsyncNotifierProvider<RegistAuth, void> {
  /// AsyncNotifier untuk aksi registrasi pengguna.
  ///
  /// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
  /// [regist] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
  RegistAuthProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'registAuthProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$registAuthHash();

  @$internal
  @override
  RegistAuth create() => RegistAuth();
}

String _$registAuthHash() => r'327ba6c15c1841263f5026e281d648603f96be5d';

/// AsyncNotifier untuk aksi registrasi pengguna.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [regist] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.

abstract class _$RegistAuth extends $AsyncNotifier<void> {
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
