import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<String, Map<String, dynamic>>> getProfile();
  Future<Either<String, Map<String, dynamic>>> editProfile(dynamic prameters);
  Future<Either<String, Map<String, dynamic>>> editImage(dynamic prameters);
}
