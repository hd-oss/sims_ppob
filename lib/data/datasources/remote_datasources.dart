import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sims_ppob/data/models/history_model.dart';
import '../models/banner_model.dart';
import '../models/service_model.dart';

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

  Future<Either<String, String>> topUp(String amount) async {
    try {
      final response = await apiService.post('/topup',
          data: {"top_up_amount": amount}, requiresAuthToken: false);
      if (response.statusCode == 200) {
        return Right(response.data['data']['balance']);
      } else {
        return Left(response.data['message'] ?? 'Terjadi Kesahalan');
      }
    } on DioException catch (error) {
      return Left(error.message.toString());
    }
  }

  Future<Either<String, String>> purches(String serviceCode) async {
    try {
      final response = await apiService.post('/transaction',
          data: {"service_code": serviceCode}, requiresAuthToken: false);
      if (response.statusCode == 200) {
        return Right(response.data['message']);
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

  Future<Either<String, List<ServiceModel>>> getService() async {
    try {
      final response =
          await apiService.get('/services', requiresAuthToken: true);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data['data'];
        final data = jsonResponse.map((e) => ServiceModel.fromJson(e)).toList();
        return Right(data);
      } else {
        return Left(response.data['message'] ?? 'Terjadi Kesahalan');
      }
    } on DioException catch (error) {
      return Left(error.message.toString());
    }
  }

  Future<Either<String, List<BannerModel>>> getBanner() async {
    try {
      final response = await apiService.get('/banner', requiresAuthToken: true);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data['data'];
        final data = jsonResponse.map((e) => BannerModel.fromJson(e)).toList();
        return Right(data);
      } else {
        return Left(response.data['message'] ?? 'Terjadi Kesahalan');
      }
    } on DioException catch (error) {
      return Left(error.message.toString());
    }
  }

  Future<Either<String, List<HistoryModel>>> getHistory(
      int offset, int limit) async {
    try {
      final response = await apiService.get('/transaction/history',
          prameters: {'offset': offset, 'limit': limit},
          requiresAuthToken: true);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data['data']['records'];
        final data = jsonResponse.map((e) => HistoryModel.fromJson(e)).toList();
        return Right(data);
      } else {
        return Left(response.data['message'] ?? 'Terjadi Kesahalan');
      }
    } on DioException catch (error) {
      return Left(error.message.toString());
    }
  }

  Future<Either<String, String?>> getBalance() async {
    try {
      final response =
          await apiService.get('/balance', requiresAuthToken: true);
      if (response.statusCode == 200) {
        return Right(response.data['data']['balance'].toString());
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
