import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/async_value_x.dart';
import '../../di/usecase_providers.dart';

part 'login_controller.g.dart';

/// Notifier state UI lokal untuk halaman login.
///
/// Menyimpan flag `isHide` (visibilitas password) dengan nilai default `true`.
@riverpod
class LoginUi extends _$LoginUi {
  @override
  bool build() => true; // isHide default true

  /// Membalik nilai `isHide` (involutif: dua kali toggle kembali ke semula).
  void toggleHide() => state = !state;

  /// Mengembalikan `isHide` ke keadaan awal (`true`).
  void reset() => state = true;
}

/// AsyncNotifier untuk aksi autentikasi login.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [login] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
@riverpod
class LoginAuth extends _$LoginAuth {
  @override
  FutureOr<void> build() {} // idle; tidak fetch saat init

  /// Menjalankan login. Hasil `Either` dari usecase dikonversi ke `AsyncValue`
  /// melalui `unwrapEither` di dalam `AsyncValue.guard`.
  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(authUseCaseProvider).login(email, password);
      return unwrapEither(result);
    });
  }
}
