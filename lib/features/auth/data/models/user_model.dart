class UserModel {
  final String? token;
  final String? refreshToken;
  final String? name;
  final String? id;
  final String? role;
  final bool? pending;
  final String? email;
  final String? phone;
  final String? profileImage;
  final String? gender;
  final DateTime? createdAt;
  final bool? emailVerified;
  final bool? phoneVerified;

  const UserModel({
    this.token,
    this.refreshToken,
    this.name,
    this.id,
    this.role,
    this.pending,
    this.email,
    this.phone,
    this.profileImage,
    this.gender,
    this.createdAt,
    this.emailVerified,
    this.phoneVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      name: json['name'] as String?,
      id: json['id'] as String?,
      role: json['role'] as String?,
      pending: json['pending'] as bool?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profileImage'] as String?,
      gender: json['gender'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      emailVerified: json['emailVerified'] as bool?,
      phoneVerified: json['phoneVerified'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'name': name,
      'id': id,
      'role': role,
      'pending': pending,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'gender': gender,
      'createdAt': createdAt?.toIso8601String(),
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
    };
  }
}