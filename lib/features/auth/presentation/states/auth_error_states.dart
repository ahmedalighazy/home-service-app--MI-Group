
import 'package:equatable/equatable.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

// ════════════════════════════════════════════════════════════════
// Base Error State
// ════════════════════════════════════════════════════════════════

/// Base error state with common properties
abstract class AuthErrorState extends Equatable {
  /// Error message to display to user
  final String message;
  
  /// Error code for categorization
  final String errorCode;
  
  /// Whether user can retry
  final bool canRetry;
  
  /// Whether to show detailed error
  final bool showDetails;
  
  /// Original exception message (for logging)
  final String? exceptionDetails;
  
  /// Error context data
  final Map<String, dynamic>? context;

  const AuthErrorState({
    required this.message,
    required this.errorCode,
    this.canRetry = false,
    this.showDetails = false,
    this.exceptionDetails,
    this.context,
  });

  @override
  List<Object?> get props => [
    message,
    errorCode,
    canRetry,
    showDetails,
    exceptionDetails,
    context,
  ];
}

// ════════════════════════════════════════════════════════════════
// Network Related Errors
// ════════════════════════════════════════════════════════════════

/// Network connectivity error
class NetworkErrorState extends AuthErrorState {
  NetworkErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message ?? AuthStrings.errorNetworkNoInternet,
    errorCode: 'NETWORK_ERROR',
    canRetry: true,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );
}

/// Request timeout error
class TimeoutErrorState extends AuthErrorState {
  /// Timeout duration in seconds
  final int timeoutSeconds;

  TimeoutErrorState({
    String? message,
    this.timeoutSeconds = 30,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message ?? AuthStrings.errorNetworkTimeout,
    errorCode: 'TIMEOUT_ERROR',
    canRetry: true,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );

  @override
  List<Object?> get props => [...super.props, timeoutSeconds];
}

/// Server error (5xx)
class ServerErrorState extends AuthErrorState {
  /// HTTP status code
  final int? statusCode;
  
  /// Whether to suggest contacting support
  final bool suggestContact;

  ServerErrorState({
    String? message,
    this.statusCode,
    this.suggestContact = true,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message ?? AuthStrings.errorServer,
    errorCode: 'SERVER_ERROR',
    canRetry: true,
    showDetails: true,
    exceptionDetails: exceptionDetails,
    context: context,
  );

  @override
  List<Object?> get props => [...super.props, statusCode, suggestContact];
}

/// Bad request error (400)
class BadRequestErrorState extends AuthErrorState {
  BadRequestErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message ?? AuthStrings.errorBadRequest,
    errorCode: 'BAD_REQUEST_ERROR',
    canRetry: false,
    showDetails: true,
    exceptionDetails: exceptionDetails,
    context: context,
  );
}

// ════════════════════════════════════════════════════════════════
// Authentication Related Errors
// ════════════════════════════════════════════════════════════════

/// Invalid credentials error
class InvalidCredentialsErrorState extends AuthErrorState {
  /// Number of failed attempts
  final int failedAttempts;
  
  /// Remaining attempts before lockout
  final int? remainingAttempts;

  const InvalidCredentialsErrorState({
    String message = 'بريد إلكتروني أو كلمة مرور غير صحيحة.',
    this.failedAttempts = 1,
    this.remainingAttempts,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'INVALID_CREDENTIALS',
    canRetry: true,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );

  @override
  List<Object?> get props => [
    ...super.props,
    failedAttempts,
    remainingAttempts,
  ];
}

/// Account not found error
class AccountNotFoundErrorState extends AuthErrorState {
  const AccountNotFoundErrorState({
    String message = 'الحساب غير موجود. يرجى التسجيل أولاً.',
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'ACCOUNT_NOT_FOUND',
    canRetry: false,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );
}

/// Account locked error
class AccountLockedErrorState extends AuthErrorState {
  /// Remaining minutes until account unlocks
  final int? remainingMinutes;

