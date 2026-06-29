class ResetResponses {
  final String email;
  final String otp;
  final String password;

  const ResetResponses({
    required this.email,
    required this.otp,
    required this.password,
  });

  factory ResetResponses.fromJson(Map<String, dynamic> json) {
    return ResetResponses(
      email: json['email'] as String? ?? '',
      otp: json['otp'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );
  }

  ResetResponses copyWith({
    String? email,
    String? otp,
    String? password,
  }) =>
      ResetResponses(
        email: email ?? this.email,
        otp: otp ?? this.otp,
        password: password ?? this.password,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['otp'] = otp;
    map['password'] = password;
    return map;
  }
}