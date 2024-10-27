import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/topup_usecase.dart';
import '../../injection_container.dart';
import '../controllers/topup_controller.dart';

final topupProvider = StateNotifierProvider<TopupController, TopupState>(
    (ref) => TopupController(sl<TopupUseCase>()));
