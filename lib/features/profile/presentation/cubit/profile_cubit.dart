import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/delete_account_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  ProfileCubit(
    this._getProfileUseCase,
    this._updateProfileUseCase,
    this._changePasswordUseCase,
    this._deleteAccountUseCase,
  ) : super(ProfileInitial());

  // ======================== Get Profile =======================
  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await _getProfileUseCase();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  // ======================== Update Profile =======================
  Future<void> updateProfile({
    String? name,
    String? phone,
    String? bio,
  }) async {
    emit(ProfileUpdateLoading());
    final result = await _updateProfileUseCase(
      name: name,
      phone: phone,
      bio: bio,
    );
    result.fold(
      (failure) => emit(ProfileUpdateError(failure.message)),
      (profile) => emit(ProfileUpdateSuccess(profile)),
    );
  }

  // ======================== Change Password =======================
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());
    final result = await _changePasswordUseCase(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(ChangePasswordError(failure.message)),
      (_) => emit(ChangePasswordSuccess()),
    );
  }

  // ======================== Delete Account =======================
  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    final result = await _deleteAccountUseCase();
    result.fold(
      (failure) => emit(DeleteAccountError(failure.message)),
      (_) => emit(DeleteAccountSuccess()),
    );
  }
}
