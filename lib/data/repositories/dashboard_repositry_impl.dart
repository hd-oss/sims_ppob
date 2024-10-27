import 'package:dartz/dartz.dart';
import '../models/banner_model.dart';
import '../models/service_model.dart';
import '../models/user_model.dart';

import '../../domain/repositories/dashbard_repository.dart';
import '../datasources/remote_datasources.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final RemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<ServiceModel>>> getService() async {
    return remoteDataSource.getService();
    
  }

  @override
  Future<Either<String, List<BannerModel>>> getBanner() async {
    return await remoteDataSource.getBanner();
  
  }

  @override
  Future<Either<String, String?>> getBalance() async {
    return await remoteDataSource.getBalance();
  }

  @override
  Future<Either<String, UserModel>> getProfile() async {
   final respons = await remoteDataSource.getProfile();
    return respons.fold((l) => Left(l),
        (r) => Right(UserModel.fromJson(r)));
  }
}
