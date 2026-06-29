class RequestResetResponses {
  final String email;

  const RequestResetResponses({
    required this.email,
  });

  factory RequestResetResponses.fromJson(Map<String, dynamic> json) {
    return RequestResetResponses(
      email: json['email'] as String? ?? '',
    );
  }

  RequestResetResponses copyWith({
    String? email,
  }) =>
      RequestResetResponses(
        email: email ?? this.email,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }
}