part of 'auth_cubit.dart';

// ============================================================
//  Base State
// ============================================================
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// ============================================================
//  Login States (general & specific)
// ============================================================
abstract class LoginState extends AuthState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String? message;
  LoginSuccess({this.message});
}

final class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});
}

// ============================================================
//  Register States (direct registration)
// ============================================================
abstract class RegisterState extends AuthState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String? message;
  RegisterSuccess({this.message});
}

final class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure({required this.message});
}

// ============================================================
//  Complete Profile States
// ============================================================
abstract class CompleteProfileState extends AuthState {}

final class CompleteProfileLoading extends CompleteProfileState {}

final class CompleteProfileSuccess extends CompleteProfileState {
  final String? message;
  CompleteProfileSuccess({this.message});
}

final class CompleteProfileFailure extends CompleteProfileState {
  final String message;
  CompleteProfileFailure({required this.message});
}

// ============================================================
//  OTP Send States
// ============================================================
abstract class OtpSendState extends AuthState {}

final class OtpSendLoading extends OtpSendState {}

final class OtpSendSuccess extends OtpSendState {
  final String email;
  final String? message;
  OtpSendSuccess({required this.email, this.message});
}

final class OtpSendFailure extends OtpSendState {
  final String message;
  OtpSendFailure({required this.message});
}

// ============================================================
//  OTP Verify States
// ============================================================
abstract class OtpVerifyState extends AuthState {}

final class OtpVerifyLoading extends OtpVerifyState {}

final class OtpVerifySuccess extends OtpVerifyState {
  final String email;
  final String? message;
  OtpVerifySuccess({required this.email, this.message});
}

final class OtpVerifyFailure extends OtpVerifyState {
  final String message;
  OtpVerifyFailure({required this.message});
}

// ============================================================
//  Activate Account States
// ============================================================
abstract class ActivateAccountState extends AuthState {}

final class ActivateAccountLoading extends ActivateAccountState {}

final class ActivateAccountSuccess extends ActivateAccountState {
  final String? message;
  ActivateAccountSuccess({this.message});
}

final class ActivateAccountFailure extends ActivateAccountState {
  final String message;
  ActivateAccountFailure({required this.message});
}

// ============================================================
//  Reset Code Send States (forgot password)
// ============================================================
abstract class ResetCodeSendState extends AuthState {}

final class ResetCodeSendLoading extends ResetCodeSendState {}

final class ResetCodeSendSuccess extends ResetCodeSendState {
  final String email;
  final String? message;
  ResetCodeSendSuccess({required this.email, this.message});
}

final class ResetCodeSendFailure extends ResetCodeSendState {
  final String message;
  ResetCodeSendFailure({required this.message});
}

// ============================================================
//  Reset Code Verify States
// ============================================================
abstract class ResetCodeVerifyState extends AuthState {}

final class ResetCodeVerifyLoading extends ResetCodeVerifyState {}

final class ResetCodeVerifySuccess extends ResetCodeVerifyState {
  final String email;
  final String code;
  ResetCodeVerifySuccess({required this.email, required this.code});
}

final class ResetCodeVerifyFailure extends ResetCodeVerifyState {
  final String message;
  ResetCodeVerifyFailure({required this.message});
}

// ============================================================
//  Password Reset States (final reset)
// ============================================================
abstract class PasswordResetState extends AuthState {}

final class PasswordResetLoading extends PasswordResetState {}

final class PasswordResetSuccess extends PasswordResetState {
  final String? message;
  PasswordResetSuccess({this.message});
}

final class PasswordResetFailure extends PasswordResetState {
  final String message;
  PasswordResetFailure({required this.message});
}

// ============================================================
//  Refresh Token States
// ============================================================
abstract class RefreshTokenState extends AuthState {}

final class RefreshTokenLoading extends RefreshTokenState {}

final class RefreshTokenSuccess extends RefreshTokenState {
  final String? message;
  RefreshTokenSuccess({this.message});
}

final class RefreshTokenFailure extends RefreshTokenState {
  final String message;
  RefreshTokenFailure({required this.message});
}

// ============================================================
//  Sign Out States
// ============================================================
abstract class SignOutState extends AuthState {}

final class SignOutLoading extends SignOutState {}

final class SignOutSuccess extends SignOutState {}

final class SignOutFailure extends SignOutState {
  final String message;
  SignOutFailure({required this.message});
}

// ============================================================
//  Guest Login States
// ============================================================
final class GuestLoginSuccess extends AuthState {}
