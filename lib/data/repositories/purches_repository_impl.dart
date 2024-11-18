import 'package:dartz/dartz.dart';

import '../../domain/repositories/purches_repository.dart';
import '../datasources/remote_datasources.dart';

class PurchesRepositoryImpl implements PurchesRepository {
  final RemoteDataSource remoteDataSource;

  PurchesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, String?>> getBalance() async {
    return await remoteDataSource.getBalance();
  }
  
  @override
  Future<Either<String, String?>> purchesEvent(String serviceCode) async {
    return await remoteDataSource.purches(serviceCode);
  }

}
