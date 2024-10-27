import 'package:dartz/dartz.dart';
import 'package:sims_ppob/data/models/banner_model.dart';
import 'package:sims_ppob/data/models/service_model.dart';
import 'package:sims_ppob/data/models/user_model.dart';

abstract class DashboardRepository{
  Future<Either<String, List<ServiceModel>>> getService();
  Future<Either<String, List<BannerModel>>> getBanner();
  Future<Either<String, String?>> getBalance();
  Future<Either<String, UserModel>> getProfile();
}