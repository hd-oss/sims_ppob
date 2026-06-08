import 'package:dartz/dartz.dart';
import '../models/history_model.dart';

import '../../domain/repositories/history_repository.dart';
import '../datasources/remote_datasources.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final RemoteDataSource remoteDataSource;

  HistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, String>> getBalance() async {
    final result = await remoteDataSource.getBalance();
    // Konversi nullable String? ke non-nullable String dengan fallback '0'
    return result.fold(
      (error) => Left(error),
      (balance) => Right(balance ?? '0'),
    );
  }

  @override
  Future<Either<String, List<HistoryModel>>> getHistory(
      int offset, int limit) async {
    return await remoteDataSource.getHistory(offset, limit);
  }
}
