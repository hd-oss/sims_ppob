import 'package:dartz/dartz.dart';

import '../../domain/repositories/profile_repository.dart';
import '../datasources/remote_datasources.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final RemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, Map<String, dynamic>>> getProfile() async {
    return await remoteDataSource.getProfile();
  }

  @override
  Future<Either<String, Map<String, dynamic>>> editProfile(dynamic prameters) async {
    return await remoteDataSource.editProfile(prameters);
  }
  
  @override
  Future<Either<String, Map<String, dynamic>>> editImage(dynamic prameters) async {
    return await remoteDataSource.editImage(prameters);
  }
}
