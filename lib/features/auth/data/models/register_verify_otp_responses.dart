class RegisterVerifyOtpResponses {
  final String email;
  final String otp;

  const RegisterVerifyOtpResponses({
    required this.email,
    required this.otp,
  });

  factory RegisterVerifyOtpResponses.fromJson(Map<String, dynamic> json) {
    return RegisterVerifyOtpResponses(
      email: json['email'] as String? ?? '',
      otp: json['otp'] as String? ?? '',
    );
  }

  RegisterVerifyOtpResponses copyWith({
    String? email,
    String? otp,
  }) =>
      RegisterVerifyOtpResponses(
        email: email ?? this.email,
        otp: otp ?? this.otp,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['otp'] = otp;
    return map;
  }
}