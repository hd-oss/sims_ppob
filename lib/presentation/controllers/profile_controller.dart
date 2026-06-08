import 'dart:async';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/async_value_x.dart';
import '../../data/models/user_model.dart';
import '../../di/usecase_providers.dart';

part 'profile_controller.g.dart';

/// Notifier state UI lokal untuk halaman profile.
///
/// Menyimpan flag `isEditEvent` (mode edit aktif/tidak) dengan nilai default
/// `false`.
@riverpod
class ProfileUi extends _$ProfileUi {
  @override
  bool build() => false; // isEditEvent default false

  /// Membalik nilai `isEditEvent` (involutif: dua kali toggle kembali semula).
  void toggleEdit() => state = !state;

  /// Mengembalikan `isEditEvent` ke keadaan awal (`false`).
  void reset() => state = false;
}

/// AsyncNotifier untuk profil pengguna.
///
/// `build` melakukan fetch profil awal. Profil dapat di-refresh dengan
/// `ref.invalidate(profileControllerProvider)` setelah edit profil/foto.
@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<UserModel> build() async {
    final result = await ref.watch(profileUseCaseProvider).getProfile();
    return unwrapEither(result);
  }
}

/// AsyncNotifier untuk aksi update profil dan upload foto.
///
/// `build` bersifat idle (tidak melakukan fetch saat inisialisasi). Aksi
/// [editProfile] dan [editImage] mengekspos keadaan loading, lalu data/error
/// melalui `AsyncValue`. Setelah aksi berhasil, profil di-refresh melalui
/// invalidasi `profileControllerProvider`.
@riverpod
class ProfileAction extends _$ProfileAction {
  @override
  FutureOr<void> build() {} // idle; tidak fetch saat init

  /// Memperbarui nama depan/belakang profil. Hasil `Either` dari usecase
  /// dikonversi ke `AsyncValue` melalui `unwrapEither` di dalam
  /// `AsyncValue.guard`. Saat berhasil, profil di-refresh.
  Future<void> editProfile(
      {required String firstName, required String lastName}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (firstName.isEmpty || lastName.isEmpty) {
        throw AppFailure('Lengkapi data');
      }
      final result = await ref
          .read(profileUseCaseProvider)
          .editProfile(firstName, lastName);
      unwrapEither(result);
    });

    if (!state.hasError) {
      ref.invalidate(profileControllerProvider);
    }
  }

  /// Mengunggah/memperbarui foto profil dari [file]. Hasil `Either` dari
  /// usecase dikonversi ke `AsyncValue` melalui `unwrapEither` di dalam
  /// `AsyncValue.guard`. Saat berhasil, profil di-refresh.
  Future<void> editImage(File file) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(profileUseCaseProvider).editImage(file);
      unwrapEither(result);
    });

    if (!state.hasError) {
      ref.invalidate(profileControllerProvider);
    }
  }
}
