import 'package:dartz/dartz.dart';
import 'package:sims_ppob/data/models/banner_model.dart';
import 'package:sims_ppob/data/models/service_model.dart';
import 'package:sims_ppob/domain/repositories/dashbard_repository.dart';

import '../../data/models/user_model.dart';

class DashBoardUseCase {
  final DashboardRepository dashboardRepository;

  DashBoardUseCase(this.dashboardRepository);

  Future<Either<String, UserModel>> getProfile() async {
    return dashboardRepository.getProfile();
  }

  Future<Either<String, String>> getBalance() async {
    final result = await dashboardRepository.getBalance();
    return result.map((balance) => balance ?? '0');
  }

  Future<Either<String, List<ServiceModel>>> getService() async {
    return dashboardRepository.getService();
  }

  Future<Either<String, List<BannerModel>>> getBanner() async {
    return dashboardRepository.getBanner();
  }
}