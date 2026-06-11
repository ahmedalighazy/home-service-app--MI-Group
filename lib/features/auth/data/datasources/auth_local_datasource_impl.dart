import '../models/user_model.dart';
import '../models/auth_token_model.dart';
import 'auth_local_datasource.dart';

/// Auth Local Data Source Implementation - Data Layer
/// 
/// Handles local storage using SharedPreferences or similar
abstract class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String userKey = 'auth_user';
  static const String tokenKey = 'auth_token';
  static const String otpPhoneKey = 'otp_phone';
  static const String otpIdKey = 'otp_id';

  /// Implementation example using SharedPreferences (to be implemented)
  /// 
  /// ```dart
  /// Future<void> saveUser(UserModel user) async {
  ///   final prefs = await SharedPreferences.getInstance();
  ///   await prefs.setString(userKey, jsonEncode(user.toJson()));
  /// }
  /// ```
}

/// Mock implementation for local data source
class AuthLocalDataSourceMock implements AuthLocalDataSource {
  final Map<String, dynamic> _cache = {};

  @override
  Future<void> saveUser(UserModel user) async {
    _cache['user'] = user.toJson();
  }

  @override
  Future<UserModel?> getUser() async {
    final userJson = _cache['user'] as Map<String, dynamic>?;
    if (userJson != null) {
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  @override
  Future<void> deleteUser() async {
    _cache.remove('user');
  }

  @override
  Future<void> saveToken(AuthTokenModel token) async {
    _cache['token'] = token.toJson();
  }

  @override
  Future<AuthTokenModel?> getToken() async {
    final tokenJson = _cache['token'] as Map<String, dynamic>?;
    if (tokenJson != null) {
      return AuthTokenModel.fromJson(tokenJson);
    }
    return null;
  }

  @override
  Future<void> deleteToken() async {
    _cache.remove('token');
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return _cache.containsKey('token') &&
        _cache.containsKey('user');
  }

  @override
  Future<void> clearAllAuthData() async {
    _cache.clear();
  }

  @override
  Future<void> saveOtpData({
    required String phoneNumber,
    required String otpId,
  }) async {
    _cache['otp_phone'] = phoneNumber;
    _cache['otp_id'] = otpId;
  }

  @override
  Future<Map<String, String>?> getOtpData() async {
    final phone = _cache['otp_phone'] as String?;
    final otpId = _cache['otp_id'] as String?;
    
    if (phone != null && otpId != null) {
      return {
        'phone': phone,
        'otpId': otpId,
      };
    }
    return null;
  }

  @override
  Future<void> clearOtpData() async {
    _cache.remove('otp_phone');
    _cache.remove('otp_id');
  }

  // ============================================================================
  // Token Manager Mock Implementation
  // ============================================================================

  @override
  Future<void> saveAccessToken(String token) async {
    _cache['access_token'] = token;
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    _cache['refresh_token'] = refreshToken;
  }

  @override
  Future<String?> getAccessToken() async {
    return _cache['access_token'] as String?;
  }

  @override
  Future<String?> getRefreshToken() async {
    return _cache['refresh_token'] as String?;
  }

  @override
  Future<String?> getBearerToken() async {
    final token = _cache['access_token'] as String?;
    return token != null ? 'Bearer $token' : null;
  }

  @override
  Future<bool> hasToken() async {
    final token = _cache['access_token'] as String?;
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> saveTokenExpiry(DateTime expiryTime) async {
    _cache['token_expiry'] = expiryTime.toIso8601String();
  }

  @override
  Future<bool> isTokenValid() async {
    final token = _cache['access_token'] as String?;
    if (token == null || token.isEmpty) return false;

    final expiryString = _cache['token_expiry'] as String?;
    if (expiryString == null) return true;

    final expiry = DateTime.parse(expiryString);
    return DateTime.now().isBefore(expiry);
  }

  @override
  Future<Duration?> getTimeUntilExpiry() async {
    final expiryString = _cache['token_expiry'] as String?;
    if (expiryString == null) return null;

    final expiry = DateTime.parse(expiryString);
    final now = DateTime.now();

    if (now.isAfter(expiry)) return Duration.zero;

    return expiry.difference(now);
  }

  @override
  Future<bool> isTokenExpiringSoon() async {
    final timeLeft = await getTimeUntilExpiry();
    if (timeLeft == null) return false;
    
    return timeLeft.inSeconds < 60;
  }

  @override
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    _cache['user_data'] = userData;
  }

  @override
  Future<Map<String, dynamic>?> getUserData() async {
    return _cache['user_data'] as Map<String, dynamic>?;
  }

  // ============================================================================
  // Remember Me Mock Implementation
  // ============================================================================

  @override
  Future<void> saveRememberMeEmail(String email) async {
    _cache['remember_me_email'] = email;
  }

  @override
  Future<String?> getRememberedEmail() async {
    return _cache['remember_me_email'] as String?;
  }

  @override
  Future<void> saveRememberMePassword(String password) async {
    _cache['remember_me_password'] = password;
  }

  @override
  Future<String?> getRememberedPassword() async {
    return _cache['remember_me_password'] as String?;
  }

  @override
  Future<bool> isRememberMeEnabled() async {
    return _cache['remember_me_enabled'] as bool? ?? false;
  }

  @override
  Future<void> setRememberMeEnabled(bool enabled) async {
    _cache['remember_me_enabled'] = enabled;
  }

  @override
  Future<void> clearRememberMeData() async {
    _cache.remove('remember_me_enabled');
    _cache.remove('remember_me_email');
    _cache.remove('remember_me_password');
  }
}
