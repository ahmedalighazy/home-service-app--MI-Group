/// User Entity - Domain Layer
/// 
/// Pure Dart class without any external dependencies
/// Used in domain layer only
class UserEntity {
  final String id;
  final String email;
  final String phone;
  final String? name;
  final String? profileImage;
  final String? gender;
  final DateTime createdAt;
  final bool emailVerified;
  final bool phoneVerified;

  const UserEntity({
    required this.id,
    required this.email,
    required this.phone,
    this.name,
    this.profileImage,
    this.gender,
    required this.createdAt,
    this.emailVerified = false,
    this.phoneVerified = false,
  });

  /// Create a copy with some fields replaced
  UserEntity copyWith({
    String? id,
    String? email,
    String? phone,
    String? name,
    String? profileImage,
    String? gender,
    DateTime? createdAt,
    bool? emailVerified,
    bool? phoneVerified,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
    );
  }

  @override
  String toString() => 'UserEntity(id: $id, email: $email, phone: $phone)';
}
