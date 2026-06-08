import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/async_value_x.dart';
import '../../common/result_state.dart';
import '../../di/usecase_providers.dart';
import '../../domain/usecases/auth_usecase.dart';

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

// ---------------------------------------------------------------------------
// Artefak lama (StateNotifier) dipertahankan sementara agar aplikasi tetap
// dapat dikompilasi selama transisi. Akan dihapus pada langkah pembersihan
// (lihat task 4.2 / 14).
// ---------------------------------------------------------------------------

class LoginState {
  final bool isHide;
  final ResultState<String>? loginResult;

  LoginState({this.isHide = true, this.loginResult});

  LoginState copyWith({bool? isHide, ResultState<String>? loginResult}) {
    return LoginState(
        isHide: isHide ?? this.isHide,
        loginResult: loginResult ?? this.loginResult);
  }
}

class LoginController extends StateNotifier<LoginState> {
  final AuthUseCase loginUseCase;

  LoginController(this.loginUseCase) : super(LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(loginResult: ResultState.loading());

    try {
      final result = await loginUseCase.login(email, password);

      state = state.copyWith(
        loginResult: result.fold(
          (message) => ResultState.error(message),
          (data) => ResultState.success(data, data),
        ),
      );
    } catch (e) {
      state = state.copyWith(loginResult: ResultState.error(e.toString()));
    }
  }

  void hidePassword() => state = state.copyWith(isHide: !state.isHide);

  void resetState() => state = LoginState();
}
