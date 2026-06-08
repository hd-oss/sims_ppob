import 'package:flutter_riverpod/legacy.dart';

import '../../common/result_state.dart';
import '../../domain/usecases/topup_usecase.dart';

class TopupState {
  final ResultState<String>? topupResult;
  final ResultState<String>? balanceData;

  TopupState({
    this.topupResult,
    this.balanceData,
  });

  TopupState copyWith({
    ResultState<String>? topupResult,
    ResultState<String>? balanceData,
  }) {
    return TopupState(
        balanceData: balanceData ?? this.balanceData,
        topupResult: topupResult ?? this.topupResult);
  }
}

class TopupController extends StateNotifier<TopupState> {
  final TopupUseCase topupUseCase;
  TopupController(this.topupUseCase) : super(TopupState());

  Future<void> initState() async {
    state = state.copyWith(balanceData: ResultState.loading());
    try {
      final result = await topupUseCase.getBalance();
      state = state.copyWith(balanceData: result);
    } catch (e) {
      state = state.copyWith(balanceData: ResultState.error(e.toString()));
    }
  }

  Future<void> topupEvent(String amount) async {
    state = state.copyWith(topupResult: ResultState.loading(amount));

    try {
      final result = await topupUseCase.topupEvent(amount);
      state = state.copyWith(topupResult: result);
      initState();
    } catch (e) {
      state = state.copyWith(topupResult: ResultState.error(e.toString(), amount));
    }
  }
}
