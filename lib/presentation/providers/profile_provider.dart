import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sims_ppob/domain/usecases/auth_usecase.dart';

import '../../domain/usecases/profile_usecase.dart';
import '../../injection_container.dart';
import '../controllers/profile_controller.dart';

final profileProvider = StateNotifierProvider<ProfileController, ProfileState>(
    (ref) => ProfileController(sl<ProfileUseCase>(), sl<AuthUseCase>()));
