import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/auth_token_model.dart';
import 'auth_local_datasource.dart';
import 'package:home_service_app/core/error/auth_exceptions.dart';
import 'package:home_service_app/core/utils/auth_error_logger.dart';

/// Auth Local Data Source - Real Implementation
/// 
/// Uses SharedPreferences for local storage with Token Manager capabilities
class AuthLocalDataSourceReal implements AuthLocalDataSource {
  static const String userKey = 'auth_user';
  static const String tokenKey = 'auth_token';
  static const String otpPhoneKey = 'otp_phone';
  static const String otpIdKey = 'otp_id';
  
  // Token Manager Keys
  static const String _accessTokenKey = 'secure_auth_token';
  static const String _refreshTokenKey = 'secure_refresh_token';
  static const String _tokenExpiryKey = 'secure_token_expiry';
  static const String _userDataKey = 'secure_user_data';

  final SharedPreferences _prefs;

  AuthLocalDataSourceReal(this._prefs);

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await _prefs.setString(userKey, userJson);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'SAVE_USER_FAILED',
        'Failed to save user data',
        originalError: e,
        stackTrace: stackTrace,
        context: {'userId': user.id},
      );
      throw LocalStorageWriteException(
        key: userKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final userJson = _prefs.getString(userKey);
      if (userJson == null) return null;
      
      try {
        return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
      } on FormatException catch (e, stackTrace) {
        AuthErrorLogger().logError(
          'CORRUPTED_USER_DATA',
          'Failed to parse user data from JSON',
          originalError: e,
          stackTrace: stackTrace,
          context: {'key': userKey},
        );
        throw CorruptedDataException(
          dataType: 'UserModel',
          originalError: e,
          stackTrace: stackTrace,
        );
      }
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      throw LocalStorageReadException(
        key: userKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      await _prefs.remove(userKey);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'DELETE_USER_FAILED',
        'Failed to delete user data',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        key: userKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> saveToken(AuthTokenModel token) async {
    try {
      final tokenJson = jsonEncode(token.toJson());
      await _prefs.setString(tokenKey, tokenJson);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'SAVE_TOKEN_FAILED',
        'Failed to save token',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        key: tokenKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<AuthTokenModel?> getToken() async {
    try {
      final tokenJson = _prefs.getString(tokenKey);
      if (tokenJson == null) return null;
      
      try {
        return AuthTokenModel.fromJson(jsonDecode(tokenJson) as Map<String, dynamic>);
      } on FormatException catch (e, stackTrace) {
        AuthErrorLogger().logError(
          'CORRUPTED_TOKEN_DATA',
          'Failed to parse token from JSON',
          originalError: e,
          stackTrace: stackTrace,
        );
        throw CorruptedDataException(
          dataType: 'AuthTokenModel',
          originalError: e,
          stackTrace: stackTrace,
        );
      }
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      throw LocalStorageReadException(
        key: tokenKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _prefs.remove(tokenKey);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'DELETE_TOKEN_FAILED',
        'Failed to delete token',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        key: tokenKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      final token = await getToken();
      return token != null && token.isValid;
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'CHECK_LOGIN_STATUS_FAILED',
        'Failed to check login status',
        originalError: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<void> clearAllAuthData() async {
    try {
      await _prefs.remove(userKey);
      await _prefs.remove(tokenKey);
      await _prefs.remove(otpPhoneKey);
      await _prefs.remove(otpIdKey);
      // Also clear Token Manager data
      await _prefs.remove(_accessTokenKey);
      await _prefs.remove(_refreshTokenKey);
      await _prefs.remove(_tokenExpiryKey);
      await _prefs.remove(_userDataKey);
      // Clear Remember Me data
      await _prefs.remove(_rememberMeEnabledKey);
      await _prefs.remove(_rememberMeEmailKey);
      await _prefs.remove(_rememberMePasswordKey);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'CLEAR_ALL_AUTH_FAILED',
        'Failed to clear all authentication data',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> saveOtpData({
    required String phoneNumber,
    required String otpId,
  }) async {
    try {
      await _prefs.setString(otpPhoneKey, phoneNumber);
      await _prefs.setString(otpIdKey, otpId);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'SAVE_OTP_DATA_FAILED',
        'Failed to save OTP data',
        originalError: e,
        stackTrace: stackTrace,
        context: {'phone': phoneNumber},
      );
      throw LocalStorageWriteException(
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Map<String, String>?> getOtpData() async {
    try {
      final phone = _prefs.getString(otpPhoneKey);
      final otpId = _prefs.getString(otpIdKey);
      
      if (phone == null || otpId == null) return null;
      
      return {
        'phone': phone,
        'otpId': otpId,
      };
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'GET_OTP_DATA_FAILED',
        'Failed to get OTP data',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageReadException(
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> clearOtpData() async {
    try {
      await _prefs.remove(otpPhoneKey);
      await _prefs.remove(otpIdKey);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'CLEAR_OTP_DATA_FAILED',
        'Failed to clear OTP data',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> saveAccessToken(String token) async {
    try {
      if (token.isEmpty) {
        throw ValidationException(
          message: 'Token cannot be empty',
          fieldName: 'token',
        );
      }
      await _prefs.setString(_accessTokenKey, token);
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'SAVE_ACCESS_TOKEN_FAILED',
        'Failed to save access token',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        key: _accessTokenKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      if (refreshToken.isEmpty) {
        throw ValidationException(
          message: 'Refresh token cannot be empty',
          fieldName: 'refreshToken',
        );
      }
      await _prefs.setString(_refreshTokenKey, refreshToken);
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'SAVE_REFRESH_TOKEN_FAILED',
        'Failed to save refresh token',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        key: _refreshTokenKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return _prefs.getString(_accessTokenKey);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'GET_ACCESS_TOKEN_FAILED',
        'Failed to get access token',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageReadException(
        key: _accessTokenKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return _prefs.getString(_refreshTokenKey);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'GET_REFRESH_TOKEN_FAILED',
        'Failed to get refresh token',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageReadException(
        key: _refreshTokenKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<String?> getBearerToken() async {
    try {
      final token = await getAccessToken();
      return token != null ? 'Bearer $token' : null;
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'GET_BEARER_TOKEN_FAILED',
        'Failed to get bearer token',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageReadException(
        key: _accessTokenKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<bool> hasToken() async {
    try {
      final token = await getAccessToken();
      return token != null && token.isNotEmpty;
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'CHECK_HAS_TOKEN_FAILED',
        'Failed to check if token exists',
        originalError: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<void> saveTokenExpiry(DateTime expiryTime) async {
    try {
      if (expiryTime.isBefore(DateTime.now())) {
        throw ValidationException(
          message: 'Expiry time cannot be in the past',
          fieldName: 'expiryTime',
          invalidValue: expiryTime,
        );
      }
      await _prefs.setString(
        _tokenExpiryKey,
        expiryTime.toIso8601String(),
      );
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'SAVE_TOKEN_EXPIRY_FAILED',
        'Failed to save token expiry',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        key: _tokenExpiryKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<bool> isTokenValid() async {
    try {
      final token = await getAccessToken();
      if (token == null || token.isEmpty) return false;

      final expiryString = _prefs.getString(_tokenExpiryKey);
      if (expiryString == null) return true; // No expiry set, assume valid

      try {
        final expiry = DateTime.parse(expiryString);
        return DateTime.now().isBefore(expiry);
      } on FormatException catch (e, stackTrace) {
        AuthErrorLogger().logError(
          'CORRUPTED_TOKEN_EXPIRY',
          'Invalid token expiry format',
          originalError: e,
          stackTrace: stackTrace,
          context: {'expiryString': expiryString},
        );
        return false;
      }
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'CHECK_TOKEN_VALIDITY_FAILED',
        'Failed to check token validity',
        originalError: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<Duration?> getTimeUntilExpiry() async {
    try {
      final expiryString = _prefs.getString(_tokenExpiryKey);
      if (expiryString == null) return null;

      try {
        final expiry = DateTime.parse(expiryString);
        final now = DateTime.now();

        if (now.isAfter(expiry)) return Duration.zero;

        return expiry.difference(now);
      } on FormatException catch (e, stackTrace) {
        AuthErrorLogger().logError(
          'CORRUPTED_TOKEN_EXPIRY_DURATION',
          'Invalid token expiry format',
          originalError: e,
          stackTrace: stackTrace,
        );
        return null;
      }
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'GET_TIME_UNTIL_EXPIRY_FAILED',
        'Failed to get time until token expiry',
        originalError: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<bool> isTokenExpiringSoon() async {
    try {
      final timeLeft = await getTimeUntilExpiry();
      if (timeLeft == null) return false;
      
      return timeLeft.inSeconds < 60; // Expiring within 60 seconds
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'CHECK_TOKEN_EXPIRING_SOON_FAILED',
        'Failed to check if token expiring soon',
        originalError: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      if (userData.isEmpty) {
        throw ValidationException(
          message: 'User data cannot be empty',
          fieldName: 'userData',
        );
      }
      final jsonString = jsonEncode(userData);
      await _prefs.setString(_userDataKey, jsonString);
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'SAVE_USER_DATA_FAILED',
        'Failed to save user data',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        key: _userDataKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final jsonString = _prefs.getString(_userDataKey);
      if (jsonString == null) return null;
      
      try {
        final decoded = jsonDecode(jsonString);
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
        return null;
      } on FormatException catch (e, stackTrace) {
        AuthErrorLogger().logError(
          'CORRUPTED_USER_DATA_JSON',
          'Failed to parse user data JSON',
          originalError: e,
          stackTrace: stackTrace,
        );
        throw CorruptedDataException(
          dataType: 'UserData',
          originalError: e,
          stackTrace: stackTrace,
        );
      }
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'GET_USER_DATA_FAILED',
        'Failed to get user data',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageReadException(
        key: _userDataKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> saveRememberMeEmail(String email) async {
    try {
      if (email.isEmpty) {
        throw ValidationException(
          message: 'Email cannot be empty',
          fieldName: 'email',
        );
      }
      await _prefs.setString(_rememberMeEmailKey, email);
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'SAVE_REMEMBER_ME_EMAIL_FAILED',
        'Failed to save Remember Me email',
        originalError: e,
        stackTrace: stackTrace,
        context: {'email': email},
      );
      throw LocalStorageWriteException(
        key: _rememberMeEmailKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<String?> getRememberedEmail() async {
    try {
      return _prefs.getString(_rememberMeEmailKey);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'GET_REMEMBER_ME_EMAIL_FAILED',
        'Failed to get Remember Me email',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageReadException(
        key: _rememberMeEmailKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> saveRememberMePassword(String password) async {
    try {
      if (password.isEmpty) {
        throw ValidationException(
          message: 'Password cannot be empty',
          fieldName: 'password',
        );
      }
      // In production, encrypt the password before storing
      // For now, we'll store it as-is (consider using flutter_secure_storage)
      await _prefs.setString(_rememberMePasswordKey, password);
    } catch (e, stackTrace) {
      if (e is AuthException) rethrow;
      AuthErrorLogger().logError(
        'SAVE_REMEMBER_ME_PASSWORD_FAILED',
        'Failed to save Remember Me password',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        key: _rememberMePasswordKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<String?> getRememberedPassword() async {
    try {
      return _prefs.getString(_rememberMePasswordKey);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'GET_REMEMBER_ME_PASSWORD_FAILED',
        'Failed to get Remember Me password',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageReadException(
        key: _rememberMePasswordKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<bool> isRememberMeEnabled() async {
    try {
      return _prefs.getBool(_rememberMeEnabledKey) ?? false;
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'CHECK_REMEMBER_ME_ENABLED_FAILED',
        'Failed to check Remember Me status',
        originalError: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<void> setRememberMeEnabled(bool enabled) async {
    try {
      await _prefs.setBool(_rememberMeEnabledKey, enabled);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'SET_REMEMBER_ME_ENABLED_FAILED',
        'Failed to set Remember Me',
        originalError: e,
        stackTrace: stackTrace,
        context: {'enabled': enabled},
      );
      throw LocalStorageWriteException(
        key: _rememberMeEnabledKey,
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> clearRememberMeData() async {
    try {
      await _prefs.remove(_rememberMeEnabledKey);
      await _prefs.remove(_rememberMeEmailKey);
      await _prefs.remove(_rememberMePasswordKey);
    } catch (e, stackTrace) {
      AuthErrorLogger().logError(
        'CLEAR_REMEMBER_ME_DATA_FAILED',
        'Failed to clear Remember Me data',
        originalError: e,
        stackTrace: stackTrace,
      );
      throw LocalStorageWriteException(
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  static const String _rememberMeEnabledKey = 'remember_me_enabled';
  static const String _rememberMeEmailKey = 'remember_me_email';
  static const String _rememberMePasswordKey = 'remember_me_password';
}