import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/login_usecase.dart';
import '../../../injection_container.dart';
import '../../controllers/auth_controller.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final loginUseCase = sl<LoginUseCase>();
  return AuthController(loginUseCase);
});
