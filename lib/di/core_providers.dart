import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../common/secure_storage_helper.dart';
import '../data/datasources/api_service.dart';
import '../data/datasources/remote_datasources.dart';

part 'core_providers.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) => Dio();

@Riverpod(keepAlive: true)
SecureStorageHelper secureStorage(Ref ref) => SecureStorageHelper();

@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) => ApiService(
      ref.watch(dioProvider),
      ref.watch(secureStorageProvider),
    );

@Riverpod(keepAlive: true)
RemoteDataSource remoteDataSource(Ref ref) =>
    RemoteDataSource(apiService: ref.watch(apiServiceProvider));
