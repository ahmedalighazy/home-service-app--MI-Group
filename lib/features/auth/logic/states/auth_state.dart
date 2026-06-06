/// Auth States - BLoC Pattern
abstract class AuthState {
  const AuthState();
}

// Initial State
class AuthInitial extends AuthState {
  const AuthInitial();
}

// Loading States
class AuthLoading extends AuthState {
  const AuthLoading();
}

class SocialSignInLoading extends AuthState {
  const SocialSignInLoading();
}

// Success States
class AuthSuccess extends AuthState {
  const AuthSuccess();
}

class OtpSent extends AuthState {
  const OtpSent();
}

class OtpVerified extends AuthState {
  const OtpVerified();
}

class SmsCodeSent extends AuthState {
  final String phoneNumber;
  const SmsCodeSent(this.phoneNumber);
}

class SmsCodeVerified extends AuthState {
  const SmsCodeVerified();
}

class ResetCodeSent extends AuthState {
  final String email;
  const ResetCodeSent(this.email);
}

class ResetCodeVerified extends AuthState {
  const ResetCodeVerified();
}

class ResetPasswordSuccess extends AuthState {
  const ResetPasswordSuccess();
}

class GoogleSignInSuccess extends AuthState {
  final String? email;
  final String? displayName;
  const GoogleSignInSuccess({
    this.email,
    this.displayName,
  });
}

class AppleSignInSuccess extends AuthState {
  final String? email;
  final String? displayName;
  const AppleSignInSuccess({
    this.email,
    this.displayName,
  });
}

class SocialSignInCancelled extends AuthState {
  const SocialSignInCancelled();
}

class ProfileCompletionSuccess extends AuthState {
  final String message;
  const ProfileCompletionSuccess({this.message = 'تم إكمال الملف الشخصي بنجاح'});
}

// Error States
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class ResetCodeError extends AuthState {
  final String message;
  const ResetCodeError(this.message);
}

class ResetPasswordError extends AuthState {
  final String message;
  const ResetPasswordError(this.message);
}

class SocialSignInError extends AuthState {
  final String message;
  const SocialSignInError(this.message);
}

class ProfileCompletionError extends AuthState {
  final String message;
  const ProfileCompletionError(this.message);
}
