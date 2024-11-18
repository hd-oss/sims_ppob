import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/result_state.dart';
import '../../data/models/banner_model.dart';
import '../../data/models/service_model.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/dashboard_usecase.dart';

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

      state = state.copyWith(userData: result);
    } on Exception catch (e) {
      state = state.copyWith(userData: ResultState.error(e.toString()));
    }
  }

  Future<void> getService() async {
    try {
      final result = await dashBoardUseCase.getService();

      state = state.copyWith(serviceData: result);
    } on Exception catch (e) {
      state = state.copyWith(userData: ResultState.error(e.toString()));
    }
  }

  Future<void> getBalance() async {
    try {
      final result = await dashBoardUseCase.getBalance();

      state = state.copyWith(balanceData: result);
    } on Exception catch (e) {
      state = state.copyWith(userData: ResultState.error(e.toString()));
    }
  }

  Future<void> getBanner() async {
    try {
      final result = await dashBoardUseCase.getBanner();

      state = state.copyWith(bannerData: result);
    } on Exception catch (e) {
      state = state.copyWith(userData: ResultState.error(e.toString()));
    }
  }

  void hideSaldo() => state = state.copyWith(hideSaldo: !state.hideSaldo);
}
