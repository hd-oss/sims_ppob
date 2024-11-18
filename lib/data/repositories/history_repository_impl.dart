import 'package:dartz/dartz.dart';
import '../models/history_model.dart';

import '../../domain/repositories/history_repository.dart';
import '../datasources/remote_datasources.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final RemoteDataSource remoteDataSource;

  HistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, String?>> getBalance() async {
    return await remoteDataSource.getBalance();
  }

  @override
  Future<Either<String, List<HistoryModel>>> getHistory(
      int offset, int limit) async {
    return await remoteDataSource.getHistory(offset, limit);
  }
}
