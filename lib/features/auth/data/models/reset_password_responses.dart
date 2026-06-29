class ResetPasswordResponses {
  final String email;
  final String otp;
  final String newPassword;

  const ResetPasswordResponses({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  factory ResetPasswordResponses.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponses(
      email: json['email'] as String? ?? '',
      otp: json['otp'] as String? ?? '',
      newPassword: json['newPassword'] as String? ?? '',
    );
  }

  ResetPasswordResponses copyWith({
    String? email,
    String? otp,
    String? newPassword,
  }) =>
      ResetPasswordResponses(
        email: email ?? this.email,
        otp: otp ?? this.otp,
        newPassword: newPassword ?? this.newPassword,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['otp'] = otp;
    map['newPassword'] = newPassword;
    return map;
  }
}