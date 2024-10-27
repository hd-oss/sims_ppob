import 'package:dartz/dartz.dart';

import '../../common/secure_storage_helper.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote_datasources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  final SecureStorageHelper secureStorageHelper;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorageHelper,
  });

  @override
  Future<Either<String, String>> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<void> saveToken(String token) async => await secureStorageHelper.writeToken(token);

  @override
  Future<void> deleteToken() async => await secureStorageHelper.deleteToken();
}
