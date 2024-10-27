import '../../common/result_state.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<ResultState<String>> login(String username, String password) async {
    final result = await repository.login(username, password);
    return result.fold(
      (message) => ResultState.error(message),
      (data) => repository
          .saveToken(data)
          .then((value) => ResultState.success('Berhasil login')),
    );
  }
  Future<void> logout() async => await repository.deleteToken();
}
