abstract class SignUpState {
  const SignUpState();
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
}
