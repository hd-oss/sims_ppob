// lib/presentation/controllers/auth_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login_usecase.dart';

class AuthState {
  final bool isLoading;
  final String? error;

  AuthState({this.isLoading = false, this.error});
}

class AuthController extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;

  AuthController(this.loginUseCase) : super(AuthState());

  Future<void> login(String username, String password) async {
    state = AuthState(isLoading: true);
    try {
      final user = await loginUseCase.execute(username, password);
      user.fold(
        (message) => AuthState(error: message),
        (data) => loginUseCase.saveToken(data.token!),
      );
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  void logout() {
    state = AuthState();
  }
}
