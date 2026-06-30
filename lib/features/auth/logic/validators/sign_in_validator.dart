class SignInValidator {
  static Map<String, String?> validateForm({
    required String email,
    required String password,
  }) {
    return {
      'email': validateEmail(email),
      'password': validatePassword(password),
    };
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static bool isFormValid({required String email, required String password}) {
    final errors = validateForm(email: email, password: password);
    return errors.values.every((error) => error == null);
  }

  static bool isEmailValid(String email) => validateEmail(email) == null;
  static bool isPasswordValid(String password) => validatePassword(password) == null;
}
