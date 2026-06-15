import 'package:home_service_app/core/utils/validation/validators_helper.dart';

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
    final err = ValidatorsHelper.getNameErrorMessage(name);
    return err.isEmpty ? null : err;
  }

  /// Validate email field
  /// 
  /// Returns null if email is valid, error message otherwise.
  static String? validateEmail(String email) {
    final err = ValidatorsHelper.getEmailErrorMessage(email);
    return err.isEmpty ? null : err;
  }

  /// Validate gender field
  /// 
  /// Returns null if gender is valid, error message otherwise.
  static String? validateGender(String gender) {
    final err = ValidatorsHelper.getGenderErrorMessage(gender);
    return err.isEmpty ? null : err;
  }

  /// Validate optional address field
  /// 
  /// Returns null if address is valid, error message otherwise.
  static String? validateAddress(String? address) {
    final err = ValidatorsHelper.getAddressErrorMessage(address);
    return err.isEmpty ? null : err;
  }

  /// Validate optional bio field
  /// 
  /// Returns null if bio is valid, error message otherwise.
  static String? validateBio(String? bio) {
    final err = ValidatorsHelper.getBioErrorMessage(bio);
    return err.isEmpty ? null : err;
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
