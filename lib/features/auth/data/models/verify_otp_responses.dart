class VerifyOtpResponses {
  final String email;
  final String otp;

  const VerifyOtpResponses({
    required this.email,
    required this.otp,
  });

  factory VerifyOtpResponses.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponses(
      email: json['email'] as String? ?? '',
      otp: json['otp'] as String? ?? '',
    );
  }

  VerifyOtpResponses copyWith({
    String? email,
    String? otp,
  }) =>
      VerifyOtpResponses(
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