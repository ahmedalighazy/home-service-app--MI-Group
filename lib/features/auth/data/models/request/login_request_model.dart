class LoginRequestModel {
  final String identifier;
  final String password;

  const LoginRequestModel({required this.identifier, required this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      identifier: json['identifier'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'identifier': identifier, 'password': password};
  }
}
