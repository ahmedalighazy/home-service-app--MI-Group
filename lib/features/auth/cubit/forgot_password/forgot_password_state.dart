sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

// ── Reset Code Send ──

final class ResetCodeSendLoading extends ForgotPasswordState {}

final class ResetCodeSendSuccess extends ForgotPasswordState {
  final String email;
  final String? message;
  ResetCodeSendSuccess({required this.email, this.message});
}

final class ResetCodeSendFailure extends ForgotPasswordState {
  final String message;
  ResetCodeSendFailure({required this.message});
}

// ── Reset Code Verify ──

final class ResetCodeVerifyLoading extends ForgotPasswordState {}

final class ResetCodeVerifySuccess extends ForgotPasswordState {
  final String email;
  final String code;
  ResetCodeVerifySuccess({required this.email, required this.code});
}

final class ResetCodeVerifyFailure extends ForgotPasswordState {
  final String message;
  ResetCodeVerifyFailure({required this.message});
}

// ── Password Reset ──

final class PasswordResetLoading extends ForgotPasswordState {}

final class PasswordResetSuccess extends ForgotPasswordState {
  final String? message;
  PasswordResetSuccess({this.message});
}

final class PasswordResetFailure extends ForgotPasswordState {
  final String message;
  PasswordResetFailure({required this.message});
}

class NewPasswordValidationChanged extends ForgotPasswordState {}
