import 'package:equatable/equatable.dart';

class LoginResponseEntity extends Equatable {
  final String token;
  final String refreshToken;
  final String id;
  final String name;
  final String role;
  final bool pending;
  final String? email;

  const LoginResponseEntity({
    required this.token,
    required this.refreshToken,
    required this.id,
    required this.name,
    required this.role,
    required this.pending,
    this.email,
  });

  @override
  List<Object?> get props => [
    token,
    refreshToken,
    id,
    name,
    role,
    pending,
    email,
  ];
}
