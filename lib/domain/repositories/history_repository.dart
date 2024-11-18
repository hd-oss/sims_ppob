import 'package:dartz/dartz.dart';
import 'package:sims_ppob/data/models/history_model.dart';

abstract class HistoryRepository {
  Future<Either<String, String?>> getBalance();
  Future<Either<String, List<HistoryModel>>> getHistory(int offset, int limit);
}
