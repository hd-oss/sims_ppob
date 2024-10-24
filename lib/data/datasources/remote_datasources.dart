import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/user_model.dart';
import 'api_service.dart';

class RemoteDataSource {
  final ApiService apiService;

  RemoteDataSource({required this.apiService});

  Future<Either<String, UserModel>> login(String email, String password) async {
    try {
      final response = await apiService.post('/login',
          data: {'username': email, 'password': password},
          requiresAuthToken: false);
      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(response.data));
      } else {
        return Left(response.statusMessage ?? 'Terjadi Kesahalan');
      }
    } on DioException catch (error) {
      return Left(error.message.toString());
    }
  }
}
