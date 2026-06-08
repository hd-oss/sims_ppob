import 'package:dartz/dartz.dart';

import '../repositories/purches_repository.dart';

class PurchesUseCase {
  final PurchesRepository purchesRepository;

  PurchesUseCase(this.purchesRepository);

  /// Mengambil saldo terkini.
  ///
  /// Meneruskan hasil [Either] dari repository apa adanya. Konversi ke
  /// `AsyncValue` dilakukan di lapisan Notifier melalui `unwrapEither`.
  Future<Either<String, String?>> getBalance() async {
    return await purchesRepository.getBalance();
  }

  /// Melakukan transaksi pembayaran layanan dengan kode [serviceCode].
  ///
  /// Mengembalikan [Either] dengan [Left] berisi pesan kesalahan saat gagal,
  /// dan [Right] berisi `serviceCode` saat berhasil. Konversi ke `AsyncValue`
  /// dilakukan di lapisan Notifier melalui `unwrapEither`.
  Future<Either<String, String>> purchesEvent(String serviceCode) async {
    final result = await purchesRepository.purchesEvent(serviceCode);
    return result.fold(
      (message) => Left(message),
      (_) => Right(serviceCode),
    );
  }
}
