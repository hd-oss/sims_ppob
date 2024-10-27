
import 'package:dartz/dartz.dart';

abstract class RegistRepository {
  Future<Either<String, String>> regist(Map<String, dynamic> params);
}
