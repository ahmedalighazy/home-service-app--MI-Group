import 'package:home_service_app/features/auth/domain/entities/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity {
  const LoginResponseModel({
    required super.token,
    required super.refreshToken,
    required super.id,
    required super.name,
    required super.role,
    required super.pending,
    super.email,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      pending: json['pending'] ?? false,
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'id': id,
      'name': name,
      'role': role,
      'pending': pending,
      'email': email,
    };
  }
}
