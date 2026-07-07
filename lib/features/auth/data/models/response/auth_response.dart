// ========== Response Models ==========

class LoginResponseModel {
  final String? token;
  final String? refreshToken;
  final String? name;
  final String? id;
  final String? role;
  final bool? pending;
  final String? email;

  LoginResponseModel({
    this.token,
    this.refreshToken,
    this.name,
    this.id,
    this.role,
    this.pending,
    this.email,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json['token'],
        refreshToken: json['refreshToken'],
        name: json['name'],
        id: json['id'],
        role: json['role'],
        pending: json['pending'],
        email: json['email'],
      );
}

class ProfileModel {
  // عرّف حقول البروفايل حسب الحاجة
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  ProfileModel({this.id, this.name, this.email, this.phone, this.role});
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    role: json['role'],
  );
}
