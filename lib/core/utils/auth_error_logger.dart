/// Auth Error Logger - Centralized Error Logging & Analytics
/// 
/// Logs all auth errors with context for debugging and monitoring
/// Tracks error patterns and provides analytics insights

import 'package:flutter/foundation.dart';
import '../error/auth_exceptions.dart';

// ════════════════════════════════════════════════════════════════
// Error Log Entry
// ════════════════════════════════════════════════════════════════

/// Single error log entry with context
class ErrorLogEntry {
  /// Unique log ID for tracking
  final String logId;
  
  /// Timestamp of error
  final DateTime timestamp;
  
  /// Error code
  final String errorCode;
  
  /// User-facing message
  final String message;
  
  /// Original exception details
  final String? exceptionDetails;
  
  /// Stack trace
  final StackTrace? stackTrace;
  
  /// HTTP status code if applicable
  final int? httpStatusCode;
  
  /// Whether error is retryable
  final bool isRetryable;
  
  /// Severity level
  final ErrorSeverity severity;
  
  /// User ID if available
  final String? userId;
  
  /// Additional context data
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

  /// Convert to JSON for storage/transmission
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

// ════════════════════════════════════════════════════════════════
// Error Severity Levels
// ════════════════════════════════════════════════════════════════

enum ErrorSeverity {
  /// Minor issue, app continues normally
  info,
  
  /// Warning, potential issue but recoverable
  warning,
  
  /// Error occurred but can be handled
  error,
  
  /// Critical error, significant impact
  critical;

  bool get isRecoverable => this == info || this == warning;
}

// ════════════════════════════════════════════════════════════════
// Auth Error Logger
// ════════════════════════════════════════════════════════════════

/// Centralized error logger for auth feature
class AuthErrorLogger {
  static final AuthErrorLogger _instance = AuthErrorLogger._internal();
  
  factory AuthErrorLogger() {
    return _instance;
  }

  AuthErrorLogger._internal();

  /// All logged errors
  final List<ErrorLogEntry> _logs = [];
  
  /// Max logs to keep in memory
  static const int maxLogsInMemory = 100;

  /// Get singleton instance
  static AuthErrorLogger get instance => _instance;

  /// Get all logs
  List<ErrorLogEntry> get allLogs => List.unmodifiable(_logs);

  /// Get recent logs
  List<ErrorLogEntry> getRecentLogs({int limit = 10}) {
    return _logs.length > limit ? _logs.sublist(_logs.length - limit) : _logs;
  }

  /// Get logs by error code
  List<ErrorLogEntry> getLogsByErrorCode(String errorCode) {
    return _logs.where((log) => log.errorCode == errorCode).toList();
  }

  /// Get logs by severity
  List<ErrorLogEntry> getLogsBySeverity(ErrorSeverity severity) {
    return _logs.where((log) => log.severity == severity).toList();
  }

  /// Log auth exception
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
    
    // In production, send to analytics/monitoring service
    if (!kDebugMode) {
      _sendToAnalytics(logEntry);
    }
  }

  /// Log generic error
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

  /// Log info message
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

  /// Clear all logs
  void clearLogs() {
    _logs.clear();
    debugPrint('🗑️ [AuthErrorLogger] All logs cleared');
  }

  /// Get error statistics
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

  // ══════════════════════════════════════════════════════════════
  // Private Methods
  // ══════════════════════════════════════════════════════════════

  void _addLog(ErrorLogEntry entry) {
    _logs.add(entry);
    
    // Keep max logs
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
    // TODO: Implement analytics/monitoring integration
    // Example: Send to Sentry, Firebase Crashlytics, etc.
    // FirebaseCrashlytics.instance.recordError(
    //   Exception(entry.errorCode),
    //   entry.stackTrace,
    // );
  }
}

// ════════════════════════════════════════════════════════════════
// Error Recovery Strategies
// ════════════════════════════════════════════════════════════════

/// Determines action to take based on exception type
class ErrorRecoveryStrategy {
  /// Whether to show retry button to user
  final bool showRetry;
  
  /// Whether to automatically retry
  final bool autoRetry;
  
  /// Delay before auto-retry
  final Duration? autoRetryDelay;
  
  /// Maximum retry attempts
  final int maxRetries;
  
  /// Whether to redirect to login
  final bool redirectToLogin;
  
  /// Whether to show detailed error to user
  final bool showDetailedError;

  ErrorRecoveryStrategy({
    this.showRetry = false,
    this.autoRetry = false,
    this.autoRetryDelay,
    this.maxRetries = 3,
    this.redirectToLogin = false,
    this.showDetailedError = false,
  });

  /// Get strategy for exception
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
