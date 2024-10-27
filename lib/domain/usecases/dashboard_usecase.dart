import 'package:sims_ppob/data/models/banner_model.dart';
import 'package:sims_ppob/data/models/service_model.dart';
import 'package:sims_ppob/domain/repositories/dashbard_repository.dart';

import '../../common/result_state.dart';
import '../../data/models/user_model.dart';

class DashBoardUseCase {
   final DashboardRepository dashboardRepository;

  DashBoardUseCase(this.dashboardRepository);


  Future<ResultState<UserModel>> getProfile() async {
    final result = await dashboardRepository.getProfile();
    return result.fold(
      (message) => ResultState.error(message),
      (data) => ResultState.success(data),
    );
  }
  Future<ResultState<String>> getBalance() async {
    final result = await dashboardRepository.getBalance();
    return result.fold(
      (message) => ResultState.error(message),
      (data) => ResultState.success(data),
    );
  }
  Future<ResultState<List<ServiceModel>>> getService() async {
    final result = await dashboardRepository.getService();
    return result.fold(
      (message) => ResultState.error(message),
      (data) => ResultState.success(data),
    );
  }
  Future<ResultState<List<BannerModel>>> getBanner() async {
    final result = await dashboardRepository.getBanner();
    return result.fold(
      (message) => ResultState.error(message),
      (data) => ResultState.success(data),
    );
  }

  
}