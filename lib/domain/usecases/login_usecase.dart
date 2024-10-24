import 'package:dartz/dartz.dart';

import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, UserModel>> execute(String username, String password) {
    return repository.login(username, password);
  }

  Future<void> saveToken(String token) => repository.saveToken(token);
}
