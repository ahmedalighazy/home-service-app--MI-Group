import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/error/auth_exceptions.dart';
import '../datasources/auth_remote_datasource.dart';


/// Real implementation of AuthRemoteDataSource that communicates with a REST API.
class AuthRemoteDataSourceImplReal implements AuthRemoteDataSource {
  final http.Client _httpClient;
  final String _baseUrl;

  AuthRemoteDataSourceImplReal({
    required http.Client httpClient,
    required String baseUrl,
  })  : _httpClient = httpClient,
        _baseUrl = baseUrl;

  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/sign-in'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 400) {
        throw ValidationException(message: 'Invalid credentials');
      } else {
        throw ServerException(message: 'Failed to sign in');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/sign-up'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 400) {
        throw ValidationException(message: 'Invalid sign‑up data');
      } else if (response.statusCode == 409) {
        throw ServerException(message: 'User already exists');
      } else {
        throw ServerException(message: 'Failed to sign up');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  // ---------------------------------------------------------------------------
  // The remaining API methods are left as simple mock implementations for now.
  // ---------------------------------------------------------------------------
  @override
  Future<void> sendOtpToPhone({required String phone}) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<Map<String, dynamic>> verifyOtp({required String phone, required String otp}) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'accessToken': 'mock_access_token', 'refreshToken': 'mock_refresh_token', 'expiresIn': 3600, 'tokenType': 'Bearer'};
  }

  @override
  Future<Map<String, dynamic>> completeProfile({
    required String phone,
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'id': 'user_123',
      'email': email,
      'phone': phone,
      'name': name,
      'gender': gender,
      'address': address,
      'bio': bio,
      'createdAt': DateTime.now().toIso8601String(),
      'emailVerified': false,
      'phoneVerified': true,
    };
  }

  @override
  Future<void> requestPasswordReset({required String email}) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> verifyResetCode({required String email, required String code}) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> resetPassword({required String email, required String newPassword}) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<Map<String, dynamic>> signInWithGoogle({String? idToken}) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'accessToken': 'mock_google_access', 'refreshToken': 'mock_google_refresh', 'expiresIn': 3600, 'tokenType': 'Bearer'};
  }

  @override
  Future<Map<String, dynamic>> signInWithApple({String? identityToken}) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'accessToken': 'mock_apple_access', 'refreshToken': 'mock_apple_refresh', 'expiresIn': 3600, 'tokenType': 'Bearer'};
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'id': 'user_123',
      'email': 'user@example.com',
      'phone': '+123456789',
      'name': 'Demo User',
      'gender': 'Male',
      'createdAt': DateTime.now().toIso8601String(),
      'emailVerified': true,
      'phoneVerified': true,
    };
  }

  @override
  Future<Map<String, dynamic>> refreshToken({required String refreshToken}) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'accessToken': 'new_access', 'refreshToken': 'new_refresh', 'expiresIn': 3600, 'tokenType': 'Bearer'};
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Exception _handleException(Object e) {
    if (e is http.ClientException) {
      return NetworkException(originalError: e);
    }
    return ServerException(message: 'Unexpected error', originalError: e);
  }
}
