import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/async_value_x.dart';
import '../../common/result_state.dart';
import '../../data/models/banner_model.dart';
import '../../data/models/service_model.dart';
import '../../data/models/user_model.dart';
import '../../di/usecase_providers.dart';
import '../../domain/usecases/dashboard_usecase.dart';

part 'dashboard_controller.g.dart';

// ---------------------------------------------------------------------------
// Provider granular baru (codegen)
// ---------------------------------------------------------------------------

/// Notifier state UI lokal untuk halaman dashboard.
///
/// Menyimpan flag `hideSaldo` dengan nilai default `true`.
@riverpod
class DashboardUi extends _$DashboardUi {
  @override
  bool build() => true; // hideSaldo default true

  /// Membalik nilai `hideSaldo` (involutif: dua kali toggle kembali semula).
  void toggle() => state = !state;
}

/// AsyncNotifier untuk data profil pengguna di dashboard.
///
/// `build` melakukan fetch profil awal via `DashBoardUseCase.getProfile()`.
@riverpod
class UserController extends _$UserController {
  @override
  FutureOr<UserModel> build() async {
    final result = await ref.watch(dashBoardUseCaseProvider).getProfile();
    return unwrapEither(result);
  }
}

/// AsyncNotifier untuk saldo pengguna di dashboard.
///
/// `build` melakukan fetch saldo awal via `DashBoardUseCase.getBalance()`.
@riverpod
class BalanceController extends _$BalanceController {
  @override
  FutureOr<String> build() async {
    final result = await ref.watch(dashBoardUseCaseProvider).getBalance();
    return unwrapEither(result);
  }
}

/// AsyncNotifier untuk daftar banner di dashboard.
///
/// `build` melakukan fetch banner awal via `DashBoardUseCase.getBanner()`.
@riverpod
class BannerController extends _$BannerController {
  @override
  FutureOr<List<BannerModel>> build() async {
    final result = await ref.watch(dashBoardUseCaseProvider).getBanner();
    return unwrapEither(result);
  }
}

/// AsyncNotifier untuk daftar layanan di dashboard.
///
/// `build` melakukan fetch layanan awal via `DashBoardUseCase.getService()`.
@riverpod
class ServiceController extends _$ServiceController {
  @override
  FutureOr<List<ServiceModel>> build() async {
    final result = await ref.watch(dashBoardUseCaseProvider).getService();
    return unwrapEither(result);
  }
}

// ---------------------------------------------------------------------------
// Artefak lama (StateNotifier) dipertahankan sementara agar aplikasi tetap
// dapat dikompilasi selama transisi. Akan dihapus pada langkah pembersihan
// (lihat task 11.2 / 14).
// ---------------------------------------------------------------------------

class DashboardState {
  final ResultState<UserModel>? userData;
  final ResultState<List<BannerModel>>? bannerData;
  final ResultState<String>? balanceData;
  final ResultState<List<ServiceModel>>? serviceData;
  final bool hideSaldo;

  DashboardState(
      {this.hideSaldo = true,
      this.userData,
      this.bannerData,
      this.balanceData,
      this.serviceData});

  DashboardState copyWith(
      {final ResultState<UserModel>? userData,
      ResultState<List<BannerModel>>? bannerData,
      ResultState<String>? balanceData,
      ResultState<List<ServiceModel>>? serviceData,
      bool? hideSaldo}) {
    return DashboardState(
        userData: userData ?? this.userData,
        balanceData: balanceData ?? this.balanceData,
        serviceData: serviceData ?? this.serviceData,
        bannerData: bannerData ?? this.bannerData,
        hideSaldo: hideSaldo ?? this.hideSaldo);
  }
}

class DashboardController extends StateNotifier<DashboardState> {
  final DashBoardUseCase dashBoardUseCase;

  DashboardController(this.dashBoardUseCase) : super(DashboardState());

  Future<void> initState() async {
    final nState = state.copyWith(
        userData: ResultState.loading(),
        balanceData: ResultState.loading(),
        bannerData: ResultState.loading(),
        serviceData: ResultState.loading());

    state = nState;

    getProfile();
    getBalance();
    getService();
    getBanner();
  }

  Future<void> getProfile() async {
    try {
      final result = await dashBoardUseCase.getProfile();
      state = state.copyWith(
        userData: result.fold(
          (message) => ResultState.error(message),
          (data) => ResultState.success(data),
        ),
      );
    } catch (e) {
      state = state.copyWith(userData: ResultState.error(e.toString()));
    }
  }

  Future<void> getService() async {
    try {
      final result = await dashBoardUseCase.getService();
      state = state.copyWith(
        serviceData: result.fold(
          (message) => ResultState.error(message),
          (data) => ResultState.success(data),
        ),
      );
    } catch (e) {
      state = state.copyWith(serviceData: ResultState.error(e.toString()));
    }
  }

  Future<void> getBalance() async {
    try {
      final result = await dashBoardUseCase.getBalance();
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

  Future<void> getBanner() async {
    try {
      final result = await dashBoardUseCase.getBanner();
      state = state.copyWith(
        bannerData: result.fold(
          (message) => ResultState.error(message),
          (data) => ResultState.success(data),
        ),
      );
    } catch (e) {
      state = state.copyWith(bannerData: ResultState.error(e.toString()));
    }
  }

  void hideSaldo() => state = state.copyWith(hideSaldo: !state.hideSaldo);
}
