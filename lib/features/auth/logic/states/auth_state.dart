abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final dynamic userData;
  AuthSuccess({this.userData});
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class SmsCodeSent extends AuthState {
  final String phoneNumber;
  SmsCodeSent(this.phoneNumber);
}

class SmsCodeVerified extends AuthState {}

class ResetCodeSent extends AuthState {
  final String email;
  ResetCodeSent(this.email);
}

class ResetPasswordSuccess extends AuthState {}

class OtpSent extends AuthState {}

class ResetCodeVerified extends AuthState {}