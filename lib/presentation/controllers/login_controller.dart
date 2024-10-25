import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/result_state.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginController extends StateNotifier<ResultState<String>> {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase) : super(ResultState());

  Future<void> login(String username, String password) async {
    state = ResultState.loading();

    try {
      final user = await loginUseCase.execute(username, password);

      user.fold(
        (message) => state = ResultState.error(message),
        (data) => loginUseCase
            .saveToken(data.token!)
            .then((value) => state = ResultState.success('Berhasil login')),
      );
    } catch (e) {
      state = ResultState.error(e.toString());
    }
  }
}
