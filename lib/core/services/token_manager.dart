import 'package:shared_preferences/shared_preferences.dart';

/// Token Manager - Security Layer
/// 
/// مسؤول عن:
/// - حفظ الـ Token (بشكل آمن)
/// - تحميل الـ Token
/// - حذف الـ Token (Logout)
/// - التحقق من صلاحية الـ Token
abstract class TokenManager {
  /// حفظ الـ Token
  Future<void> saveToken(String token);

  /// حفظ الـ Refresh Token
  Future<void> saveRefreshToken(String refreshToken);

  /// تحميل الـ Token
  Future<String?> getToken();

  /// تحميل الـ Refresh Token
  Future<String?> getRefreshToken();

  /// التحقق من وجود الـ Token
  Future<bool> hasToken();

  /// حذف الـ Token (Logout)
  Future<void> deleteToken();

  /// حذف جميع البيانات المتعلقة بـ Auth
  Future<void> clearAll();

  /// حفظ بيانات المستخدم
  Future<void> saveUserData(Map<String, dynamic> userData);

  /// تحميل بيانات المستخدم
  Future<Map<String, dynamic>?> getUserData();

  /// حفظ وقت انتهاء الـ Token
  Future<void> saveTokenExpiry(DateTime expiryTime);

  /// التحقق من صلاحية الـ Token
  Future<bool> isTokenValid();
}

/// Token Manager Implementation
class TokenManagerImpl implements TokenManager {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';
  static const String _tokenExpiryKey = 'token_expiry';

  final SharedPreferences _preferences;

  TokenManagerImpl({required SharedPreferences preferences})
      : _preferences = preferences;

  @override
  Future<void> saveToken(String token) async {
    try {
      await _preferences.setString(_tokenKey, token);
    } catch (e) {
      throw TokenManagerException('Failed to save token: $e');
    }
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _preferences.setString(_refreshTokenKey, refreshToken);
    } catch (e) {
      throw TokenManagerException('Failed to save refresh token: $e');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return _preferences.getString(_tokenKey);
    } catch (e) {
      throw TokenManagerException('Failed to get token: $e');
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return _preferences.getString(_refreshTokenKey);
    } catch (e) {
      throw TokenManagerException('Failed to get refresh token: $e');
    }
  }

  @override
  Future<bool> hasToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      throw TokenManagerException('Failed to check token: $e');
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _preferences.remove(_tokenKey);
      await _preferences.remove(_refreshTokenKey);
    } catch (e) {
      throw TokenManagerException('Failed to delete token: $e');
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _preferences.remove(_tokenKey);
      await _preferences.remove(_refreshTokenKey);
      await _preferences.remove(_userDataKey);
      await _preferences.remove(_tokenExpiryKey);
    } catch (e) {
      throw TokenManagerException('Failed to clear all: $e');
    }
  }

  @override
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final jsonString = _mapToJson(userData);
      await _preferences.setString(_userDataKey, jsonString);
    } catch (e) {
      throw TokenManagerException('Failed to save user data: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final jsonString = _preferences.getString(_userDataKey);
      if (jsonString == null) return null;
      return _jsonToMap(jsonString);
    } catch (e) {
      throw TokenManagerException('Failed to get user data: $e');
    }
  }

  @override
  Future<void> saveTokenExpiry(DateTime expiryTime) async {
    try {
      await _preferences.setString(
        _tokenExpiryKey,
        expiryTime.toIso8601String(),
      );
    } catch (e) {
      throw TokenManagerException('Failed to save token expiry: $e');
    }
  }

  @override
  Future<bool> isTokenValid() async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) return false;

      final expiryString = _preferences.getString(_tokenExpiryKey);
      if (expiryString == null) return true; // If no expiry, assume valid

      final expiry = DateTime.parse(expiryString);
      return DateTime.now().isBefore(expiry);
    } catch (e) {
      throw TokenManagerException('Failed to check token validity: $e');
    }
  }

  /// Helper: تحويل Map إلى JSON string
  String _mapToJson(Map<String, dynamic> map) {
    // استخدم jsonEncode من dart:convert
    // هنا نستخدم طريقة بسيطة للـ demonstration
    final entries = map.entries
        .map((e) => '"${e.key}":"${e.value}"')
        .join(',');
    return '{$entries}';
  }

  /// Helper: تحويل JSON string إلى Map
  Map<String, dynamic> _jsonToMap(String jsonString) {
    // استخدم jsonDecode من dart:convert
    // هنا نستخدم طريقة بسيطة للـ demonstration
    final result = <String, dynamic>{};
    final content = jsonString.substring(1, jsonString.length - 1);
    final pairs = content.split(',');
    for (final pair in pairs) {
      final keyValue = pair.split(':');
      if (keyValue.length == 2) {
        result[keyValue[0].replaceAll('"', '')] =
            keyValue[1].replaceAll('"', '');
      }
    }
    return result;
  }
}

/// Token Manager Exception
class TokenManagerException implements Exception {
  final String message;

  TokenManagerException(this.message);

  @override
  String toString() => message;
}
