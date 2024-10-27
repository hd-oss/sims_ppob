import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sims_ppob/domain/usecases/dashboard_usecase.dart';

import '../../injection_container.dart';
import '../controllers/dashboard_controller.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardController, DashboardState>(
        (ref) => DashboardController(sl<DashBoardUseCase>()));
