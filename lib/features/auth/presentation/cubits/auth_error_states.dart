import 'package:equatable/equatable.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

abstract class AuthErrorState extends Equatable {
  final String message;
  final String errorCode;
  final bool canRetry;
  final bool showDetails;
  final String? exceptionDetails;
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

class NetworkErrorState extends AuthErrorState {
  NetworkErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorNetworkNoInternet'),
          errorCode: 'NETWORK_ERROR',
          canRetry: true,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );
}

class TimeoutErrorState extends AuthErrorState {
  final int timeoutSeconds;

  TimeoutErrorState({
    String? message,
    this.timeoutSeconds = 30,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorNetworkTimeout'),
          errorCode: 'TIMEOUT_ERROR',
          canRetry: true,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );

  @override
  List<Object?> get props => [...super.props, timeoutSeconds];
}

class ServerErrorState extends AuthErrorState {
  final int? statusCode;
  final bool suggestContact;

  ServerErrorState({
    String? message,
    this.statusCode,
    this.suggestContact = true,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorServer'),
          errorCode: 'SERVER_ERROR',
          canRetry: true,
          showDetails: true,
          exceptionDetails: exceptionDetails,
          context: context,
        );

  @override
  List<Object?> get props => [...super.props, statusCode, suggestContact];
}

class BadRequestErrorState extends AuthErrorState {
  BadRequestErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorBadRequest'),
          errorCode: 'BAD_REQUEST_ERROR',
          canRetry: false,
          showDetails: true,
          exceptionDetails: exceptionDetails,
          context: context,
        );
}

class InvalidCredentialsErrorState extends AuthErrorState {
  final int failedAttempts;
  final int? remainingAttempts;

  InvalidCredentialsErrorState({
    String? message,
    this.failedAttempts = 1,
    this.remainingAttempts,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorUnauthorized'),
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

class AccountNotFoundErrorState extends AuthErrorState {
  AccountNotFoundErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorForbidden'),
          errorCode: 'ACCOUNT_NOT_FOUND',
          canRetry: false,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );
}

class AccountLockedErrorState extends AuthErrorState {
  final int? remainingMinutes;

  AccountLockedErrorState({
    String? message,
    this.remainingMinutes,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: remainingMinutes != null
              ? LocalizationService.instance.translate('errorAccountLocked')
                  .replaceAll('{minutes}', remainingMinutes.toString())
              : (message ?? LocalizationService.instance.translate('errorAccountLocked')),
          errorCode: 'ACCOUNT_LOCKED',
          canRetry: true,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );

  @override
  List<Object?> get props => [...super.props, remainingMinutes];
}

class TokenExpiredErrorState extends AuthErrorState {
  TokenExpiredErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorTokenExpired'),
          errorCode: 'TOKEN_EXPIRED',
          canRetry: false,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );
}

class UnauthorizedErrorState extends AuthErrorState {
  UnauthorizedErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorUnauthorized'),
          errorCode: 'UNAUTHORIZED',
          canRetry: false,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );
}

class InvalidOtpErrorState extends AuthErrorState {
  final int failedAttempts;
  final int? remainingAttempts;

  InvalidOtpErrorState({
    String? message,
    this.failedAttempts = 1,
    this.remainingAttempts,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: remainingAttempts != null
              ? LocalizationService.instance.translate('errorInvalidOtp')
                  .replaceAll('{attempts}', remainingAttempts.toString())
              : (message ?? LocalizationService.instance.translate('errorInvalidOtp')),
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

class OtpExpiredErrorState extends AuthErrorState {
  OtpExpiredErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorOtpExpired'),
          errorCode: 'OTP_EXPIRED',
          canRetry: false,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );
}

class SmsSendingErrorState extends AuthErrorState {
  SmsSendingErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorSmsSendingFailed'),
          errorCode: 'SMS_SENDING_FAILED',
          canRetry: true,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );
}

class ValidationErrorState extends AuthErrorState {
  final String? fieldName;
  final String? validationRule;

  ValidationErrorState({
    String? message,
    this.fieldName,
    this.validationRule,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorValidationGeneric'),
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

class EmailAlreadyExistsErrorState extends AuthErrorState {
  EmailAlreadyExistsErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorEmailAlreadyExists'),
          errorCode: 'EMAIL_ALREADY_EXISTS',
          canRetry: false,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );
}

class PhoneAlreadyRegisteredErrorState extends AuthErrorState {
  PhoneAlreadyRegisteredErrorState({
    String? message,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorPhoneAlreadyExists'),
          errorCode: 'PHONE_ALREADY_REGISTERED',
          canRetry: false,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );
}

class LocalStorageErrorState extends AuthErrorState {
  final String? operationType;

  LocalStorageErrorState({
    String? message,
    this.operationType,
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorLocalStorage'),
          errorCode: 'LOCAL_STORAGE_ERROR',
          canRetry: true,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );

  @override
  List<Object?> get props => [...super.props, operationType];
}

class UnknownErrorState extends AuthErrorState {
  final String severity;

  UnknownErrorState({
    String? message,
    this.severity = 'error',
    String? exceptionDetails,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? LocalizationService.instance.translate('errorUnknown'),
          errorCode: 'UNKNOWN_ERROR',
          canRetry: false,
          showDetails: false,
          exceptionDetails: exceptionDetails,
          context: context,
        );

  @override
  List<Object?> get props => [...super.props, severity];
}