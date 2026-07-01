sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

// ── OTP Send ──

final class OtpSendLoading extends RegisterState {}

final class OtpSendSuccess extends RegisterState {
  final String email;
  final String? message;
  OtpSendSuccess({required this.email, this.message});
}

final class OtpSendFailure extends RegisterState {
  final String message;
  OtpSendFailure({required this.message});
}

// ── OTP Verify ──

final class OtpVerifyLoading extends RegisterState {}

final class OtpVerifySuccess extends RegisterState {
  final String email;
  final String? message;
  OtpVerifySuccess({required this.email, this.message});
}

final class OtpVerifyFailure extends RegisterState {
  final String message;
  OtpVerifyFailure({required this.message});
}

// ── Complete Profile ──

final class CompleteProfileLoading extends RegisterState {}

final class CompleteProfileSuccess extends RegisterState {
  final String? message;
  CompleteProfileSuccess({this.message});
}

final class CompleteProfileFailure extends RegisterState {
  final String message;
  CompleteProfileFailure({required this.message});
}
