import 'package:dio/dio.dart';

import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../../common/secure_storage_helper.dart';

class ApiService {
  final Dio _dio;
  final SecureStorageHelper secureStorageHelper;

  ApiService(
    this._dio,
    this.secureStorageHelper,
  ) {
    _dio.options = BaseOptions(
        baseUrl: 'https://take-home-test-api.nutech-integrasi.com',
        receiveDataWhenStatusError: true,
        contentType: Headers.jsonContentType,
        validateStatus: (value) => true);
    _dio.interceptors.addAll([
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(printRequestHeaders: true),
      ),
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {}
          handler.next(e);
        },
        onResponse: (e, handler) async {
          if (e.statusCode == 401) await secureStorageHelper.deleteToken();

          handler.next(e);
        },
      ),
    ]);
  }

  Future<void> _setToken() async {
    final token = await secureStorageHelper.readToken();

    if (token != null) updateAuthorization(token);
  }

  void updateAuthorization(String token) {
    _dio.options.headers['authorization'] = 'Bearer $token';
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters,
      required bool requiresAuthToken}) async {
    if (requiresAuthToken) await _setToken();
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      required bool requiresAuthToken}) async {
    if (requiresAuthToken) await _setToken();
    return await _dio.post(path, queryParameters: queryParameters, data: data);
  }

  Future<Response> delete(String path,
      {Object? data, required bool requiresAuthToken}) async {
    if (requiresAuthToken) await _setToken();
    return await _dio.delete(path, data: data);
  }

  Future<Response> put(String path,
      {Object? data,
      required bool requiresAuthToken,
      Map<String, dynamic>? queryParameters}) async {
    if (requiresAuthToken) await _setToken();
    return await _dio.put(path, data: data, queryParameters: queryParameters);
  }

  void handleError(DioException error) {
    if (error.response != null) {
      switch (error.response!.statusCode) {
        case 400:
          throw BadRequestException(error.response!.data.toString());
        case 401:
          throw UnauthorizedException(error.response!.data.toString());
        case 500:
          throw InternalServerErrorException(error.response!.data.toString());
        default:
          throw FetchDataException(
              'Error occurred: ${error.response!.statusCode}');
      }
    } else {
      throw FetchDataException('No response received');
    }
  }
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}

class InternalServerErrorException implements Exception {
  final String message;
  InternalServerErrorException(this.message);
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);
}
