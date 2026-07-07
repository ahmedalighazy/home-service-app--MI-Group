import 'package:easy_localization/easy_localization.dart';

class ApiErrorModel {
  final String? timestamp;
  final int? status;
  final String? error;
  final String? message;

  const ApiErrorModel({this.timestamp, this.status, this.error, this.message});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      timestamp: json['timestamp'] as String?,
      status: json['status'] as int?,
      error: json['error'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'status': status,
      'error': error,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'ApiErrorModel('
        'timestamp: $timestamp, '
        'status: $status, '
        'error: $error, '
        'message: $message'
        ')';
  }

  String getLocalizedErrorMessage() {
    final original = message?.toLowerCase() ?? '';

    if (original.contains('email sending failed') ||
        original.contains('failed to send email')) {
      return 'error_email_sending_failed'.tr();
    }
    if (original.contains('invalid otp') ||
        original.contains('otp invalid')) {
      return 'errorInvalidOtp'.tr();
    }
    if (original.contains('invalid credentials')) {
      return 'error_invalid_credentials'.tr();
    }
    if (original.contains('user not found')) {
      return 'error_account_not_found_signup'.tr();
    }
    if (original.contains('invalid email') ||
        original.contains('invalid password')) {
      return 'error_invalid_email_password'.tr();
    }

    return 'error_something_went_wrong'.tr();
  }
}