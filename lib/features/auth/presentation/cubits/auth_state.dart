part of 'auth_cubit.dart';

// ============================================================
//  Base State
// ============================================================
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// ============================================================
//  Login
// ============================================================
final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final String? message;
  LoginSuccess({this.message});
}

final class LoginFailure extends AuthState {
  final String message;
  LoginFailure({required this.message});
}

// ============================================================
//  Register
// ============================================================
final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {
  final String? message;
  RegisterSuccess({this.message});
}

final class RegisterFailure extends AuthState {
  final String message;
  RegisterFailure({required this.message});
}

// ============================================================
//  Complete Profile
// ============================================================
final class CompleteProfileLoading extends AuthState {}

final class CompleteProfileSuccess extends AuthState {
  final String? message;
  CompleteProfileSuccess({this.message});
}

final class CompleteProfileFailure extends AuthState {
  final String message;
  CompleteProfileFailure({required this.message});
}

// ============================================================
//  OTP Send
// ============================================================
final class OtpSendLoading extends AuthState {}

final class OtpSendSuccess extends AuthState {
  final String email;
  final String? message;
  OtpSendSuccess({required this.email, this.message});
}

final class OtpSendFailure extends AuthState {
  final String message;
  OtpSendFailure({required this.message});
}

// ============================================================
//  OTP Verify
// ============================================================
final class OtpVerifyLoading extends AuthState {}

final class OtpVerifySuccess extends AuthState {
  final String email;
  final String? message;
  OtpVerifySuccess({required this.email, this.message});
}

final class OtpVerifyFailure extends AuthState {
  final String message;
  OtpVerifyFailure({required this.message});
}

// ============================================================
//  Reset Code Send
// ============================================================
final class ResetCodeSendLoading extends AuthState {}

final class ResetCodeSendSuccess extends AuthState {
  final String email;
  final String? message;
  ResetCodeSendSuccess({required this.email, this.message});
}

final class ResetCodeSendFailure extends AuthState {
  final String message;
  ResetCodeSendFailure({required this.message});
}

// ============================================================
//  Reset Code Verify
// ============================================================
final class ResetCodeVerifyLoading extends AuthState {}

final class ResetCodeVerifySuccess extends AuthState {
  final String email;
  final String code;
  ResetCodeVerifySuccess({required this.email, required this.code});
}

final class ResetCodeVerifyFailure extends AuthState {
  final String message;
  ResetCodeVerifyFailure({required this.message});
}

// ============================================================
//  Password Reset
// ============================================================
final class PasswordResetLoading extends AuthState {}

final class PasswordResetSuccess extends AuthState {
  final String? message;
  PasswordResetSuccess({this.message});
}

final class PasswordResetFailure extends AuthState {
  final String message;
  PasswordResetFailure({required this.message});
}

// ============================================================
//  Sign Out
// ============================================================
final class SignOutLoading extends AuthState {}

final class SignOutSuccess extends AuthState {}

final class SignOutFailure extends AuthState {
  final String message;
  SignOutFailure({required this.message});
}

// ============================================================
//  Guest Login
// ============================================================
final class GuestLoginSuccess extends AuthState {}
