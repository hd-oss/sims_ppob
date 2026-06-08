import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/dashboard_repositry_impl.dart';
import '../data/repositories/history_repository_impl.dart';
import '../data/repositories/profile_repository_impl.dart';
import '../data/repositories/purches_repository_impl.dart';
import '../data/repositories/regist_repository_impl.dart';
import '../data/repositories/topup_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/dashbard_repository.dart';
import '../domain/repositories/history_repository.dart';
import '../domain/repositories/profile_repository.dart';
import '../domain/repositories/purches_repository.dart';
import '../domain/repositories/regist_repository.dart';
import '../domain/repositories/topup_repository.dart';
import 'core_providers.dart';

part 'repository_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
      remoteDataSource: ref.watch(remoteDataSourceProvider),
      secureStorageHelper: ref.watch(secureStorageProvider),
    );

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) => ProfileRepositoryImpl(
      remoteDataSource: ref.watch(remoteDataSourceProvider),
    );

@Riverpod(keepAlive: true)
RegistRepository registRepository(Ref ref) => RegistRepositoryImpl(
      remoteDataSource: ref.watch(remoteDataSourceProvider),
    );

@Riverpod(keepAlive: true)
DashboardRepository dashboardRepository(Ref ref) => DashboardRepositoryImpl(
      remoteDataSource: ref.watch(remoteDataSourceProvider),
    );

@Riverpod(keepAlive: true)
TopupRepository topupRepository(Ref ref) => TopupRepositoryImpl(
      remoteDataSource: ref.watch(remoteDataSourceProvider),
    );

@Riverpod(keepAlive: true)
PurchesRepository purchesRepository(Ref ref) => PurchesRepositoryImpl(
      remoteDataSource: ref.watch(remoteDataSourceProvider),
    );

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(Ref ref) => HistoryRepositoryImpl(
      remoteDataSource: ref.watch(remoteDataSourceProvider),
    );
