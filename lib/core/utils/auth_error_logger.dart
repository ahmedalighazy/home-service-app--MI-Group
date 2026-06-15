import 'package:flutter/foundation.dart';
import '../error/auth_exceptions.dart';

class ErrorLogEntry {

  final String logId;

  final DateTime timestamp;

  final String errorCode;

  final String message;

  final String? exceptionDetails;

  final StackTrace? stackTrace;

  final int? httpStatusCode;

  final bool isRetryable;

  final ErrorSeverity severity;

  final String? userId;

  final Map<String, dynamic>? context;

  ErrorLogEntry({
    required this.logId,
    required this.timestamp,
    required this.errorCode,
    required this.message,
    this.exceptionDetails,
    this.stackTrace,
    this.httpStatusCode,
    this.isRetryable = false,
    this.severity = ErrorSeverity.error,
    this.userId,
    this.context,
  });

  @override
  String toString() => '''
ErrorLogEntry {
  logId: $logId
  timestamp: $timestamp
  errorCode: $errorCode
  message: $message
  severity: $severity
  isRetryable: $isRetryable
  httpStatusCode: $httpStatusCode
  context: $context
}''';

  Map<String, dynamic> toJson() => {
    'logId': logId,
    'timestamp': timestamp.toIso8601String(),
    'errorCode': errorCode,
    'message': message,
    'exceptionDetails': exceptionDetails,
    'httpStatusCode': httpStatusCode,
    'isRetryable': isRetryable,
    'severity': severity.name,
    'userId': userId,
    'context': context,
  };
}

enum ErrorSeverity {

  info,

  warning,

  error,

  critical;

  bool get isRecoverable => this == info || this == warning;
}

class AuthErrorLogger {
  static final AuthErrorLogger _instance = AuthErrorLogger._internal();

  factory AuthErrorLogger() {
    return _instance;
  }

  AuthErrorLogger._internal();

  final List<ErrorLogEntry> _logs = [];

  static const int maxLogsInMemory = 100;

  static AuthErrorLogger get instance => _instance;

  List<ErrorLogEntry> get allLogs => List.unmodifiable(_logs);

  List<ErrorLogEntry> getRecentLogs({int limit = 10}) {
    return _logs.length > limit ? _logs.sublist(_logs.length - limit) : _logs;
  }

  List<ErrorLogEntry> getLogsByErrorCode(String errorCode) {
    return _logs.where((log) => log.errorCode == errorCode).toList();
  }

  List<ErrorLogEntry> getLogsBySeverity(ErrorSeverity severity) {
    return _logs.where((log) => log.severity == severity).toList();
  }

  void logException(
    AuthException exception, {
    String? userId,
    int? httpStatusCode,
    Map<String, dynamic>? context,
  }) {
    final logId = _generateLogId();
    final severity = _determineSeverity(exception);

    final logEntry = ErrorLogEntry(
      logId: logId,
      timestamp: DateTime.now(),
      errorCode: exception.errorCode,
      message: exception.message,
      exceptionDetails: exception.originalError?.toString(),
      stackTrace: exception.stackTrace,
      httpStatusCode: httpStatusCode,
      isRetryable: exception.isRetryable,
      severity: severity,
      userId: userId,
      context: context,
    );

    _addLog(logEntry);
    _printLog(logEntry);

    if (!kDebugMode) {
      _sendToAnalytics(logEntry);
    }
  }

  void logError(
    String errorCode,
    String message, {
    dynamic originalError,
    StackTrace? stackTrace,
    String? userId,
    int? httpStatusCode,
    bool isRetryable = false,
    ErrorSeverity severity = ErrorSeverity.error,
    Map<String, dynamic>? context,
  }) {
    final logId = _generateLogId();

    final logEntry = ErrorLogEntry(
      logId: logId,
      timestamp: DateTime.now(),
      errorCode: errorCode,
      message: message,
      exceptionDetails: originalError?.toString(),
      stackTrace: stackTrace,
      httpStatusCode: httpStatusCode,
      isRetryable: isRetryable,
      severity: severity,
      userId: userId,
      context: context,
    );

    _addLog(logEntry);
    _printLog(logEntry);

    if (!kDebugMode) {
      _sendToAnalytics(logEntry);
    }
  }

  void logInfo(
    String errorCode,
    String message, {
    Map<String, dynamic>? context,
  }) {
    final logId = _generateLogId();

    final logEntry = ErrorLogEntry(
      logId: logId,
      timestamp: DateTime.now(),
      errorCode: errorCode,
      message: message,
      severity: ErrorSeverity.info,
      context: context,
    );

    _addLog(logEntry);
    _printLog(logEntry);
  }

  void clearLogs() {
    _logs.clear();
    debugPrint('🗑️ [AuthErrorLogger] All logs cleared');
  }

