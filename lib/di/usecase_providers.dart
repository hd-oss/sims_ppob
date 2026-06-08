import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/usecases/auth_usecase.dart';
import '../domain/usecases/dashboard_usecase.dart';
import '../domain/usecases/history_usecase.dart';
import '../domain/usecases/profile_usecase.dart';
import '../domain/usecases/purches_usecase.dart';
import '../domain/usecases/regist_usecase.dart';
import '../domain/usecases/topup_usecase.dart';
import 'repository_providers.dart';

part 'usecase_providers.g.dart';

@Riverpod(keepAlive: true)
AuthUseCase authUseCase(Ref ref) =>
    AuthUseCase(ref.watch(authRepositoryProvider));

@Riverpod(keepAlive: true)
ProfileUseCase profileUseCase(Ref ref) =>
    ProfileUseCase(ref.watch(profileRepositoryProvider));

@Riverpod(keepAlive: true)
RegistUseCase registUseCase(Ref ref) =>
    RegistUseCase(ref.watch(registRepositoryProvider));

@Riverpod(keepAlive: true)
DashBoardUseCase dashBoardUseCase(Ref ref) =>
    DashBoardUseCase(ref.watch(dashboardRepositoryProvider));

@Riverpod(keepAlive: true)
TopupUseCase topupUseCase(Ref ref) =>
    TopupUseCase(ref.watch(topupRepositoryProvider));

@Riverpod(keepAlive: true)
PurchesUseCase purchesUseCase(Ref ref) =>
    PurchesUseCase(ref.watch(purchesRepositoryProvider));

@Riverpod(keepAlive: true)
HistoryUseCase historyUseCase(Ref ref) =>
    HistoryUseCase(ref.watch(historyRepositoryProvider));
