import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'common/secure_storage_helper.dart';
import 'data/datasources/api_service.dart';
import 'data/datasources/remote_datasources.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login_usecase.dart';

final sl = GetIt.instance;

void init() {
  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: sl<RemoteDataSource>(),
        secureStorageHelper: sl<SecureStorageHelper>(),
      ));

  // Data sources
  sl.registerLazySingleton<ApiService>(
      () => ApiService(sl<Dio>(), sl<SecureStorageHelper>()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(apiService: sl<ApiService>()));

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => SecureStorageHelper());

  // Register Repository
  sl.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
        remoteDataSource: sl<RemoteDataSource>(),
        secureStorageHelper: sl<SecureStorageHelper>()),
  );

  // Register UseCase
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepositoryImpl>()),
  );
}
