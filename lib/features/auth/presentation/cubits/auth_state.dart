part of 'auth_cubit.dart';

// ─────────────────────────────────────────
//  Auth States
// ─────────────────────────────────────────

sealed class AuthState {}

// ── Base ──────────────────────────────────

final class AuthInitial extends AuthState {}

/// اسمها AuthLoadingState عشان الـ widgets بتعمل
/// reference عليها بنفس الاسم ده
final class AuthLoadingState extends AuthState {}

// ── Sign-In ───────────────────────────────

/// نجاح الـ login (email/phone/Google/Apple)
final class LoginSuccessState extends AuthState {
  final String? message;
  LoginSuccessState({this.message});
}

// ── Registration / OTP ────────────────────

/// تم إرسال الـ OTP بنجاح
final class OtpSentState extends AuthState {
  final String email;
  final String? message;
  OtpSentState({required this.email, this.message});
}

/// تم التحقق من الـ OTP بنجاح
final class OtpVerifiedState extends AuthState {
  final String email;
  final String? message;
  OtpVerifiedState({required this.email, this.message});
}

/// تم تسجيل الحساب / إتمام البروفايل بنجاح
final class RegisterSuccessState extends AuthState {
  final String? message;
  RegisterSuccessState({this.message});
}

/// دخول كـ Guest
final class GuestLoginSuccessState extends AuthState {}

// ── Password Reset ─────────────────────────

/// تم إرسال كود الاستعادة على الإيميل
final class ResetCodeSentState extends AuthState {
  final String email;
  final String? message;
  ResetCodeSentState({required this.email, this.message});
}

/// تم التحقق من الكود (نروح لشاشة الباسورد الجديد)
final class ResetCodeVerifiedState extends AuthState {
  final String email;
  final String code;
  ResetCodeVerifiedState({required this.email, required this.code});
}

/// تم تغيير الباسورد بنجاح
final class PasswordResetSuccessState extends AuthState {
  final String? message;
  PasswordResetSuccessState({this.message});
}

// ── Session ───────────────────────────────

final class SignOutSuccessState extends AuthState {}

// ── Errors ────────────────────────────────

final class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState({required this.message});
}

final class OtpErrorState extends AuthState {
  final String message;
  OtpErrorState({required this.message});
}

final class ResetCodeError extends AuthState {
  final String message;
  ResetCodeError({required this.message});
}

final class PasswordResetErrorState extends AuthState {
  final String message;
  PasswordResetErrorState({required this.message});
}
