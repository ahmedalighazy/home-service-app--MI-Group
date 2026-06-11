/// Auth States - Presentation Layer
/// 
/// Organized states for auth feature
/// Using sealed class pattern for type safety
/// State واحدة للـ Success: AuthSuccessState

abstract class AuthState {
  const AuthState();
}

// ════════════════════════════════════════════════════════════════
// Initial & Base States
// ════════════════════════════════════════════════════════════════

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

/// Represents a successful authentication with email and optional displayName
class AuthAuthenticated extends AuthState {
  final String email;
  final String? displayName;
  const AuthAuthenticated({required this.email, this.displayName});
}


// ════════════════════════════════════════════════════════════════
// Unified Success State
// ════════════════════════════════════════════════════════════════

class AuthSuccessState extends AuthState {
  final String action; // 'sign_in', 'otp_verified', 'profile_completed', 'password_reset', 'social'
  final Map<String, dynamic> data; // مرن للبيانات المختلفة
  
  const AuthSuccessState({
    required this.action,
    required this.data,
  });

  // Helper getters للبيانات الشائعة
  String? get userId => data['userId'] as String?;
  String? get email => data['email'] as String?;
  String? get token => data['token'] as String?;
  String? get phoneNumber => data['phoneNumber'] as String?;
  String? get name => data['name'] as String?;
}

// ════════════════════════════════════════════════════════════════
// OTP/Code Specific States
// ════════════════════════════════════════════════════════════════

class OtpSentState extends AuthState {
  final String phoneNumber;
  final int expirySeconds;
  
  const OtpSentState({
    required this.phoneNumber,
    this.expirySeconds = 59,
  });
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

// ════════════════════════════════════════════════════════════════
// Reset Code States
// ════════════════════════════════════════════════════════════════

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
