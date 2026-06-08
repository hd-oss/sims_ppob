import 'package:dartz/dartz.dart';

import '../repositories/topup_repository.dart';

class TopupUseCase {
  final TopupRepository topupRepository;

  TopupUseCase(this.topupRepository);

  /// Mengambil saldo terkini.
  ///
  /// Meneruskan hasil [Either] dari repository apa adanya. Konversi ke
  /// `AsyncValue` dilakukan di lapisan Notifier melalui `unwrapEither`.
  Future<Either<String, String?>> getBalance() async {
    return await topupRepository.getBalance();
  }

  /// Melakukan top up sejumlah [amount].
  ///
  /// Mengembalikan [Either] dengan [Left] berisi pesan kesalahan saat gagal,
  /// dan [Right] berisi `amount` saat berhasil. Konversi ke `AsyncValue`
  /// dilakukan di lapisan Notifier melalui `unwrapEither`.
  Future<Either<String, String>> topupEvent(String amount) async {
    final result = await topupRepository.topupEvent(amount);
    return result.fold(
      (message) => Left(message),
      (_) => Right(amount),
    );
  }
}
