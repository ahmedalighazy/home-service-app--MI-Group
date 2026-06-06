import 'package:home_service_app/core/utils/validation/auth_validation.dart';
import 'package:home_service_app/features/auth/domain/entities/user_profile.dart';

/// Helper class for profile completion logic and validation
/// Uses unified validation from AuthValidation to avoid code duplication
@Deprecated('Use AuthValidation class instead')
class ProfileCompletionHelper {
  /// Validate email format
  static bool isValidEmail(String email) => AuthValidation.isValidEmail(email);

  /// Validate phone number (Saudi/UAE/Jordan format)
  static bool isValidPhoneNumber(String phone) {
    // Remove spaces and dashes
    final cleanPhone = phone.replaceAll(RegExp(r'[\s-]'), '');
    // Check if it's a valid phone number (9-12 digits)
    return RegExp(r'^\d{9,12}$').hasMatch(cleanPhone);
  }

  /// Validate name (at least 3 characters, no special characters)
  static bool isValidName(String name) {
    return RegExp(r'^[a-zA-Z\u0600-\u06FF\s]{3,}$').hasMatch(name);
  }

  /// Calculate profile completion percentage
  static int calculateCompletionPercentage({
    required bool hasProfileImage,
    required bool hasName,
    required bool hasEmail,
    required bool hasGender,
    bool hasAddress = false,
    bool hasBio = false,
    bool hasDateOfBirth = false,
  }) {
    int percentage = 0;

    // Required fields (25% each)
    if (hasProfileImage) percentage += 25;
    if (hasName) percentage += 25;
    if (hasEmail) percentage += 25;
    if (hasGender) percentage += 25;

    return percentage;
  }

  /// Check if profile is complete (minimum required fields)
  static bool isProfileMinimallyComplete({
    required bool hasProfileImage,
    required bool hasName,
    required bool hasEmail,
    required bool hasGender,
  }) {
    return hasName && hasEmail && hasGender;
  }

  /// Check if profile is fully complete
  static bool isProfileFullyComplete({
    required bool hasProfileImage,
    required bool hasName,
    required bool hasEmail,
    required bool hasGender,
    required bool hasAddress,
    required bool hasBio,
    required bool hasDateOfBirth,
  }) {
    return hasProfileImage &&
        hasName &&
        hasEmail &&
        hasGender &&
        hasAddress &&
        hasBio &&
        hasDateOfBirth;
  }

  /// Format date for display
  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Format date for API
  static String formatDateForApi(DateTime date) {
    return date.toIso8601String().split('T')[0];
  }

  /// Get age from birth date
  static int getAgeFromBirthDate(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    final monthDiff = today.month - birthDate.month;
    if (monthDiff < 0 || (monthDiff == 0 && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  /// Validate age (must be at least 18)
  static bool isAdult(DateTime birthDate) {
    return getAgeFromBirthDate(birthDate) >= 18;
  }

  /// Create UserProfile from form data
  static UserProfile createUserProfileFromForm({
    required String phoneNumber,
    required String fullName,
    required String email,
    required String gender,
    String? profileImageUrl,
    String? address,
    String? bio,
    DateTime? dateOfBirth,
  }) {
    return UserProfile(
      phoneNumber: phoneNumber,
      fullName: fullName,
      email: email,
      gender: gender,
      profileImageUrl: profileImageUrl,
      address: address,
      bio: bio,
      dateOfBirth: dateOfBirth,
      profileCompletionStatus: 'complete',
    );
  }

  /// Get gender display name
  static String getGenderDisplayName(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return 'ذكر';
      case 'female':
        return 'أنثى';
      default:
        return gender;
    }
  }

  /// Get gender icon based on gender value
  static String getGenderEmoji(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return '👨';
      case 'female':
        return '👩';
      default:
        return '👤';
    }
  }

  /// Validate all required fields
  static Map<String, String?> validateAllFields({
    required String name,
    required String email,
    required String? gender,
    String? address,
    String? bio,
  }) {
    final errors = <String, String?>{};

    if (name.isEmpty) {
      errors['name'] = 'الاسم مطلوب';
    } else if (!isValidName(name)) {
      errors['name'] = 'الاسم يجب أن يكون 3 أحرف على الأقل';
    }

    if (email.isEmpty) {
      errors['email'] = 'البريد الإلكتروني مطلوب';
    } else if (!isValidEmail(email)) {
      errors['email'] = 'البريد الإلكتروني غير صحيح';
    }

    if (gender == null || gender.isEmpty) {
      errors['gender'] = 'النوع مطلوب';
    }

    return errors;
  }

  /// Get error message
  static String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'INVALID_EMAIL':
        return 'البريد الإلكتروني غير صحيح';
      case 'INVALID_NAME':
        return 'الاسم غير صحيح';
      case 'INVALID_PHONE':
        return 'رقم الهاتف غير صحيح';
      case 'DUPLICATE_EMAIL':
        return 'البريد الإلكتروني مسجل بالفعل';
      case 'DUPLICATE_PHONE':
        return 'رقم الهاتف مسجل بالفعل';
      case 'NETWORK_ERROR':
        return 'خطأ في الاتصال بالإنترنت';
      case 'SERVER_ERROR':
        return 'خطأ في الخادم، يرجى المحاولة لاحقاً';
      case 'UNDERAGE':
        return 'يجب أن تكون عمرك 18 سنة على الأقل';
      default:
        return 'حدث خطأ ما، يرجى المحاولة مرة أخرى';
    }
  }
}
