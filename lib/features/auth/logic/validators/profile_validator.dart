import 'package:home_service_app/core/utils/validation/auth_validation.dart';

/// Validates Complete Profile form data
/// 
/// This validator ensures all profile fields meet required criteria.
/// Usage:
/// ```dart
/// if (!ProfileValidator.isFormValid(name: name, email: email, gender: gender)) {
///   final errors = ProfileValidator.validateForm(name: name, email: email, gender: gender);
///   // Show errors to user
/// }
/// ```
class ProfileValidator {
  /// Validate the entire profile completion form
  /// 
  /// Returns a map with error messages for each field.
  /// Returns null for fields that are valid.
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

  /// Validate name field
  /// 
  /// Returns null if name is valid, error message otherwise.
  static String? validateName(String name) {
    if (name.isEmpty) {
      return 'Name is required';
    }
    if (name.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Validate email field
  /// 
  /// Returns null if email is valid, error message otherwise.
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!AuthValidation.isValidEmail(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  /// Validate gender field
  /// 
  /// Returns null if gender is valid, error message otherwise.
  static String? validateGender(String gender) {
    if (gender.isEmpty) {
      return 'Gender is required';
    }
    return null;
  }

  /// Validate optional address field
  /// 
  /// Returns null if address is valid, error message otherwise.
  static String? validateAddress(String? address) {
    // Address is optional, so only validate length if provided
    if (address != null && address.isNotEmpty && address.length > 200) {
      return 'Address must be less than 200 characters';
    }
    return null;
  }

  /// Validate optional bio field
  /// 
  /// Returns null if bio is valid, error message otherwise.
  static String? validateBio(String? bio) {
    // Bio is optional, so only validate length if provided
    if (bio != null && bio.isNotEmpty && bio.length > 500) {
      return 'Bio must be less than 500 characters';
    }
    return null;
  }

  /// Check if entire form is valid
  /// 
  /// Returns true if all required fields are valid, false otherwise.
  static bool isFormValid({
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  }) {
    final errors = validateForm(name: name, email: email, gender: gender);
    final isRequiredValid = errors.values.every((error) => error == null);
    
    final addressError = validateAddress(address);
    final bioError = validateBio(bio);
    
    return isRequiredValid && addressError == null && bioError == null;
  }

  /// Check if name field is valid
  static bool isNameValid(String name) {
    return validateName(name) == null;
  }

  /// Check if email field is valid
  static bool isEmailValid(String email) {
    return validateEmail(email) == null;
  }

  /// Check if gender field is valid
  static bool isGenderValid(String gender) {
    return validateGender(gender) == null;
  }
}
