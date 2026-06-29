class ResendOtpResponses {
  final String email;

  const ResendOtpResponses({
    required this.email,
  });

  factory ResendOtpResponses.fromJson(Map<String, dynamic> json) {
    return ResendOtpResponses(
      email: json['email'] as String? ?? '',
    );
  }

  ResendOtpResponses copyWith({
    String? email,
  }) =>
      ResendOtpResponses(
        email: email ?? this.email,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }
}