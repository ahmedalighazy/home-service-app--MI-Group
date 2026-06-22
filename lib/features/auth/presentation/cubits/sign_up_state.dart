import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpChanged extends SignUpState {
  final String email;
  final String? emailError;
  final String password;
  final String? passwordError;
  final String confirmPassword;
  final String? confirmPasswordError;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  const SignUpChanged({
    required this.email,
    this.emailError,
    required this.password,
    this.passwordError,
    required this.confirmPassword,
    this.confirmPasswordError,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        email,
        emailError,
        password,
        passwordError,
        confirmPassword,
        confirmPasswordError,
        firstName,
        lastName,
        phoneNumber,
      ];

  SignUpChanged copyWith({
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    String? confirmPassword,
    String? confirmPasswordError,
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) {
    return SignUpChanged(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
}

class SignUpError extends SignUpState {
  final String message;

  const SignUpError(this.message);

  @override
  List<Object?> get props => [message];
}
