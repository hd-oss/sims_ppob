import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/async_value_x.dart';
import '../../data/models/banner_model.dart';
import '../../data/models/service_model.dart';
import '../../data/models/user_model.dart';
import '../../di/usecase_providers.dart';

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
