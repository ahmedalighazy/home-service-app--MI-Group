import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SecureTokenManager {
  static const String _tokenKey = 'secure_auth_token';
  static const String _refreshTokenKey = 'secure_refresh_token';
  static const String _userDataKey = 'secure_user_data';
  static const String _tokenExpiryKey = 'secure_token_expiry';

  final SharedPreferences _preferences;

  SecureTokenManager({required SharedPreferences preferences})
      : _preferences = preferences;

  Future<void> saveToken(String token) async {
    try {
      await _preferences.setString(_tokenKey, token);
    } catch (e) {
      throw _handleException('Failed to save token', e);
    }
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _preferences.setString(_refreshTokenKey, refreshToken);
    } catch (e) {
      throw _handleException('Failed to save refresh token', e);
    }
  }

  Future<String?> getToken() async {
    try {
      return _preferences.getString(_tokenKey);
    } catch (e) {
      throw _handleException('Failed to get token', e);
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return _preferences.getString(_refreshTokenKey);
    } catch (e) {
      throw _handleException('Failed to get refresh token', e);
    }
  }

  Future<bool> hasToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      throw _handleException('Failed to check token', e);
    }
  }

  Future<void> deleteToken() async {
    try {
      await _preferences.remove(_tokenKey);
      await _preferences.remove(_refreshTokenKey);
    } catch (e) {
      throw _handleException('Failed to delete token', e);
    }
  }

  Future<void> clearAll() async {
    try {
      await _preferences.remove(_tokenKey);
      await _preferences.remove(_refreshTokenKey);
      await _preferences.remove(_userDataKey);
      await _preferences.remove(_tokenExpiryKey);
    } catch (e) {
      throw _handleException('Failed to clear all', e);
    }
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final jsonString = jsonEncode(userData);
      await _preferences.setString(_userDataKey, jsonString);
    } catch (e) {
      throw _handleException('Failed to save user data', e);
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final jsonString = _preferences.getString(_userDataKey);
      if (jsonString == null) return null;

      final decoded = jsonDecode(jsonString);
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
      return null;
    } catch (e) {
      throw _handleException('Failed to get user data', e);
    }
  }

  Future<void> saveTokenExpiry(DateTime expiryTime) async {
    try {
      await _preferences.setString(
        _tokenExpiryKey,
        expiryTime.toIso8601String(),
      );
    } catch (e) {
      throw _handleException('Failed to save token expiry', e);
    }
  }

  Future<bool> isTokenValid() async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) return false;

      final expiryString = _preferences.getString(_tokenExpiryKey);
      if (expiryString == null) return true;

      final expiry = DateTime.parse(expiryString);
      return DateTime.now().isBefore(expiry);
    } catch (e) {
      throw _handleException('Failed to check token validity', e);
    }
  }

  Future<Duration?> getTimeUntilExpiry() async {
    try {
      final expiryString = _preferences.getString(_tokenExpiryKey);
      if (expiryString == null) return null;

      final expiry = DateTime.parse(expiryString);
      final now = DateTime.now();

      if (now.isAfter(expiry)) return Duration.zero;

      return expiry.difference(now);
    } catch (e) {
      throw _handleException('Failed to get time until expiry', e);
    }
  }

  Future<String?> getBearerToken() async {
    try {
      final token = await getToken();
      return token != null ? 'Bearer $token' : null;
    } catch (e) {
      throw _handleException('Failed to get bearer token', e);
    }
  }

  Future<bool> isTokenExpiringSoon() async {
    try {
      final timeLeft = await getTimeUntilExpiry();
      if (timeLeft == null) return false;

      return timeLeft.inSeconds < 60;
    } catch (e) {
      throw _handleException('Failed to check if token expiring soon', e);
    }
  }

  Exception _handleException(String message, Object error) {
    final errorMessage = '$message: $error';
    return TokenManagerSecureException(errorMessage);
  }
}

class TokenManagerSecureException implements Exception {
  final String message;

  TokenManagerSecureException(this.message);

  @override
  String toString() => message;
}
