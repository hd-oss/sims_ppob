// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier state UI lokal untuk halaman dashboard.
///
/// Menyimpan flag `hideSaldo` dengan nilai default `true`.

@ProviderFor(DashboardUi)
final dashboardUiProvider = DashboardUiProvider._();

/// Notifier state UI lokal untuk halaman dashboard.
///
/// Menyimpan flag `hideSaldo` dengan nilai default `true`.
final class DashboardUiProvider extends $NotifierProvider<DashboardUi, bool> {
  /// Notifier state UI lokal untuk halaman dashboard.
  ///
  /// Menyimpan flag `hideSaldo` dengan nilai default `true`.
  DashboardUiProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dashboardUiProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dashboardUiHash();

  @$internal
  @override
  DashboardUi create() => DashboardUi();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$dashboardUiHash() => r'56efe1cd1432655db89e28bb19e2e41d99cd3723';

/// Notifier state UI lokal untuk halaman dashboard.
///
/// Menyimpan flag `hideSaldo` dengan nilai default `true`.

abstract class _$DashboardUi extends $Notifier<bool> {
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

/// AsyncNotifier untuk data profil pengguna di dashboard.
///
/// `build` melakukan fetch profil awal via `DashBoardUseCase.getProfile()`.

@ProviderFor(UserController)
final userControllerProvider = UserControllerProvider._();

/// AsyncNotifier untuk data profil pengguna di dashboard.
///
/// `build` melakukan fetch profil awal via `DashBoardUseCase.getProfile()`.
final class UserControllerProvider
    extends $AsyncNotifierProvider<UserController, UserModel> {
  /// AsyncNotifier untuk data profil pengguna di dashboard.
  ///
  /// `build` melakukan fetch profil awal via `DashBoardUseCase.getProfile()`.
  UserControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userControllerHash();

  @$internal
  @override
  UserController create() => UserController();
}

String _$userControllerHash() => r'b75a2e0db40b139004d49f6c63f90b75593ee7c0';

/// AsyncNotifier untuk data profil pengguna di dashboard.
///
/// `build` melakukan fetch profil awal via `DashBoardUseCase.getProfile()`.

abstract class _$UserController extends $AsyncNotifier<UserModel> {
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

/// AsyncNotifier untuk saldo pengguna di dashboard.
///
/// `build` melakukan fetch saldo awal via `DashBoardUseCase.getBalance()`.

@ProviderFor(BalanceController)
final balanceControllerProvider = BalanceControllerProvider._();

/// AsyncNotifier untuk saldo pengguna di dashboard.
///
/// `build` melakukan fetch saldo awal via `DashBoardUseCase.getBalance()`.
final class BalanceControllerProvider
    extends $AsyncNotifierProvider<BalanceController, String> {
  /// AsyncNotifier untuk saldo pengguna di dashboard.
  ///
  /// `build` melakukan fetch saldo awal via `DashBoardUseCase.getBalance()`.
  BalanceControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'balanceControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$balanceControllerHash();

  @$internal
  @override
  BalanceController create() => BalanceController();
}

String _$balanceControllerHash() => r'1510fbfad5ca8e52d5643ee06beadefbcb58e850';

/// AsyncNotifier untuk saldo pengguna di dashboard.
///
/// `build` melakukan fetch saldo awal via `DashBoardUseCase.getBalance()`.

abstract class _$BalanceController extends $AsyncNotifier<String> {
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

/// AsyncNotifier untuk daftar banner di dashboard.
///
/// `build` melakukan fetch banner awal via `DashBoardUseCase.getBanner()`.

@ProviderFor(BannerController)
final bannerControllerProvider = BannerControllerProvider._();

/// AsyncNotifier untuk daftar banner di dashboard.
///
/// `build` melakukan fetch banner awal via `DashBoardUseCase.getBanner()`.
final class BannerControllerProvider
    extends $AsyncNotifierProvider<BannerController, List<BannerModel>> {
  /// AsyncNotifier untuk daftar banner di dashboard.
  ///
  /// `build` melakukan fetch banner awal via `DashBoardUseCase.getBanner()`.
  BannerControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'bannerControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$bannerControllerHash();

  @$internal
  @override
  BannerController create() => BannerController();
}

String _$bannerControllerHash() => r'7a8897d177436b25ea5d1f7eae9b5644e938b923';

/// AsyncNotifier untuk daftar banner di dashboard.
///
/// `build` melakukan fetch banner awal via `DashBoardUseCase.getBanner()`.

abstract class _$BannerController extends $AsyncNotifier<List<BannerModel>> {
  FutureOr<List<BannerModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<BannerModel>>, List<BannerModel>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<BannerModel>>, List<BannerModel>>,
        AsyncValue<List<BannerModel>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// AsyncNotifier untuk daftar layanan di dashboard.
///
/// `build` melakukan fetch layanan awal via `DashBoardUseCase.getService()`.

@ProviderFor(ServiceController)
final serviceControllerProvider = ServiceControllerProvider._();

/// AsyncNotifier untuk daftar layanan di dashboard.
///
/// `build` melakukan fetch layanan awal via `DashBoardUseCase.getService()`.
final class ServiceControllerProvider
    extends $AsyncNotifierProvider<ServiceController, List<ServiceModel>> {
  /// AsyncNotifier untuk daftar layanan di dashboard.
  ///
  /// `build` melakukan fetch layanan awal via `DashBoardUseCase.getService()`.
  ServiceControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'serviceControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$serviceControllerHash();

  @$internal
  @override
  ServiceController create() => ServiceController();
}

String _$serviceControllerHash() => r'd42cb839d7353d1f6cd5592d6ace9283b14a1df8';

/// AsyncNotifier untuk daftar layanan di dashboard.
///
/// `build` melakukan fetch layanan awal via `DashBoardUseCase.getService()`.

abstract class _$ServiceController extends $AsyncNotifier<List<ServiceModel>> {
  FutureOr<List<ServiceModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ServiceModel>>, List<ServiceModel>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<ServiceModel>>, List<ServiceModel>>,
        AsyncValue<List<ServiceModel>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
