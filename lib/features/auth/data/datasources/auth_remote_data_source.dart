import '../models/request/login_request_model.dart';
import '../models/response/login_response_model.dart';

/// Auth Remote Data Source Interface
///
/// Defines all remote authentication operations.
abstract class AuthRemoteDataSource {
  // ======================== Login ========================

  Future<LoginResponseModel> signIn(LoginRequestModel request);

  // ======================== Register ========================

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
  });

  // ======================== OTP ========================

  Future<void> sendOtpToPhone({required String phone});

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  });

  // ======================== Complete Profile ========================

  Future<Map<String, dynamic>> completeProfile({
    required String phone,
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  });

  // ======================== Forget Password ========================

  Future<void> requestPasswordReset({required String email});

  Future<void> verifyResetCode({required String email, required String code});

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  });

  // ======================== Social Login ========================

  Future<Map<String, dynamic>> signInWithGoogle({required String idToken});

  Future<Map<String, dynamic>> signInWithApple({required String identityToken});

  // ======================== User ========================

  Future<Map<String, dynamic>> getCurrentUser();

  Future<Map<String, dynamic>> refreshToken({required String refreshToken});

  Future<void> signOut();
}
