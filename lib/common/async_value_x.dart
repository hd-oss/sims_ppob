import 'package:dartz/dartz.dart';

/// Membuka nilai [Either] menjadi data biasa.
///
/// Mengembalikan data `T` ketika [either] bernilai [Right], dan melempar
/// [AppFailure] dengan pesan dari [Left] ketika [either] bernilai [Left].
///
/// Dirancang untuk dipakai di dalam `AsyncValue.guard` pada Notifier sehingga
/// kegagalan otomatis menjadi `AsyncError` dengan pesan yang dapat dibaca UI.
T unwrapEither<T>(Either<String, T> either) => either.fold(
      (message) => throw AppFailure(message),
      (data) => data,
    );

/// Kegagalan domain yang membawa pesan kesalahan terbaca.
///
/// `toString()` mengembalikan [message] apa adanya agar UI dapat menampilkan
/// pesan kesalahan langsung dari `error.toString()`.
class AppFailure implements Exception {
  final String message;

  AppFailure(this.message);

  @override
  String toString() => message;
}
