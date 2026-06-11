import '../../domain/entities/user_entity.dart';

/// User Model - Data Layer
/// 
/// DTO (Data Transfer Object) for JSON serialization/deserialization
/// Converts between API response and domain entity
class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String email,
    required String phone,
    String? name,
    String? profileImage,
    String? gender,
    required DateTime createdAt,
    bool emailVerified = false,
    bool phoneVerified = false,
  }) : super(
    id: id,
    email: email,
    phone: phone,
    name: name,
    profileImage: profileImage,
    gender: gender,
    createdAt: createdAt,
    emailVerified: emailVerified,
    phoneVerified: phoneVerified,
  );

  /// Convert from JSON (API response)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      name: json['name'] as String?,
      profileImage: json['profileImage'] as String?,
      gender: json['gender'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      emailVerified: json['emailVerified'] as bool? ?? false,
      phoneVerified: json['phoneVerified'] as bool? ?? false,
    );
  }

  /// Convert to JSON (for sending to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'name': name,
      'profileImage': profileImage,
      'gender': gender,
      'createdAt': createdAt.toIso8601String(),
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
    };
  }

  /// Convert UserEntity to UserModel
  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      phone: entity.phone,
      name: entity.name,
      profileImage: entity.profileImage,
      gender: entity.gender,
      createdAt: entity.createdAt,
      emailVerified: entity.emailVerified,
      phoneVerified: entity.phoneVerified,
    );
  }
}
