import 'package:injectable/injectable.dart';

import '../../../../core/network/api_service.dart';
import '../models/request/login_request_model.dart';
import '../models/response/login_response_model.dart';
import 'auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  const AuthRemoteDataSourceImpl(this._apiService);

  // ======================== Login ========================

  @override
  Future<LoginResponseModel> signIn(LoginRequestModel request) async {
    return await _apiService.login(request);
  }

  // ======================== Register ========================

  @override
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  // ======================== OTP ========================

  @override
  Future<void> sendOtpToPhone({required String phone}) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) {
    throw UnimplementedError();
  }

  // ======================== Complete Profile ========================

  @override
  Future<Map<String, dynamic>> completeProfile({
    required String phone,
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  }) {
    throw UnimplementedError();
  }

  // ======================== Forget Password ========================

  @override
  Future<void> requestPasswordReset({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<void> verifyResetCode({required String email, required String code}) {
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) {
    throw UnimplementedError();
  }

  // ======================== Social Login ========================

  @override
  Future<Map<String, dynamic>> signInWithGoogle({required String idToken}) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> signInWithApple({
    required String identityToken,
  }) {
    throw UnimplementedError();
  }

  // ======================== User ========================

  @override
  Future<Map<String, dynamic>> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> refreshToken({required String refreshToken}) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }
}
