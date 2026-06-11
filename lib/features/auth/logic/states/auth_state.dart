abstract class AuthState {
  const AuthState();
}

// Initial state
class AuthInitial extends AuthState {
  const AuthInitial();
}

// Loading state
class AuthLoading extends AuthState {
  const AuthLoading();
}

// Success state (generic)
class AuthSuccess extends AuthState {
  const AuthSuccess();
}

// Represents a logged‑in user; UI can listen to this state to navigate to the main app screen.
class AuthAuthenticated extends AuthState {
  final String? email;
  final String? displayName;
  const AuthAuthenticated({this.email, this.displayName});
}

// Error state
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

// SMS code sent
class SmsCodeSent extends AuthState {
  final String phoneNumber;
  const SmsCodeSent(this.phoneNumber);
}

// SMS code verified
class SmsCodeVerified extends AuthState {
  const SmsCodeVerified();
}

// OTP sent
class OtpSent extends AuthState {
  const OtpSent();
}

// OTP verified
class OtpVerified extends AuthState {
  const OtpVerified();
}

// Reset password flow
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

class ResetPasswordError extends AuthState {
  final String message;
  const ResetPasswordError(this.message);
}

// Error state for reset code verification failures
class ResetCodeError extends AuthState {
  final String message;
  const ResetCodeError(this.message);
}

// Social sign‑in flow
class SocialSignInLoading extends AuthState {
  const SocialSignInLoading();
}

class GoogleSignInSuccess extends AuthState {
  final String? email;
  final String? displayName;
  const GoogleSignInSuccess({this.email, this.displayName});
}

class AppleSignInSuccess extends AuthState {
  final String? email;
  final String? displayName;
  const AppleSignInSuccess({this.email, this.displayName});
}

class SocialSignInError extends AuthState {
  final String message;
  const SocialSignInError(this.message);
}

// State representing user cancelled social sign‑in flow
class SocialSignInCancelled extends AuthState {
  const SocialSignInCancelled();
}

// Profile completion flow
class ProfileCompletionSuccess extends AuthState {
  final String? message;
  const ProfileCompletionSuccess({this.message});
}

class ProfileCompletionError extends AuthState {
  final String message;
  const ProfileCompletionError(this.message);
}
