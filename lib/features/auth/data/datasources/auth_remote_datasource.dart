/// Auth Remote Data Source Interface - Data Layer
/// 
/// Abstract interface for remote API calls
abstract class AuthRemoteDataSource {
  /// Make sign in API call
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  });

  /// Send OTP to phone
  Future<void> sendOtpToPhone({
    required String phone,
  });

  /// Verify OTP code
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  });

  /// Complete user profile
  Future<Map<String, dynamic>> completeProfile({
    required String phone,
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  });

  /// Request password reset
  Future<void> requestPasswordReset({
    required String email,
  });

  /// Verify reset code
  Future<void> verifyResetCode({
    required String email,
    required String code,
  });

  /// Reset password
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  });

  /// Sign in with Google
  Future<Map<String, dynamic>> signInWithGoogle({
    required String idToken,
  });

  /// Sign in with Apple
  Future<Map<String, dynamic>> signInWithApple({
    required String identityToken,
  });

  /// Get current user
  Future<Map<String, dynamic>> getCurrentUser();

  /// Refresh token
  Future<Map<String, dynamic>> refreshToken({
    required String refreshToken,
  });

  /// Sign out
  Future<void> signOut();
}
