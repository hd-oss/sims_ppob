import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/result_state.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../injection_container.dart';
import '../../controllers/login_controller.dart';

final loginProvider = StateNotifierProvider<LoginController, ResultState>((ref) {
  final loginUseCase = sl<LoginUseCase>();
  return LoginController(loginUseCase);
});
