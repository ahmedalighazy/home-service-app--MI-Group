class RegisterResponses {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String role;

  const RegisterResponses({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
  });

  factory RegisterResponses.fromJson(Map<String, dynamic> json) {
    return RegisterResponses(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );
  }

  RegisterResponses copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? role,
  }) =>
      RegisterResponses(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        role: role ?? this.role,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['phone'] = phone;
    map['role'] = role;
    return map;
  }
}