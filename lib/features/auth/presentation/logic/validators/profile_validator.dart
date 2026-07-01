import 'package:home_service_app/core/utils/validation/auth_validation.dart';

class ProfileValidator {
  static Map<String, String?> validateForm({
    required String name,
    required String email,
    required String gender,
  }) {
    return {
      'name': validateName(name),
      'email': validateEmail(email),
      'gender': validateGender(gender),
    };
  }

  static String? validateName(String name) {
    if (name.isEmpty) return 'Name is required';
    if (name.trim().length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!AuthValidation.isValidEmail(email)) return 'Invalid email format';
    return null;
  }

  static String? validateGender(String gender) {
    if (gender.isEmpty) return 'Gender is required';
    return null;
  }

  static String? validateAddress(String? address) {
    if (address != null && address.isNotEmpty && address.length > 200) {
      return 'Address must be less than 200 characters';
    }
    return null;
  }

  static String? validateBio(String? bio) {
    if (bio != null && bio.isNotEmpty && bio.length > 500) {
      return 'Bio must be less than 500 characters';
    }
    return null;
  }

  static bool isFormValid({
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  }) {
    final errors = validateForm(name: name, email: email, gender: gender);
    final isRequiredValid = errors.values.every((error) => error == null);
    return isRequiredValid && validateAddress(address) == null && validateBio(bio) == null;
  }

  static bool isNameValid(String name) => validateName(name) == null;
  static bool isEmailValid(String email) => validateEmail(email) == null;
  static bool isGenderValid(String gender) => validateGender(gender) == null;
}
