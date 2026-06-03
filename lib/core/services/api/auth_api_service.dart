import 'package:dio/dio.dart';
import 'dio_client.dart';

class AuthApiService {
  AuthApiService._();
  static final AuthApiService instance = AuthApiService._();

  final Dio _dio = DioClient.instance.dio;

  /// Send OTP / login request with phone number
  Future<Response> login(String phone) async {
    return await _dio.post('/auth/login', data: {'phone': phone});
  }

  /// Verify OTP code
  Future<Response> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    return await _dio.post('/auth/verify-otp', data: {
      'phone': phone,
      'otp': otp,
    });
  }

  /// Register a new user
  Future<Response> register({
    required String name,
    required String phone,
    required String password,
  }) async {
    return await _dio.post('/auth/register', data: {
      'name': name,
      'phone': phone,
      'password': password,
    });
  }

  /// Login with email and password
  Future<Response> loginWithEmail({
    required String email,
    required String password,
  }) async {
    return await _dio.post('/auth/login-email', data: {
      'email': email,
      'password': password,
    });
  }

  /// Send reset password code to email
  Future<Response> sendResetPasswordCode(String email) async {
    return await _dio.post('/auth/forgot-password', data: {'email': email});
  }

  /// Verify reset password code
  Future<Response> verifyResetPasswordCode({
    required String email,
    required String code,
  }) async {
    return await _dio.post('/auth/verify-reset-code', data: {
      'email': email,
      'code': code,
    });
  }

  /// Reset password
  Future<Response> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    return await _dio.post('/auth/reset-password', data: {
      'email': email,
      'code': code,
      'password': newPassword,
    });
  }

  /// Refresh token
  Future<Response> refreshToken(String token) async {
    return await _dio.post('/auth/refresh', data: {'refresh_token': token});
  }

  /// Logout
  Future<Response> logout(String token) async {
    return await _dio.post(
      '/auth/logout',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
