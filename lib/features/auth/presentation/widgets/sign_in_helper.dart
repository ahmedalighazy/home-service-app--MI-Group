import 'package:home_service_app/core/utils/validation/auth_validation.dart';

/// Helper class for Sign In logic and validation
/// Uses unified validation from AuthValidation to avoid code duplication
@Deprecated('Use AuthValidation class instead')
class SignInHelper {
  /// Validate email format
  static bool isValidEmail(String email) => AuthValidation.isValidEmail(email);

  /// Validate password (minimum 6 characters)
  static bool isValidPassword(String password) => AuthValidation.isValidPassword(password);

  /// Validate email and password together
  static Map<String, bool> validateCredentials({
    required String email,
    required String password,
  }) {
    return {
      'emailValid': isValidEmail(email),
      'passwordValid': isValidPassword(password),
      'bothValid': isValidEmail(email) && isValidPassword(password),
    };
  }

  /// Get error message for email
  static String getEmailErrorMessage(String email) => AuthValidation.getEmailErrorMessage(email);

  /// Get error message for password
  static String getPasswordErrorMessage(String password) => AuthValidation.getPasswordErrorMessage(password);

  /// Check if user selected remember me
  static bool shouldRememberUser(bool rememberMe) {
    return rememberMe;
  }

  /// Save credentials locally (requires secure storage)
  static Future<void> saveCredentialsLocally({
    required String email,
    required String password,
  }) async {
    // TODO: Implement secure storage (SharedPreferences or FlutterSecureStorage)
    // Example using SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('saved_email', email);
    // await prefs.setString('saved_password', password);
  }

  /// Load saved credentials
  static Future<Map<String, String>> loadSavedCredentials() async {
    // TODO: Implement secure storage retrieval
    // Example using SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // return {
    //   'email': prefs.getString('saved_email') ?? '',
    //   'password': prefs.getString('saved_password') ?? '',
    // };
    return {'email': '', 'password': ''};
  }

  /// Clear saved credentials
  static Future<void> clearSavedCredentials() async {
    // TODO: Implement secure storage clearing
    // Example using SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('saved_email');
    // await prefs.remove('saved_password');
  }

  /// Verify email is not already in use (for pre-validation)
  static Future<bool> isEmailAvailable(String email) async {
    // TODO: Call API to verify email availability
    // Example:
    // try {
    //   final response = await http.get(
    //     Uri.parse('https://api.example.com/auth/verify-email?email=$email'),
    //   );
    //   return response.statusCode == 200;
    // } catch (e) {
    //   return false;
    // }
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  /// Get appropriate error message for API errors
  static String getApiErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'INVALID_CREDENTIALS':
        return 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
      case 'USER_NOT_FOUND':
        return 'المستخدم غير مسجل';
      case 'ACCOUNT_DISABLED':
        return 'الحساب معطل';
      case 'TOO_MANY_ATTEMPTS':
        return 'محاولات كثيرة جداً، حاول لاحقاً';
      case 'NETWORK_ERROR':
        return 'خطأ في الاتصال بالإنترنت';
      case 'SERVER_ERROR':
        return 'خطأ في الخادم، حاول لاحقاً';
      case 'INVALID_EMAIL':
        return 'البريد الإلكتروني غير صحيح';
      case 'WEAK_PASSWORD':
        return 'كلمة المرور ضعيفة جداً';
      case 'EMAIL_NOT_VERIFIED':
        return 'يجب التحقق من البريد الإلكتروني أولاً';
      case 'ACCOUNT_SUSPENDED':
        return 'الحساب موقوف مؤقتاً';
      default:
        return 'حدث خطأ ما، يرجى المحاولة مرة أخرى';
    }
  }

  /// Format email for display
  static String formatEmailForDisplay(String email) {
    if (email.length <= 10) {
      return email;
    }
    final parts = email.split('@');
    if (parts.length != 2) {
      return email;
    }
    final localPart = parts[0];
    final domainPart = parts[1];
    return '${localPart.substring(0, 3)}****@$domainPart';
  }

  /// Check if credentials are stored
  static Future<bool> hasStoredCredentials() async {
    // TODO: Check if credentials are stored
    return false;
  }

  /// Get password strength indicator
  static String getPasswordStrength(String password) {
    if (password.isEmpty) {
      return 'empty';
    }
    if (password.length < 6) {
      return 'weak';
    }
    if (password.length < 12) {
      return 'medium';
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'strong';
    }
    return 'medium';
  }

  /// Check if email looks valid (basic check)
  static bool looksLikeEmail(String input) {
    return input.contains('@') && input.contains('.');
  }

  /// Sanitize email input
  static String sanitizeEmail(String email) {
    return email.trim().toLowerCase();
  }

  /// Create login analytics data
  static Map<String, dynamic> createLoginAnalytics({
    required String email,
    required String method, // email, google, apple
    required int duration, // time taken in milliseconds
  }) {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'method': method,
      'email_domain': email.split('@').length > 1 ? email.split('@')[1] : 'unknown',
      'duration_ms': duration,
    };
  }
}

/// Sign In Models
class SignInRequest {
  final String email;
  final String password;
  final bool rememberMe;

  SignInRequest({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class SignInResponse {
  final bool success;
  final String message;
  final String? accessToken;
  final String? refreshToken;
  final UserSignInData? userData;

  SignInResponse({
    required this.success,
    required this.message,
    this.accessToken,
    this.refreshToken,
    this.userData,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      userData: json['userData'] != null
          ? UserSignInData.fromJson(json['userData'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userData': userData?.toJson(),
    };
  }
}

class UserSignInData {
  final String id;
  final String email;
  final String fullName;
  final String? profileImage;
  final bool emailVerified;

  UserSignInData({
    required this.id,
    required this.email,
    required this.fullName,
    this.profileImage,
    required this.emailVerified,
  });

  factory UserSignInData.fromJson(Map<String, dynamic> json) {
    return UserSignInData(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      profileImage: json['profileImage'] as String?,
      emailVerified: json['emailVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'profileImage': profileImage,
      'emailVerified': emailVerified,
    };
  }
}

/// Sign In Exceptions
class SignInException implements Exception {
  final String message;
  final String? code;

  SignInException(this.message, {this.code});

  @override
  String toString() => message;
}

class InvalidCredentialsException extends SignInException {
  InvalidCredentialsException()
      : super('البريد الإلكتروني أو كلمة المرور غير صحيحة',
            code: 'INVALID_CREDENTIALS');
}

class UserNotFoundException extends SignInException {
  UserNotFoundException() : super('المستخدم غير مسجل', code: 'USER_NOT_FOUND');
}

class AccountDisabledException extends SignInException {
  AccountDisabledException() : super('الحساب معطل', code: 'ACCOUNT_DISABLED');
}

class NetworkException extends SignInException {
  NetworkException() : super('خطأ في الاتصال بالإنترنت', code: 'NETWORK_ERROR');
}
