import 'package:dartz/dartz.dart';

import '../../domain/repositories/topup_repository.dart';
import '../datasources/remote_datasources.dart';

class TopupRepositoryImpl implements TopupRepository {
  final RemoteDataSource remoteDataSource;

  TopupRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, String?>> getBalance() async {
    return await remoteDataSource.getBalance();
  }
  
  @override
  Future<Either<String, String?>> topupEvent(String amount) async {
    return await remoteDataSource.topUp(amount);
  }

}
