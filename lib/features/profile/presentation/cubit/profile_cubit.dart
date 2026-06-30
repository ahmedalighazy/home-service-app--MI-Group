import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/profile_responses.dart';
import '../../data/models/update_responses.dart';
import '../../data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileCubit(this._profileRepo) : super(ProfileInitial());

  // ======================== Get Profile =======================
  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await _profileRepo.getProfile();
    result.when(
      success: (profile) => emit(ProfileLoaded(profile)),
      failure: (error) => emit(ProfileError(error.message ?? 'حدث خطأ غير متوقع')),
    );
  }

  // ======================== Update Profile =======================
  Future<void> updateProfile({
    String? name,
    String? phone,
    String? bio,
    String? preferredLanguage,
  }) async {
    emit(ProfileUpdateLoading());
    final result = await _profileRepo.updateProfile(
      name: name,
      phone: phone,
      bio: bio,
      preferredLanguage: preferredLanguage,
    );
    result.when(
      success: (response) => emit(ProfileUpdateSuccess(response)),
      failure: (error) => emit(ProfileUpdateError(error.message ?? 'حدث خطأ أثناء التحديث')),
    );
  }

  // ======================== Change Password =======================
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());
    final result = await _profileRepo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    result.when(
      success: (_) => emit(ChangePasswordSuccess()),
      failure: (error) => emit(ChangePasswordError(error.message ?? 'حدث خطأ أثناء تغيير كلمة المرور')),
    );
  }

  // ======================== Delete Account =======================
  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    final result = await _profileRepo.deleteAccount();
    result.when(
      success: (_) => emit(DeleteAccountSuccess()),
      failure: (error) => emit(DeleteAccountError(error.message ?? 'حدث خطأ أثناء حذف الحساب')),
    );
  }
}
