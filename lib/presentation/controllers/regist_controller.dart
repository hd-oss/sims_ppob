import 'package:flutter_riverpod/legacy.dart';
import 'package:sims_ppob/data/models/regist_model.dart';

import '../../common/result_state.dart';
import '../../domain/usecases/regist_usecase.dart';

class RegistState {
  final bool isHide;
  final bool isHideCofirm;
  final RegistModel? params;
  final ResultState<String>? registResult;

  RegistState(
      {this.params, this.isHideCofirm = true, this.isHide = true, this.registResult});

  RegistState copyWith({
    bool? isHide,
    bool? isHideCofirm,
    ResultState<String>? registResult,
    RegistModel? params,
  }) {
    return RegistState(
        isHide: isHide ?? this.isHide,
        params: params ?? this.params,
        isHideCofirm: isHideCofirm ?? this.isHideCofirm,
        registResult: registResult ?? this.registResult);
  }
}

class RegistController extends StateNotifier<RegistState> {
  final RegistUseCase loginUseCase;

  RegistController(this.loginUseCase) : super(RegistState());

  Future<void> regist() async {
    state = state.copyWith(registResult: ResultState.loading());
    

    try {
      final result = await loginUseCase.regist(state.params);

      state = state.copyWith(registResult: result);
    } catch (e) {
      state = state.copyWith(registResult: ResultState.error(e.toString()));
    }
  }

  void setParams(String key, String value) {
    final params =  state.params?.toJson() ?? {};
    params[key] = value;
    state = state.copyWith(params: RegistModel.fromJson(params));
  }

  void hidePassword() =>
      state = state.copyWith(isHide: !state.isHide);

  void hidePasswordConfrm() =>
      state = state.copyWith(isHideCofirm: !state.isHideCofirm);

  void resetState ()=> state= RegistState();
  
}
