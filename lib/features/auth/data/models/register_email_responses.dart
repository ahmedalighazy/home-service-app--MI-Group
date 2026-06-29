class RegisterEmailResponses {
  final String email;

  const RegisterEmailResponses({
    required this.email,
  });

  factory RegisterEmailResponses.fromJson(Map<String, dynamic> json) {
    return RegisterEmailResponses(
      email: json['email'] as String? ?? '',
    );
  }

  RegisterEmailResponses copyWith({
    String? email,
  }) =>
      RegisterEmailResponses(
        email: email ?? this.email,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }
}