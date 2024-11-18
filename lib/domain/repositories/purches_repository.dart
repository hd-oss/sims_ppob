import 'package:dartz/dartz.dart';

abstract class PurchesRepository {
  Future<Either<String, String?>> getBalance();
  Future<Either<String, String?>> purchesEvent(String serviceCode);
}
