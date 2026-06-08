import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  /// Melakukan login dan menyimpan token saat berhasil.
  ///
  /// Mengembalikan [Either] dengan [Left] berisi pesan kesalahan saat gagal,
  /// dan [Right] berisi pesan sukses saat berhasil. Konversi ke `AsyncValue`
  /// dilakukan di lapisan Notifier melalui `unwrapEither`.
  Future<Either<String, String>> login(String username, String password) async {
    final result = await repository.login(username, password);
    return await result.fold(
      (message) async => Left<String, String>(message),
      (token) async {
        await repository.saveToken(token);
        return const Right<String, String>('Berhasil login');
      },
    );
  }

  Future<void> logout() async => await repository.deleteToken();
}
