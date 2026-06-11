import 'auth_remote_datasource.dart';

/// Auth Remote Data Source Implementation - Data Layer
/// 
/// Handles API calls using HTTP client or Firebase
abstract class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  /// Implementation example using HTTP client:
  /// 
  /// ```dart
  /// Future<Map<String, dynamic>> signIn({
  ///   required String email,
  ///   required String password,
  /// }) async {
  ///   try {
  ///     final response = await http.post(
  ///       Uri.parse('$baseUrl/auth/sign-in'),
  ///       headers: {'Content-Type': 'application/json'},
  ///       body: jsonEncode({
  ///         'email': email,
  ///         'password': password,
  ///       }),
  ///     );
  ///     
  ///     if (response.statusCode == 200) {
  ///       return jsonDecode(response.body);
  ///     } else {
  ///       throw ServerException('Sign in failed');
  ///     }
  ///   } catch (e) {
  ///     throw _handleError(e);
  ///   }
  /// }
  /// ```
}

/// Mock implementation for remote data source
class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    
    return {
      'accessToken': 'mock_access_token_$email',
      'refreshToken': 'mock_refresh_token',
      'expiresIn': 3600,
      'tokenType': 'Bearer',
      'user': {
        'id': 'user_123',
        'email': email,
        'name': 'Test User',
      },
    };
  }

  @override
  Future<void> sendOtpToPhone({
    required String phone,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock: OTP sent successfully
  }

  @override
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    
    return {
      'accessToken': 'mock_access_token_otp',
      'refreshToken': 'mock_refresh_token',
      'expiresIn': 3600,
      'tokenType': 'Bearer',
    };
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
    await Future.delayed(const Duration(seconds: 2));
    
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
  Future<void> requestPasswordReset({
    required String email,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock: Reset code sent to email
  }

  @override
  Future<void> verifyResetCode({
    required String email,
    required String code,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock: Reset code verified
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    // Mock: Password reset successful
  }

  @override
  Future<Map<String, dynamic>> signInWithGoogle({
    String? idToken,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    
    return {
      'accessToken': 'mock_google_access_token',
      'refreshToken': 'mock_google_refresh_token',
      'expiresIn': 3600,
      'tokenType': 'Bearer',
    };
  }

  @override
  Future<Map<String, dynamic>> signInWithApple({
    String? identityToken,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    
    return {
      'accessToken': 'mock_apple_access_token',
      'refreshToken': 'mock_apple_refresh_token',
      'expiresIn': 3600,
      'tokenType': 'Bearer',
    };
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return {
      'id': 'user_123',
      'email': 'user@example.com',
      'phone': '+97450123456',
      'name': 'Ahmed User',
      'gender': 'Male',
      'createdAt': DateTime.now().toIso8601String(),
      'emailVerified': true,
      'phoneVerified': true,
    };
  }

  @override
  Future<Map<String, dynamic>> refreshToken({
    required String refreshToken,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    return {
      'accessToken': 'mock_new_access_token',
      'refreshToken': 'mock_new_refresh_token',
      'expiresIn': 3600,
      'tokenType': 'Bearer',
    };
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock: Sign out successful
  }
}
