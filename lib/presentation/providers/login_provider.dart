import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/auth_usecase.dart';
import '../../injection_container.dart';
import '../controllers/login_controller.dart';

final loginProvider = StateNotifierProvider<LoginController, LoginState>(
    (ref) => LoginController(sl<AuthUseCase>()));
