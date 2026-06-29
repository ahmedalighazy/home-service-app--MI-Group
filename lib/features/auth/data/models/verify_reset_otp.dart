class VerifyResetOtp {
  final String email;
  final String otp;

  const VerifyResetOtp({
    required this.email,
    required this.otp,
  });

  factory VerifyResetOtp.fromJson(Map<String, dynamic> json) {
    return VerifyResetOtp(
      email: json['email'] as String? ?? '',
      otp: json['otp'] as String? ?? '',
    );
  }

  VerifyResetOtp copyWith({
    String? email,
    String? otp,
  }) =>
      VerifyResetOtp(
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