class GoogleResponses {
  final String token;
  final String refreshToken;
  final String name;
  final String id;
  final String role;
  final bool pending;
  final String email;

  const GoogleResponses({
    required this.token,
    required this.refreshToken,
    required this.name,
    required this.id,
    required this.role,
    required this.pending,
    required this.email,
  });

  factory GoogleResponses.fromJson(Map<String, dynamic> json) {
    return GoogleResponses(
      token: json['token'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      role: json['role'] as String? ?? '',
      pending: json['pending'] as bool? ?? false,
      email: json['email'] as String? ?? '',
    );
  }

  GoogleResponses copyWith({
    String? token,
    String? refreshToken,
    String? name,
    String? id,
    String? role,
    bool? pending,
    String? email,
  }) =>
      GoogleResponses(
        token: token ?? this.token,
        refreshToken: refreshToken ?? this.refreshToken,
        name: name ?? this.name,
        id: id ?? this.id,
        role: role ?? this.role,
        pending: pending ?? this.pending,
        email: email ?? this.email,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['refreshToken'] = refreshToken;
    map['name'] = name;
    map['id'] = id;
    map['role'] = role;
    map['pending'] = pending;
    map['email'] = email;
    return map;
  }
}