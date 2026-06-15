import '../constants/auth_strings.dart';

abstract class AuthException implements Exception {

  final String message;

  final dynamic originalError;

  final StackTrace? stackTrace;

  final String errorCode;

  final bool isRetryable;

  AuthException({
    required this.message,
    required this.errorCode,
    this.originalError,
    this.stackTrace,
    this.isRetryable = false,
  });

  @override
  String toString() => 'AuthException: [$errorCode] $message';
}

class NetworkException extends AuthException {
  NetworkException({
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorNetworkNoInternet,
    errorCode: 'NETWORK_ERROR',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: true,
  );
}

class TimeoutException extends AuthException {
  final Duration? timeout;

  TimeoutException({
    this.timeout,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorNetworkTimeout,
    errorCode: 'TIMEOUT_ERROR',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: true,
  );
}

class ServerException extends AuthException {
  final int? statusCode;

  ServerException({
    String? message,
    this.statusCode,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: message ?? AuthStrings.errorServer,
    errorCode: 'SERVER_ERROR_${statusCode ?? 500}',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: true,
  );
}

class BadRequestException extends AuthException {
  final int? statusCode;

  BadRequestException({
    String? message,
    this.statusCode,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: message ?? AuthStrings.errorBadRequest,
    errorCode: 'BAD_REQUEST_${statusCode ?? 400}',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException({
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorInvalidCredentials,
    errorCode: 'INVALID_CREDENTIALS',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class AccountNotFoundException extends AuthException {
  AccountNotFoundException({
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorAccountNotFound,
    errorCode: 'ACCOUNT_NOT_FOUND',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class AccountLockedException extends AuthException {
  final int? remainingMinutes;

  AccountLockedException({
    this.remainingMinutes,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: remainingMinutes != null
        ? AuthStrings.errorAccountLockedWithTime.replaceFirst('{minutes}', remainingMinutes.toString())
        : AuthStrings.errorAccountLocked,
    errorCode: 'ACCOUNT_LOCKED',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: true,
  );
}

class TokenExpiredException extends AuthException {
  TokenExpiredException({
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorTokenExpired,
    errorCode: 'TOKEN_EXPIRED',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class UnauthorizedException extends AuthException {
  UnauthorizedException({
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorUnauthorized,
    errorCode: 'UNAUTHORIZED',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class ForbiddenException extends AuthException {
  ForbiddenException({
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorForbidden,
    errorCode: 'FORBIDDEN',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class InvalidOtpException extends AuthException {
  final int? attemptsRemaining;

  InvalidOtpException({
    this.attemptsRemaining,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: attemptsRemaining != null
        ? AuthStrings.errorInvalidOtpWithAttempts.replaceFirst('{attempts}', attemptsRemaining.toString())
        : AuthStrings.errorInvalidOtp,
    errorCode: 'INVALID_OTP',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: true,
  );
}

class OtpExpiredException extends AuthException {
  OtpExpiredException({
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorOtpExpired,
    errorCode: 'OTP_EXPIRED',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class SmsSendingException extends AuthException {
  SmsSendingException({
    String? message,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: message ?? AuthStrings.errorSmsSendingFailed,
    errorCode: 'SMS_SENDING_FAILED',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: true,
  );
}

class ValidationException extends AuthException {
  final String? fieldName;
  final dynamic invalidValue;

  ValidationException({
    required String message,
    this.fieldName,
    this.invalidValue,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    errorCode: 'VALIDATION_ERROR_${fieldName?.toUpperCase() ?? 'UNKNOWN'}',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class EmailAlreadyExistsException extends AuthException {
  EmailAlreadyExistsException({
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorEmailAlreadyExists,
    errorCode: 'EMAIL_ALREADY_EXISTS',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class PhoneAlreadyRegisteredException extends AuthException {
  PhoneAlreadyRegisteredException({
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorPhoneAlreadyExists,
    errorCode: 'PHONE_ALREADY_REGISTERED',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class LocalStorageReadException extends AuthException {
  final String? key;

  LocalStorageReadException({
    this.key,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorStorageRead,
    errorCode: 'LOCAL_STORAGE_READ_ERROR',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: true,
  );
}

class LocalStorageWriteException extends AuthException {
  final String? key;

  LocalStorageWriteException({
    this.key,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorStorageWrite,
    errorCode: 'LOCAL_STORAGE_WRITE_ERROR',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: true,
  );
}

class CorruptedDataException extends AuthException {
  final String? dataType;

  CorruptedDataException({
    this.dataType,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: AuthStrings.errorStorageCorrupted,
    errorCode: 'CORRUPTED_DATA',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: true,
  );
}

class UnknownAuthException extends AuthException {
  UnknownAuthException({
    String? message,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
    message: message ?? AuthStrings.errorUnknown,
    errorCode: 'UNKNOWN_ERROR',
    originalError: originalError,
    stackTrace: stackTrace,
    isRetryable: false,
  );
}

class AuthExceptionFactory {

  static AuthException fromException(
    dynamic error, {
    StackTrace? stackTrace,
    String? customMessage,
  }) {
    if (error is AuthException) return error;

    if (error.toString().contains('SocketException') ||
        error.toString().contains('network unreachable')) {
      return NetworkException(
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (error.toString().contains('TimeoutException') ||
        error.toString().contains('deadline exceeded')) {
      return TimeoutException(
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (error.toString().contains('FormatException') ||
        error.toString().contains('JSON')) {
      return CorruptedDataException(
        dataType: 'JSON',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    return UnknownAuthException(
      message: customMessage ?? error.toString(),
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  static AuthException fromHttpStatusCode(
    int statusCode, {
    String? message,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return switch (statusCode) {
      400 => BadRequestException(
        message: message,
        statusCode: statusCode,
        originalError: originalError,
        stackTrace: stackTrace,
      ),
      401 => UnauthorizedException(
        originalError: originalError,
        stackTrace: stackTrace,
      ),
      403 => ForbiddenException(
        originalError: originalError,
        stackTrace: stackTrace,
      ),
      404 => AccountNotFoundException(
        originalError: originalError,
        stackTrace: stackTrace,
      ),
      429 => AccountLockedException(
        originalError: originalError,
        stackTrace: stackTrace,
      ),
      >= 500 => ServerException(
        message: message,
        statusCode: statusCode,
        originalError: originalError,
        stackTrace: stackTrace,
      ),
      _ => UnknownAuthException(
        message: message ?? 'HTTP Error: $statusCode',
        originalError: originalError,
        stackTrace: stackTrace,
      ),
    };
  }
}
