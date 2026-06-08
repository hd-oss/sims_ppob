// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier state UI lokal untuk halaman profile.
///
/// Menyimpan flag `isEditEvent` (mode edit aktif/tidak) dengan nilai default
/// `false`.

@ProviderFor(ProfileUi)
final profileUiProvider = ProfileUiProvider._();

/// Notifier state UI lokal untuk halaman profile.
///
/// Menyimpan flag `isEditEvent` (mode edit aktif/tidak) dengan nilai default
/// `false`.
final class ProfileUiProvider extends $NotifierProvider<ProfileUi, bool> {
  /// Notifier state UI lokal untuk halaman profile.
  ///
  /// Menyimpan flag `isEditEvent` (mode edit aktif/tidak) dengan nilai default
  /// `false`.
  ProfileUiProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileUiProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileUiHash();

  @$internal
  @override
  ProfileUi create() => ProfileUi();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$profileUiHash() => r'57ff2473374f64e45e9d1ba63abaf8b31130aa4e';

/// Notifier state UI lokal untuk halaman profile.
///
/// Menyimpan flag `isEditEvent` (mode edit aktif/tidak) dengan nilai default
/// `false`.

abstract class _$ProfileUi extends $Notifier<bool> {
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

/// AsyncNotifier untuk profil pengguna.
///
/// `build` melakukan fetch profil awal. Profil dapat di-refresh dengan
/// `ref.invalidate(profileControllerProvider)` setelah edit profil/foto.

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

/// AsyncNotifier untuk profil pengguna.
///
/// `build` melakukan fetch profil awal. Profil dapat di-refresh dengan
/// `ref.invalidate(profileControllerProvider)` setelah edit profil/foto.
final class ProfileControllerProvider
    extends $AsyncNotifierProvider<ProfileController, UserModel> {
  /// AsyncNotifier untuk profil pengguna.
  ///
  /// `build` melakukan fetch profil awal. Profil dapat di-refresh dengan
  /// `ref.invalidate(profileControllerProvider)` setelah edit profil/foto.
  ProfileControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();
}

String _$profileControllerHash() => r'40742525626112d02d3ed1dd9856026a706bb73a';

/// AsyncNotifier untuk profil pengguna.
///
/// `build` melakukan fetch profil awal. Profil dapat di-refresh dengan
/// `ref.invalidate(profileControllerProvider)` setelah edit profil/foto.

abstract class _$ProfileController extends $AsyncNotifier<UserModel> {
  FutureOr<UserModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserModel>, UserModel>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<UserModel>, UserModel>,
        AsyncValue<UserModel>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// AsyncNotifier untuk aksi update profil dan upload foto.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [editProfile] dan [editImage] mengekspos keadaan loading, lalu data/error
/// melalui `AsyncValue`. Setelah aksi berhasil, profil di-refresh melalui
/// invalidasi `profileControllerProvider`.

@ProviderFor(ProfileAction)
final profileActionProvider = ProfileActionProvider._();

/// AsyncNotifier untuk aksi update profil dan upload foto.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [editProfile] dan [editImage] mengekspos keadaan loading, lalu data/error
/// melalui `AsyncValue`. Setelah aksi berhasil, profil di-refresh melalui
/// invalidasi `profileControllerProvider`.
final class ProfileActionProvider
    extends $AsyncNotifierProvider<ProfileAction, void> {
  /// AsyncNotifier untuk aksi update profil dan upload foto.
  ///
  /// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
  /// [editProfile] dan [editImage] mengekspos keadaan loading, lalu data/error
  /// melalui `AsyncValue`. Setelah aksi berhasil, profil di-refresh melalui
  /// invalidasi `profileControllerProvider`.
  ProfileActionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileActionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileActionHash();

  @$internal
  @override
  ProfileAction create() => ProfileAction();
}

String _$profileActionHash() => r'be7bde13b45863742af4d67298d2988a395de848';

/// AsyncNotifier untuk aksi update profil dan upload foto.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [editProfile] dan [editImage] mengekspos keadaan loading, lalu data/error
/// melalui `AsyncValue`. Setelah aksi berhasil, profil di-refresh melalui
/// invalidasi `profileControllerProvider`.

abstract class _$ProfileAction extends $AsyncNotifier<void> {
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
