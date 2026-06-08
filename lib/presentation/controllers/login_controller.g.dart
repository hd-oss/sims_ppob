// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier state UI lokal untuk halaman login.
///
/// Menyimpan flag `isHide` (visibilitas password) dengan nilai default `true`.

@ProviderFor(LoginUi)
final loginUiProvider = LoginUiProvider._();

/// Notifier state UI lokal untuk halaman login.
///
/// Menyimpan flag `isHide` (visibilitas password) dengan nilai default `true`.
final class LoginUiProvider extends $NotifierProvider<LoginUi, bool> {
  /// Notifier state UI lokal untuk halaman login.
  ///
  /// Menyimpan flag `isHide` (visibilitas password) dengan nilai default `true`.
  LoginUiProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'loginUiProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$loginUiHash();

  @$internal
  @override
  LoginUi create() => LoginUi();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$loginUiHash() => r'3f8579329734df41cd046f7d3c22c9fdf5b5537e';

/// Notifier state UI lokal untuk halaman login.
///
/// Menyimpan flag `isHide` (visibilitas password) dengan nilai default `true`.

abstract class _$LoginUi extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

/// AsyncNotifier untuk aksi autentikasi login.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [login] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.

@ProviderFor(LoginAuth)
final loginAuthProvider = LoginAuthProvider._();

/// AsyncNotifier untuk aksi autentikasi login.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [login] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
final class LoginAuthProvider extends $AsyncNotifierProvider<LoginAuth, void> {
  /// AsyncNotifier untuk aksi autentikasi login.
  ///
  /// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
  /// [login] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
  LoginAuthProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'loginAuthProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$loginAuthHash();

  @$internal
  @override
  LoginAuth create() => LoginAuth();
}

String _$loginAuthHash() => r'3d9a9379cac9db47e0cf93dbb4db314de9dd3480';

/// AsyncNotifier untuk aksi autentikasi login.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [login] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.

abstract class _$LoginAuth extends $AsyncNotifier<void> {
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
