import 'package:dartz/dartz.dart';

import '../../data/models/regist_model.dart';
import '../repositories/regist_repository.dart';

class RegistUseCase {
  final RegistRepository repository;

  RegistUseCase(this.repository);

  /// Melakukan registrasi pengguna.
  ///
  /// Mengembalikan [Either] dengan [Left] berisi pesan kesalahan saat validasi
  /// gagal atau registrasi gagal, dan [Right] berisi pesan sukses saat
  /// berhasil. Konversi ke `AsyncValue` dilakukan di lapisan Notifier melalui
  /// `unwrapEither`.
  Future<Either<String, String>> regist(RegistModel? params) async {
    if (params == null) {
      return const Left('Lengkapi data');
    }
    if (params.password != params.confirmPassword) {
      return const Left('Password tidak sama');
    }

    return repository.regist(params.toJson());
  }
}
