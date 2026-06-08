import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/result_state.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../../domain/usecases/profile_usecase.dart';

class ProfileState {
  final ResultState<UserModel>? userData;
  final bool isEditEvent;
  final bool isEditImage;

  ProfileState({
    this.userData,
    this.isEditEvent = false,
    this.isEditImage = false,
  });

  ProfileState copyWith({
    ResultState<UserModel>? userData,
    bool? isEditEvent,
    bool? isEditImage,
  }) {
    return ProfileState(
      userData: userData ?? this.userData,
      isEditEvent: isEditEvent ?? this.isEditEvent,
      isEditImage: isEditImage ?? this.isEditImage,
    );
  }
}

class ProfileController extends StateNotifier<ProfileState> {
  final ProfileUseCase profileUseCase;
  final AuthUseCase authUseCase;

  ProfileController(this.profileUseCase, this.authUseCase)
      : super(ProfileState());

  Future<void> initState() async {
    state = ProfileState(userData: ResultState.loading());

    try {
      final result = await profileUseCase.getProfile();

      state = state.copyWith(userData: result);
    } catch (e) {
      state = state.copyWith(userData: ResultState.error(e.toString()));
    }
  }

  Future<void> editProfile(
      {required String firstName, required String lastName}) async {
    state = state.copyWith(userData: ResultState.loading(state.userData?.data));

    if (firstName.isEmpty || lastName.isEmpty) {
      state = state.copyWith(userData: ResultState.error('Lengkapi data'));
      return;
    }

    try {
      final result = await profileUseCase.editProfile(firstName, lastName,
          currentData: state.userData?.data);

      state = state.copyWith(userData: result);
    } catch (e) {
      state = state.copyWith(
          userData: ResultState.error(e.toString(), state.userData?.data));
    }
  }

  Future<void> editPicture({required File file}) async {
    state = state.copyWith(
        userData: ResultState.loading(state.userData?.data),
        isEditImage: !state.isEditImage);

    try {
      final result = await profileUseCase.editImage(file,
          currentData: state.userData?.data);

      state = state.copyWith(
        userData: result,
        isEditImage: !state.isEditImage,
      );
    } catch (e) {
      state = state.copyWith(
          userData: ResultState.error(e.toString(), state.userData?.data),
          isEditImage: !state.isEditImage);
    }
  }

  void editEvent() => state = state.copyWith(isEditEvent: !state.isEditEvent);

  void resetState() => state = ProfileState();

  Future<void> logout() => authUseCase.logout();
}
