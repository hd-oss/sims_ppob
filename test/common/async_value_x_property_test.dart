// Property-based test untuk konversi Either ke AsyncValue.
//
// Feature: migrate-statenotifier-to-notifier-codegen, Property 1:
// Konversi Either ke AsyncValue mempertahankan hasil dan pesan.
//
// Untuk setiap nilai Either<String, T>, konversi ke AsyncValue<T> (via
// unwrapEither di dalam AsyncValue.guard) menghasilkan AsyncData yang
// membungkus nilai Right apa adanya ketika Either adalah Right, dan
// menghasilkan AsyncError yang pesannya sama persis dengan nilai Left
// ketika Either adalah Left.

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glados/glados.dart';
import 'package:sims_ppob/common/async_value_x.dart';

/// Generator untuk nilai [Either] acak (Left/Right) dengan payload int.
///
/// - Left membawa pesan `String` acak.
/// - Right membawa data `int` acak.
extension AnyEither on Any {
  Generator<Either<String, int>> get eitherStringInt => any.bool.bind(
        (isRight) => isRight
            ? any.int.map<Either<String, int>>((value) => Right(value))
            : any.letters.map<Either<String, int>>((message) => Left(message)),
      );
}

void main() {
  // Feature: migrate-statenotifier-to-notifier-codegen, Property 1
  // Validates: Requirements 3.1, 3.3, 3.4
  // numRuns default glados = 100 (>= minimum 100 iterasi).
  Glados<Either<String, int>>(any.eitherStringInt).test(
    'Property 1: konversi Either ke AsyncValue mempertahankan hasil dan pesan',
    (either) async {
      final asyncValue =
          await AsyncValue.guard(() async => unwrapEither(either));

      either.fold(
        (message) {
          // Left -> AsyncError dengan pesan yang sama persis.
          expect(asyncValue, isA<AsyncError<int>>());
          expect(asyncValue.hasError, isTrue);
          expect(asyncValue.hasValue, isFalse);

          final error = (asyncValue as AsyncError).error;
          expect(error, isA<AppFailure>());
          expect((error as AppFailure).message, equals(message));
          expect(error.toString(), equals(message));
        },
        (value) {
          // Right -> AsyncData yang membungkus nilai apa adanya.
          expect(asyncValue, isA<AsyncData<int>>());
          expect(asyncValue.hasValue, isTrue);
          expect(asyncValue.hasError, isFalse);
          expect(asyncValue.value, equals(value));
        },
      );
    },
  );
}
