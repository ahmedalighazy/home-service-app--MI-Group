part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {}

// ================= Get Profile =================
final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;
  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= Update Profile =================
final class ProfileUpdateLoading extends ProfileState {}

final class ProfileUpdateSuccess extends ProfileState {
  final ProfileEntity profile;
  const ProfileUpdateSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class ProfileUpdateError extends ProfileState {
  final String message;
  const ProfileUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= Change Password =================
final class ChangePasswordLoading extends ProfileState {}

final class ChangePasswordSuccess extends ProfileState {}

final class ChangePasswordError extends ProfileState {
  final String message;
  const ChangePasswordError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= Delete Account =================
final class DeleteAccountLoading extends ProfileState {}

final class DeleteAccountSuccess extends ProfileState {}

final class DeleteAccountError extends ProfileState {
  final String message;
  const DeleteAccountError(this.message);

  @override
  List<Object?> get props => [message];
}
