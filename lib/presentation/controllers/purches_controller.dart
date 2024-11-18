import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/result_state.dart';
import '../../domain/usecases/purches_usecase.dart';

class PurchesState {
  final ResultState<String>? purchesResult;
  final ResultState<String>? balanceData;

  PurchesState({
    this.purchesResult,
    this.balanceData,
  });

  PurchesState copyWith({
    ResultState<String>? purchesResult,
    ResultState<String>? balanceData,
  }) {
    return PurchesState(
        balanceData: balanceData ?? this.balanceData,
        purchesResult: purchesResult ?? this.purchesResult);
  }
}

class PurchesController extends StateNotifier<PurchesState> {
  final PurchesUseCase purchesUseCase;
  PurchesController(this.purchesUseCase) : super(PurchesState());

  Future<void> initState() async {
    state = state.copyWith(balanceData: ResultState.loading());
    try {
      final result = await purchesUseCase.getBalance();
      state = state.copyWith(balanceData: result);
    } catch (e) {
      state = state.copyWith(balanceData: ResultState.error(e.toString()));
    }
  }

  Future<void> purchesEvent(String serviceCode) async {
    state = state.copyWith(purchesResult: ResultState.loading(serviceCode));

    try {
      final result = await purchesUseCase.purchesEvent(serviceCode);
      state = state.copyWith(purchesResult: result);
      initState();
    } catch (e) {
      state = state.copyWith(purchesResult: ResultState.error(e.toString(), serviceCode));
    }
  }
}
