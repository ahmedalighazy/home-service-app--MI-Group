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

// ── Sign-in specific ────────────────────────────────────────

/// Email/password login succeeded.
class SignInSuccess extends AuthState {}

/// Wrong email or password.
class SignInInvalidCredentials extends AuthState {}

/// Network or server error during sign-in.
class SignInError extends AuthState {
  final String message;
  SignInError(this.message);
}

// ── OTP specific ────────────────────────────────────────────

/// OTP was dispatched to the phone.
class OtpSent extends AuthState {}

/// OTP code verified successfully.
class OtpVerified extends AuthState {}

/// OTP code was wrong.
class OtpError extends AuthState {
  final String message;
  OtpError(this.message);
}

// ── SMS / Reset ─────────────────────────────────────────────

class SmsCodeSent extends AuthState {
  final String phoneNumber;
  SmsCodeSent(this.phoneNumber);
}

class SmsCodeVerified extends AuthState {}

class ResetCodeSent extends AuthState {
  final String email;
  ResetCodeSent(this.email);
}

/// Reset code was verified successfully.
class ResetCodeVerified extends AuthState {}

/// Reset code was wrong or expired.
class ResetCodeError extends AuthState {
  final String message;
  ResetCodeError(this.message);
}

class ResetPasswordSuccess extends AuthState {}