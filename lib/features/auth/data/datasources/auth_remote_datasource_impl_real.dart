import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/sign_in_request_model.dart';
import 'auth_remote_datasource.dart';

/// Auth Remote Data Source - Real Implementation
/// 
/// Uses HTTP client for actual API calls
class AuthRemoteDataSourceReal implements AuthRemoteDataSource {
  final http.Client _httpClient;
  final String _baseUrl;

  AuthRemoteDataSourceReal({
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
      final request = SignInRequestModel(
        email: email,
        password: password,
      );

      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/sign-in'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Invalid credentials');
      } else if (response.statusCode == 500) {
        throw ServerException('Server error');
      } else {
        throw ServerException('Failed to sign in');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<void> sendOtpToPhone({
    required String phone,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      if (response.statusCode != 200) {
        throw ServerException('Failed to send OTP');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phone,
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 400) {
        throw ValidationException('Invalid OTP code');
      } else {
        throw ServerException('Failed to verify OTP');
      }
    } catch (e) {
      throw _handleException(e);
    }
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
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/complete-profile'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phone,
          'name': name,
          'email': email,
          'gender': gender,
          'address': address,
          'bio': bio,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw ServerException('Failed to complete profile');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<void> requestPasswordReset({
    required String email,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/request-password-reset'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode != 200) {
        throw ServerException('Failed to request password reset');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<void> verifyResetCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/verify-reset-code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'code': code,
        }),
      );

      if (response.statusCode != 200) {
        throw ServerException('Invalid reset code');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode != 200) {
        throw ServerException('Failed to reset password');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> signInWithGoogle({
    String? idToken,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/google-sign-in'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw ServerException('Google sign-in failed');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> signInWithApple({
    String? identityToken,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/apple-sign-in'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identityToken': identityToken}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw ServerException('Apple sign-in failed');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$_baseUrl/auth/current-user'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw ServerException('Failed to get current user');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$_baseUrl/auth/refresh-token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw ServerException('Failed to refresh token');
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _httpClient.post(Uri.parse('$_baseUrl/auth/sign-out'));
    } catch (e) {
      throw _handleException(e);
    }
  }

  /// Handle different exception types
  Exception _handleException(Object e) {
    if (e is NetworkException ||
        e is ServerException ||
        e is UnauthorizedException ||
        e is ValidationException) {
      return e as Exception;
    }

    if (e is FormatException) {
      return ValidationException('Invalid response format');
    }

    return NetworkException('Network error occurred');
  }
}

// Custom Exception Classes
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  
  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  
  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
  
  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
  
  @override
  String toString() => message;
}
