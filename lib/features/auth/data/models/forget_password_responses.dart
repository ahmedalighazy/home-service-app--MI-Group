class ForgetPasswordResponses {
  final String email;

  const ForgetPasswordResponses({
    required this.email,
  });

  factory ForgetPasswordResponses.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponses(
      email: json['email'] as String? ?? '',
    );
  }

  ForgetPasswordResponses copyWith({
    String? email,
  }) =>
      ForgetPasswordResponses(
        email: email ?? this.email,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }
}