import 'package:sims_ppob/data/models/history_model.dart';

import '../../common/result_state.dart';
import '../repositories/history_repository.dart';

class HistoryUseCase {
  final HistoryRepository purchesRepository;

  HistoryUseCase(this.purchesRepository);

  Future<ResultState<String>> getBalance() async {
    final result = await purchesRepository.getBalance();
    return result.fold(
      (message) => ResultState.error(message),
      (data) => ResultState.success(data),
    );
  }

  Future<ResultState<List<HistoryModel>>> getHistory(
    int offset,
    int limit,
    List<HistoryModel>? curentData,
    bool isShowMore,
  ) async {
    final result = await purchesRepository.getHistory(offset, limit);

    return result.fold(
      (message) => ResultState.error(message),
      (data) {
        final List<HistoryModel> dataMarge = [
          if (isShowMore) ...curentData ?? [],
          ...data,
        ];
        return ResultState.success(dataMarge);
      },
    );
  }
}