  AccountLockedErrorState({
    String? message,
    this.remainingMinutes,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: remainingMinutes != null
        ? 'الحساب مقفول. حاول مجددًا بعد $remainingMinutes دقيقة.'
        : (message ?? 'الحساب مقفول. حاول مجددًا بعد قليل.'),
    errorCode: 'ACCOUNT_LOCKED',
    canRetry: true,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );

  @override
  List<Object?> get props => [...super.props, remainingMinutes];
}

/// Token expired error
class TokenExpiredErrorState extends AuthErrorState {
  const TokenExpiredErrorState({
    String message = 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مجددًا.',
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'TOKEN_EXPIRED',
    canRetry: false,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );
}

/// Unauthorized error
class UnauthorizedErrorState extends AuthErrorState {
  const UnauthorizedErrorState({
    String message = 'غير مصرح. يرجى تسجيل الدخول مجددًا.',
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'UNAUTHORIZED',
    canRetry: false,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );
}

// ════════════════════════════════════════════════════════════════
// OTP Related Errors
// ════════════════════════════════════════════════════════════════

/// Invalid OTP code error
class InvalidOtpErrorState extends AuthErrorState {
  /// Number of failed attempts
  final int failedAttempts;
  
  /// Remaining attempts before expiry
  final int? remainingAttempts;

  InvalidOtpErrorState({
    String? message,
    this.failedAttempts = 1,
    this.remainingAttempts,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: remainingAttempts != null
        ? 'كود التحقق غير صحيح. لديك $remainingAttempts محاولات متبقية.'
        : (message ?? 'كود التحقق غير صحيح.'),
    errorCode: 'INVALID_OTP',
    canRetry: true,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );

  @override
  List<Object?> get props => [
    ...super.props,
    failedAttempts,
    remainingAttempts,
  ];
}

/// OTP expired error
class OtpExpiredErrorState extends AuthErrorState {
  const OtpExpiredErrorState({
    String message = 'انتهت صلاحية كود التحقق. يرجى طلب كود جديد.',
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'OTP_EXPIRED',
    canRetry: false,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );
}

/// SMS sending failed error
class SmsSendingErrorState extends AuthErrorState {
  const SmsSendingErrorState({
    String message = 'فشل إرسال رسالة التحقق. يرجى المحاولة مجددًا.',
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'SMS_SENDING_FAILED',
    canRetry: true,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );
}

// ════════════════════════════════════════════════════════════════
// Validation Errors
// ════════════════════════════════════════════════════════════════

/// Validation error
class ValidationErrorState extends AuthErrorState {
  /// Field that failed validation
  final String? fieldName;
  
  /// Validation rule that failed
  final String? validationRule;

  const ValidationErrorState({
    required String message,
    this.fieldName,
    this.validationRule,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'VALIDATION_ERROR',
    canRetry: true,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );

  @override
  List<Object?> get props => [
    ...super.props,
    fieldName,
    validationRule,
  ];
}

/// Email already exists error
class EmailAlreadyExistsErrorState extends AuthErrorState {
  const EmailAlreadyExistsErrorState({
    String message = 'هذا البريد الإلكتروني مسجل بالفعل.',
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'EMAIL_ALREADY_EXISTS',
    canRetry: false,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );
}

/// Phone already registered error
class PhoneAlreadyRegisteredErrorState extends AuthErrorState {
  const PhoneAlreadyRegisteredErrorState({
    String message = 'هذا الرقم مسجل بالفعل.',
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'PHONE_ALREADY_REGISTERED',
    canRetry: false,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );
}

// ════════════════════════════════════════════════════════════════
// Local Storage Errors
// ════════════════════════════════════════════════════════════════

/// Local storage error
class LocalStorageErrorState extends AuthErrorState {
  /// Type of storage operation
  final String? operationType; // 'read', 'write', 'delete'

  const LocalStorageErrorState({
    String message = 'فشل الوصول إلى البيانات المحلية.',
    this.operationType,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'LOCAL_STORAGE_ERROR',
    canRetry: true,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );

  @override
  List<Object?> get props => [...super.props, operationType];
}

// ════════════════════════════════════════════════════════════════
// Unknown/Generic Error
// ════════════════════════════════════════════════════════════════

/// Unknown/generic error
class UnknownErrorState extends AuthErrorState {
  /// Error severity level
  final String severity; // 'info', 'warning', 'error', 'critical'

  const UnknownErrorState({
    String message = 'حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.',
    this.severity = 'error',
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
    message: message,
    errorCode: 'UNKNOWN_ERROR',
    canRetry: false,
    showDetails: false,
    exceptionDetails: exceptionDetails,
    context: context,
  );

  @override
  List<Object?> get props => [...super.props, severity];
}
