import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sims_ppob/data/models/regist_model.dart';

import '../../common/async_value_x.dart';
import '../../di/usecase_providers.dart';

part 'regist_controller.g.dart';

/// State UI lokal untuk halaman registrasi.
///
/// Menyimpan flag visibilitas password (`isHide`) dan konfirmasi password
/// (`isHideCofirm`), keduanya default `true`.
class RegistUiState {
  final bool isHide;
  final bool isHideCofirm;

  const RegistUiState({this.isHide = true, this.isHideCofirm = true});

  RegistUiState copyWith({bool? isHide, bool? isHideCofirm}) => RegistUiState(
        isHide: isHide ?? this.isHide,
        isHideCofirm: isHideCofirm ?? this.isHideCofirm,
      );
}

/// Notifier state UI lokal untuk halaman registrasi.
@riverpod
class RegistUi extends _$RegistUi {
  @override
  RegistUiState build() => const RegistUiState();

  /// Membalik visibilitas password (involutif).
  void toggleHide() => state = state.copyWith(isHide: !state.isHide);

  /// Membalik visibilitas konfirmasi password (involutif).
  void toggleHideConfirm() =>
      state = state.copyWith(isHideCofirm: !state.isHideCofirm);

  /// Mengembalikan flag ke keadaan awal (keduanya `true`).
  void reset() => state = const RegistUiState();
}

/// AsyncNotifier untuk aksi registrasi pengguna.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [regist] mengekspos keadaan loading, lalu data/error melalui `AsyncValue`.
@riverpod
class RegistAuth extends _$RegistAuth {
  @override
  FutureOr<void> build() {} // idle; tidak fetch saat init

  /// Menjalankan registrasi. Hasil `Either` dari usecase dikonversi ke
  /// `AsyncValue` melalui `unwrapEither` di dalam `AsyncValue.guard`.
  Future<void> regist(RegistModel? params) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(registUseCaseProvider).regist(params);
      return unwrapEither(result);
    });
  }
}
