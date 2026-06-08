import 'package:dartz/dartz.dart';
import 'package:sims_ppob/data/models/history_model.dart';

import '../repositories/history_repository.dart';

class HistoryUseCase {
  final HistoryRepository purchesRepository;

  HistoryUseCase(this.purchesRepository);

  Future<Either<String, String>> getBalance() async {
    return await purchesRepository.getBalance();
  }

  Future<Either<String, List<HistoryModel>>> getHistory(
    int offset,
    int limit,
    List<HistoryModel>? curentData,
    bool isShowMore,
  ) async {
    final result = await purchesRepository.getHistory(offset, limit);

    return result.fold(
      (message) => Left(message),
      (data) {
        final List<HistoryModel> dataMarge = [
          if (isShowMore) ...curentData ?? [],
          ...data,
        ];
        return Right(dataMarge);
      },
    );
  }
}
