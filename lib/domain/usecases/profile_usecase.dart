import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../data/models/user_model.dart';
import '../repositories/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase(this.repository);

  /// Mengambil profil pengguna.
  ///
  /// Meneruskan hasil [Either] dari repository, memetakan payload `Right`
  /// menjadi [UserModel]. Konversi ke `AsyncValue` dilakukan di lapisan
  /// Notifier melalui `unwrapEither`.
  Future<Either<String, UserModel>> getProfile() async {
    final result = await repository.getProfile();
    return result.fold(
      (message) => Left(message),
      (data) => Right(UserModel.fromJson(data)),
    );
  }

  /// Memperbarui nama depan dan nama belakang profil.
  ///
  /// Mengembalikan [Either] dengan [Left] berisi pesan kesalahan saat gagal,
  /// dan [Right] berisi [UserModel] terbaru saat berhasil.
  Future<Either<String, UserModel>> editProfile(
      String firstName, String lastName) async {
    final params = {
      "first_name": firstName,
      "last_name": lastName,
    };
    final result = await repository.editProfile(params);
    return result.fold(
      (message) => Left(message),
      (data) => Right(UserModel.fromJson(data)),
    );
  }

  /// Mengunggah/memperbarui foto profil dari [file].
  ///
  /// Mengembalikan [Either] dengan [Left] berisi pesan kesalahan saat gagal
  /// (termasuk kegagalan kompresi gambar), dan [Right] berisi [UserModel]
  /// terbaru saat berhasil.
  Future<Either<String, UserModel>> editImage(File file) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';
    final iamgeCompress = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 88, rotate: 180);

    if (iamgeCompress == null) {
      return const Left('Ambil ulang foto');
    }
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: 'profile',
          contentType: MediaType('image', 'png')), // Contoh content-type
    });
    final result = await repository.editImage(formData);
    return result.fold(
      (message) => Left(message),
      (data) => Right(UserModel.fromJson(data)),
    );
  }
}
