import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'api_service.dart';

class RemoteDataSource {
  final ApiService apiService;

  RemoteDataSource({required this.apiService});

  Future<Either<String, String>> login(String email, String password) async {
    try {
      final response = await apiService.post('/login',
          data: {'email': email, 'password': password},
          requiresAuthToken: false);
      if (response.statusCode == 200) {
        return Right(response.data['data']['token']);
      } else {
        return Left(response.data['message'] ?? 'Terjadi Kesahalan');
      }
    } on DioException catch (error) {
      return Left(error.message.toString());
    }
  }

  Future<Either<String, String>> regist(Map<String, dynamic> params) async {
    try {
      final response = await apiService.post('/registration',
          data: params, requiresAuthToken: false);
      if (response.statusCode == 200) {
        return Right(response.data['message']);
      } else {
        return Left(response.data['message'] ?? 'Terjadi Kesahalan');
      }
    } on DioException catch (error) {
      return Left(error.message.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> getProfile() async {
    try {
      final response =
          await apiService.get('/profile', requiresAuthToken: true);
      if (response.statusCode == 200) {
        return Right(response.data['data']);
      } else {
        return Left(response.data['message'] ?? 'Terjadi Kesahalan');
      }
    } on DioException catch (error) {
      return Left(error.message.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> editProfile(
      dynamic prameters) async {
    try {
      final response = await apiService.put('/profile/update',
          prameters: prameters, requiresAuthToken: true);
      if (response.statusCode == 200) {
        return Right(response.data['data']);
      } else {
        return Left(response.data['message'] ?? 'Terjadi Kesahalan');
      }
    } on DioException catch (error) {
      return Left(error.message.toString());
    }
  }
  Future<Either<String, Map<String, dynamic>>> editImage(
      FormData prameters) async {
    try {
      final response = await apiService.put('/profile/image',
          prameters: prameters, requiresAuthToken: true);
      if (response.statusCode == 200) {
        return Right(response.data['data']);
      } else {
        return Left(response.data['message'] ?? 'Terjadi Kesahalan');
      }
    } on DioException catch (error) {
      return Left(error.message.toString());
    }
  }
}
