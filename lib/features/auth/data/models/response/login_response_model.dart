class LoginResponseModel {
  final String? token;
  final String? refreshToken;
  final String? name;
  final String? id;
  final String? role;
  final bool? pending;
  final String? email;

  const LoginResponseModel({
    this.token,
    this.refreshToken,
    this.name,
    this.id,
    this.role,
    this.pending,
    this.email,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      name: json['name'] as String?,
      id: json['id'] as String?,
      role: json['role'] as String?,
      pending: json['pending'] as bool?,
      email: json['email'] as String?,
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
    };
  }
}
