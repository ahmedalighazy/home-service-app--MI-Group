/// Auth Token Entity - Domain Layer
/// 
/// Represents authentication tokens returned from backend
class AuthTokenEntity {
  final String accessToken;
  final String? refreshToken;
  final DateTime expiresAt;
  final String tokenType;

  const AuthTokenEntity({
    required this.accessToken,
    this.refreshToken,
    required this.expiresAt,
    this.tokenType = 'Bearer',
  });

  /// Check if token is expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Check if token is still valid
  bool get isValid => !isExpired;

  @override
  String toString() =>
      'AuthTokenEntity(tokenType: $tokenType, expiresAt: $expiresAt)';
}
