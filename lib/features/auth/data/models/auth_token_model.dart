import '../../domain/entities/auth_token_entity.dart';

/// Auth Token Model - Data Layer
///
/// DTO for API token responses
class AuthTokenModel extends AuthTokenEntity {
  const AuthTokenModel({
    required super.accessToken,
    super.refreshToken,
    required super.expiresAt,
    super.tokenType,
  });

  /// Convert from JSON (API response)
  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    final expiresIn = json['expiresIn'] as int? ?? 3600; // default 1 hour
    return AuthTokenModel(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String?,
      expiresAt: DateTime.now().add(Duration(seconds: expiresIn)),
      tokenType: json['tokenType'] as String? ?? 'Bearer',
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt.toIso8601String(),
      'tokenType': tokenType,
    };
  }

  /// Convert AuthTokenEntity to AuthTokenModel
  static AuthTokenModel fromEntity(AuthTokenEntity entity) {
    return AuthTokenModel(
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
      expiresAt: entity.expiresAt,
      tokenType: entity.tokenType,
    );
  }
}
