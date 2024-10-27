import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../common/result_state.dart';
import '../../data/models/user_model.dart';
import '../repositories/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase(this.repository);

  Future<ResultState<UserModel>> getProfile() async {
    final result = await repository.getProfile();
    return result.fold(
      (message) => ResultState.error(message),
      (data) => ResultState.success(UserModel.fromJson(data)),
    );
  }

  Future<ResultState<UserModel>> editProfile(String firstName, String lastName,
      {UserModel? currentData}) async {
    final params = {
      "first_name": firstName,
      "last_name": lastName,
    };
    final result = await repository.editProfile(params);
    return result.fold(
      (message) => ResultState.error(message, currentData),
      (data) => ResultState.success(UserModel.fromJson(data)),
    );
  }

  Future<ResultState<UserModel>> editImage(File file,
      {UserModel? currentData}) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';
    final iamgeCompress = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 88, rotate: 180);

    if (iamgeCompress == null) {
      return ResultState.error('Ambil ulang foto', currentData);
    }
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: 'profile',
          contentType: MediaType('image', 'png')), // Contoh content-type
    });
    final result = await repository.editImage(formData);
    return result.fold(
      (message) => ResultState.error(message, currentData),
      (data) => ResultState.success(UserModel.fromJson(data)),
    );
  }
}
