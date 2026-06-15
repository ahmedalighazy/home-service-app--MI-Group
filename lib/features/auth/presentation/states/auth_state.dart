abstract class AuthState {
  const AuthState();
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  final String? message;
  const AuthLoadingState({this.message});
}

class AuthErrorState extends AuthState {
  final String message;
  const AuthErrorState(this.message);
}

@Deprecated('Use AuthSuccessState instead')
class AuthAuthenticated extends AuthState {
  final String email;
  final String? displayName;
  const AuthAuthenticated({required this.email, this.displayName});
}

class AuthSuccessState extends AuthState {
  final String action;
  final Map<String, dynamic> data;

  const AuthSuccessState({required this.action, required this.data});

  String? get userId => data['userId'] as String?;
  String? get email => data['email'] as String?;
  String? get token => data['token'] as String?;
  String? get phoneNumber => data['phoneNumber'] as String?;
  String? get name => data['name'] as String?;
}

class OtpSentState extends AuthState {
  final String phoneNumber;
  final int expirySeconds;

  const OtpSentState({required this.phoneNumber, this.expirySeconds = 59});
}

class OtpInvalidCodeState extends AuthState {
  final String message;
  const OtpInvalidCodeState(this.message);
}

class OtpExpiredState extends AuthState {
  final String message;
  const OtpExpiredState(this.message);
}

class OtpErrorState extends AuthState {
  final String message;
  const OtpErrorState(this.message);
}

class ResetCodeSentState extends AuthState {
  final String email;
  const ResetCodeSentState({required this.email});
}

class ResetCodeInvalidState extends AuthState {
  final String message;
  const ResetCodeInvalidState(this.message);
}

class ResetCodeExpiredState extends AuthState {
  final String message;
  const ResetCodeExpiredState(this.message);
}

class PasswordResetErrorState extends AuthState {
  final String message;
  const PasswordResetErrorState(this.message);
}

typedef AuthLoading = AuthLoadingState;
typedef AuthSuccess = AuthSuccessState;
typedef AuthError = AuthErrorState;
typedef OtpVerified = AuthSuccessState;
typedef OtpError = OtpErrorState;
typedef OtpSent = OtpSentState;
typedef ResetCodeVerified = AuthSuccessState;
typedef ResetCodeError = ResetCodeInvalidState;
typedef ResetCodeSent = ResetCodeSentState;
