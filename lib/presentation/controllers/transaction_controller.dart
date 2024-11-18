import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/result_state.dart';
import '../../data/models/history_model.dart';
import '../../domain/usecases/history_usecase.dart';

class TransactionState {
  final ResultState<List<HistoryModel>>? historyData;
  final ResultState<String>? balanceData;
  final bool isShowMore;
  final int offset;
  final int limit;

  TransactionState({
    this.historyData,
    this.balanceData,
    this.offset = 0,
    this.isShowMore = false,
    this.limit = 5,
  });

  TransactionState copyWith(
      {ResultState<List<HistoryModel>>? historyData,
      ResultState<String>? balanceData,
      bool? isShowMore,
      int? offset,
      int? limit}) {
    return TransactionState(
        balanceData: balanceData ?? this.balanceData,
        historyData: historyData ?? this.historyData,
        isShowMore: isShowMore ?? this.isShowMore,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset);
  }
}

class TransactionController extends StateNotifier<TransactionState> {
  final HistoryUseCase historyUseCase;
  TransactionController(this.historyUseCase) : super(TransactionState());

  Future<void> initState() async {
    state = state.copyWith(balanceData: ResultState.loading());
    try {
      final result = await historyUseCase.getBalance();
      state = state.copyWith(balanceData: result);
    } catch (e) {
      state = state.copyWith(balanceData: ResultState.error(e.toString()));
    }
  }

  Future<void> getHistory() async {
    state = state.copyWith(
      historyData: state.isShowMore ? null : ResultState.loading(),
    );

    try {
      final result = await historyUseCase.getHistory(
          state.offset, state.limit, state.historyData?.data, state.isShowMore);

      state = state.copyWith(historyData: result);
    } catch (e) {
      state = state.copyWith(historyData: ResultState.error(e.toString()));
    }
  }

  Future<void> showMore() async {
    state = state.copyWith(limit: state.limit + 5 , offset: state.offset + 5, isShowMore: true);
    getHistory().then((value) => state = state.copyWith(isShowMore: false));
  }
}
