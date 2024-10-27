import 'package:dartz/dartz.dart';

abstract class TopupRepository {
  Future<Either<String, String?>> getBalance();
  Future<Either<String, String?>> topupEvent(String amount);
}