  Map<String, dynamic> getErrorStatistics() {
    final totalErrors = _logs.length;
    final errorsByCode = <String, int>{};
    final errorsBySeverity = <String, int>{};
    final retryableErrors = _logs.where((log) => log.isRetryable).length;

    for (final log in _logs) {
      errorsByCode[log.errorCode] = (errorsByCode[log.errorCode] ?? 0) + 1;
      errorsBySeverity[log.severity.name] =
          (errorsBySeverity[log.severity.name] ?? 0) + 1;
    }

    return {
      'totalErrors': totalErrors,
      'retryableErrors': retryableErrors,
      'errorsByCode': errorsByCode,
      'errorsBySeverity': errorsBySeverity,
      'lastError': _logs.isNotEmpty ? _logs.last.toJson() : null,
    };
  }

  void _addLog(ErrorLogEntry entry) {
    _logs.add(entry);

    if (_logs.length > maxLogsInMemory) {
      _logs.removeAt(0);
    }
  }

  ErrorSeverity _determineSeverity(AuthException exception) {
    if (exception is ServerException ||
        exception is TimeoutException ||
        exception is NetworkException) {
      return ErrorSeverity.error;
    }

    if (exception is TokenExpiredException ||
        exception is UnauthorizedException) {
      return ErrorSeverity.warning;
    }

    if (exception is AccountLockedException ||
        exception is InvalidCredentialsException) {
      return ErrorSeverity.warning;
    }

    return ErrorSeverity.error;
  }

  void _printLog(ErrorLogEntry entry) {
    final emoji = switch (entry.severity) {
      ErrorSeverity.info => 'ℹ️',
      ErrorSeverity.warning => '⚠️',
      ErrorSeverity.error => '❌',
      ErrorSeverity.critical => '🔴',
    };

    debugPrint(
      '$emoji [AuthError] ${entry.errorCode}\n'
      '   Message: ${entry.message}\n'
      '   Retryable: ${entry.isRetryable}\n'
      '   LogID: ${entry.logId}',
    );

    if (entry.exceptionDetails != null) {
      debugPrint('   Details: ${entry.exceptionDetails}');
    }

    if (entry.stackTrace != null && kDebugMode) {
      debugPrintStack(stackTrace: entry.stackTrace);
    }
  }

  String _generateLogId() {
    return 'log_${DateTime.now().millisecondsSinceEpoch}_${_logs.length}';
  }

  void _sendToAnalytics(ErrorLogEntry entry) {

  }
}

class ErrorRecoveryStrategy {

  final bool showRetry;

  final bool autoRetry;

  final Duration? autoRetryDelay;

  final int maxRetries;

  final bool redirectToLogin;

  final bool showDetailedError;

  ErrorRecoveryStrategy({
    this.showRetry = false,
    this.autoRetry = false,
    this.autoRetryDelay,
    this.maxRetries = 3,
    this.redirectToLogin = false,
    this.showDetailedError = false,
  });

  factory ErrorRecoveryStrategy.forException(AuthException exception) {
    if (exception is NetworkException) {
      return ErrorRecoveryStrategy(
        showRetry: true,
        autoRetry: true,
        autoRetryDelay: const Duration(seconds: 2),
        maxRetries: 3,
      );
    }

    if (exception is TimeoutException) {
      return ErrorRecoveryStrategy(
        showRetry: true,
        autoRetry: true,
        autoRetryDelay: const Duration(seconds: 3),
        maxRetries: 2,
      );
    }

    if (exception is ServerException) {
      return ErrorRecoveryStrategy(
        showRetry: true,
        autoRetry: false,
        maxRetries: 1,
        showDetailedError: true,
      );
    }

    if (exception is TokenExpiredException) {
      return ErrorRecoveryStrategy(
        redirectToLogin: true,
        showDetailedError: false,
      );
    }

    if (exception is UnauthorizedException) {
      return ErrorRecoveryStrategy(
        redirectToLogin: true,
        showDetailedError: false,
      );
    }

    if (exception is InvalidCredentialsException) {
      return ErrorRecoveryStrategy(
        showRetry: false,
        showDetailedError: true,
      );
    }

    if (exception is InvalidOtpException) {
      return ErrorRecoveryStrategy(
        showRetry: true,
        showDetailedError: true,
      );
    }

    if (exception is OtpExpiredException) {
      return ErrorRecoveryStrategy(
        showRetry: true,
        showDetailedError: true,
      );
    }

    if (exception is AccountLockedException) {
      return ErrorRecoveryStrategy(
        showRetry: false,
        redirectToLogin: false,
        showDetailedError: true,
      );
    }

    return ErrorRecoveryStrategy(
      showRetry: exception.isRetryable,
      showDetailedError: false,
    );
  }
}
