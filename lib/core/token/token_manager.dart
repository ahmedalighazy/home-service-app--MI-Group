import '../utils/helpers/cache_helper.dart';

class TokenManager {
  static const String tokenKey = 'token';
  static const String refreshTokenKey = 'refreshToken';

  Future<String?> getToken() => CacheHelper.getSecure(tokenKey);
  Future<String?> getRefreshToken() => CacheHelper.getSecure(refreshTokenKey);

  Future<void> saveTokens(String token, {String? refreshToken}) async {
    await CacheHelper.setSecure(tokenKey, token);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await CacheHelper.setSecure(refreshTokenKey, refreshToken);
    }
  }

  Future<void> clearTokens() async {
    await CacheHelper.removeSecure(tokenKey);
    await CacheHelper.removeSecure(refreshTokenKey);
  }

  String getAuthHeader(String token) => 'Bearer $token';
}
