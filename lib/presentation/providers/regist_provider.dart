import 'package:flutter_riverpod/legacy.dart';

import '../../domain/usecases/regist_usecase.dart';
import '../../injection_container.dart';
import '../controllers/regist_controller.dart';

final registProvider = StateNotifierProvider<RegistController, RegistState>(
    (ref) => RegistController(sl<RegistUseCase>()));
