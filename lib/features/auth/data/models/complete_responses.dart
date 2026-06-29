class CompleteResponses {
  final String email;
  final String name;
  final String phone;
  final String password;

  const CompleteResponses({
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
  });

  factory CompleteResponses.fromJson(Map<String, dynamic> json) => CompleteResponses(
        email: json['email'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String,
        password: json['password'] as String,
      );

  CompleteResponses copyWith({
    String? email,
    String? name,
    String? phone,
    String? password,
  }) =>
      CompleteResponses(
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        password: password ?? this.password,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'phone': phone,
        'password': password,
      };
}