import 'package:dartz/dartz.dart';

import '../../domain/repositories/regist_repository.dart';
import '../datasources/remote_datasources.dart';

class RegistRepositoryImpl implements RegistRepository {
  final RemoteDataSource remoteDataSource;

  RegistRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<String, String>> regist(Map<String, dynamic> params) async {
    return await remoteDataSource.regist(params);
  }

}
