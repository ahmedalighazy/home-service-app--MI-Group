/// Validates Sign In form data
/// 
/// This validator ensures all Sign In inputs meet the required criteria.
/// Usage:
/// ```dart
/// if (!SignInValidator.isFormValid(email: email, password: password)) {
///   final errors = SignInValidator.validateForm(email: email, password: password);
///   // Show errors to user
/// }
/// ```
class SignInValidator {
  /// Validate the entire Sign In form
  /// 
  /// Returns a map with error messages for each field.
  /// Returns null for fields that are valid.
  static Map<String, String?> validateForm({
    required String email,
    required String password,
  }) {
    return {
      'email': validateEmail(email),
      'password': validatePassword(password),
    };
  }

  /// Validate email field
  /// 
  /// Returns null if email is valid, error message otherwise.
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }
    // Basic email regex validation
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  /// Validate password field
  /// 
  /// Returns null if password is valid, error message otherwise.
  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Check if entire form is valid
  /// 
  /// Returns true if all fields are valid, false otherwise.
  static bool isFormValid({
    required String email,
    required String password,
  }) {
    final errors = validateForm(email: email, password: password);
    return errors.values.every((error) => error == null);
  }

  /// Check if email field is valid
  static bool isEmailValid(String email) {
    return validateEmail(email) == null;
  }

  /// Check if password field is valid
  static bool isPasswordValid(String password) {
    return validatePassword(password) == null;
  }
}
