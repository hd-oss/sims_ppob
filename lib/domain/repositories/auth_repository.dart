import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<String, String>> login(String email, String password);
  Future<void> saveToken(String token);
  Future<void> deleteToken();
}
