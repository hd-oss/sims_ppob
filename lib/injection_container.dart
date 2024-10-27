import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sims_ppob/data/repositories/profile_repository_impl.dart';
import 'package:sims_ppob/data/repositories/regist_repository_impl.dart';
import 'package:sims_ppob/domain/repositories/regist_repository.dart';
import 'package:sims_ppob/domain/usecases/profile_usecase.dart';

import 'common/secure_storage_helper.dart';
import 'data/datasources/api_service.dart';
import 'data/datasources/remote_datasources.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/auth_usecase.dart';
import 'domain/usecases/regist_usecase.dart';

final sl = GetIt.instance;

void init() {
   // Data sources
  sl.registerLazySingleton<ApiService>(
      () => ApiService(sl<Dio>(), sl<SecureStorageHelper>()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(apiService: sl<ApiService>()));

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => SecureStorageHelper());

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      remoteDataSource: sl<RemoteDataSource>(),
      secureStorageHelper: sl<SecureStorageHelper>()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: sl<RemoteDataSource>()));
  sl.registerLazySingleton<RegistRepository>(
      () => RegistRepositoryImpl(remoteDataSource: sl<RemoteDataSource>()));

  // Register Repository
  sl.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl(
      remoteDataSource: sl<RemoteDataSource>(),
      secureStorageHelper: sl<SecureStorageHelper>()));
  sl.registerLazySingleton<ProfileRepositoryImpl>(
      () => ProfileRepositoryImpl(remoteDataSource: sl<RemoteDataSource>()));
  sl.registerLazySingleton<RegistRepositoryImpl>(
      () => RegistRepositoryImpl(remoteDataSource: sl<RemoteDataSource>()));

  // Register UseCase
  sl.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton<ProfileUseCase>(
      () => ProfileUseCase(sl<ProfileRepositoryImpl>()));
  sl.registerLazySingleton<RegistUseCase>(
      () => RegistUseCase(sl<RegistRepositoryImpl>()));
}
