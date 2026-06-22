import '../models/user_model.dart';
import '../models/auth_token_model.dart';

/// Auth Local Data Source Interface - Data Layer
/// 
/// Abstract interface for local storage (SharedPreferences, Hive, etc)
abstract class AuthLocalDataSource {
  /// Save user to local storage
  Future<void> saveUser(UserModel user);

  /// Get cached user
  Future<UserModel?> getUser();

  /// Delete cached user
  Future<void> deleteUser();

  /// Save auth token
  Future<void> saveToken(AuthTokenModel token);

  /// Get cached auth token
  Future<AuthTokenModel?> getToken();

  /// Delete cached token
  Future<void> deleteToken();

  /// Check if user is logged in
  Future<bool> isUserLoggedIn();

  /// Clear all auth data
  Future<void> clearAllAuthData();

  /// Save OTP for verification
  Future<void> saveOtpData({
    required String phoneNumber,
    required String otpId,
  });

  /// Get cached OTP data
  Future<Map<String, String>?> getOtpData();

  /// Clear OTP data
  Future<void> clearOtpData();

  // ============================================================================
  // Token Manager Methods
  // ============================================================================

  /// Save access token string (separate from AuthTokenModel)
  Future<void> saveAccessToken(String token);

  /// Save refresh token string
  Future<void> saveRefreshToken(String refreshToken);

  /// Get stored access token
  Future<String?> getAccessToken();

  /// Get stored refresh token
  Future<String?> getRefreshToken();

  /// Get access token with "Bearer " prefix
  Future<String?> getBearerToken();

  /// Check if token exists and is not empty
  Future<bool> hasToken();

  /// Save token expiry timestamp
  Future<void> saveTokenExpiry(DateTime expiryTime);

  /// Check if token is still valid (not expired)
  Future<bool> isTokenValid();

  /// Get time remaining until token expires
  Future<Duration?> getTimeUntilExpiry();

  /// Check if token is expiring soon (within 60 seconds)
  Future<bool> isTokenExpiringSoon();

  /// Save user data as JSON
  Future<void> saveUserData(Map<String, dynamic> userData);

  /// Get stored user data as JSON
  Future<Map<String, dynamic>?> getUserData();

  // ============================================================================
  // Remember Me Methods
  // ============================================================================

  /// Save email for Remember Me
  Future<void> saveRememberMeEmail(String email);

  /// Get remembered email
  Future<String?> getRememberedEmail();

  /// Save password for Remember Me (encrypted)
  Future<void> saveRememberMePassword(String password);

  /// Get remembered password (encrypted)
  Future<String?> getRememberedPassword();

  /// Check if Remember Me is enabled
  Future<bool> isRememberMeEnabled();

  /// Enable/Disable Remember Me
  Future<void> setRememberMeEnabled(bool enabled);

  /// Clear Remember Me data (on logout)
  Future<void> clearRememberMeData();
}
