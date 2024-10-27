import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/result_state.dart';
import '../../domain/usecases/auth_usecase.dart';

class LoginState {
  final bool isHide;
  final ResultState<String>? loginResult;

  LoginState({this.isHide = true, this.loginResult});

  LoginState copyWith({bool? isHide, ResultState<String>? loginResult}) {
    return LoginState(
        isHide: isHide ?? this.isHide,
        loginResult: loginResult ?? this.loginResult);
  }
}

class LoginController extends StateNotifier<LoginState> {
  final AuthUseCase loginUseCase;

  LoginController(this.loginUseCase) : super(LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(loginResult: ResultState.loading());

    try {
      final result = await loginUseCase.login(email, password);

      state = state.copyWith(loginResult: result);
    } catch (e) {
      state = state.copyWith(loginResult: ResultState.error(e.toString()));
    }
  }

  void hidePassword() => state = state.copyWith(isHide: !state.isHide);

  void resetState() => state = LoginState();
}
