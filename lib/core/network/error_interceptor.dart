/// Error Interceptor - Global Error Management Layer
/// 
/// Handles errors across the application with consistent patterns

import '../error/auth_exceptions.dart';
import '../utils/auth_error_logger.dart';

/// Global error interceptor for auth operations
class AuthErrorInterceptor {
  static final AuthErrorInterceptor _instance = AuthErrorInterceptor._internal();

  factory AuthErrorInterceptor() {
    return _instance;
  }

  AuthErrorInterceptor._internal();

  final List<ErrorInterceptorHandler> _handlers = [];

  /// Register error handler
  void registerHandler(ErrorInterceptorHandler handler) {
    _handlers.add(handler);
  }

  /// Remove error handler
  void removeHandler(ErrorInterceptorHandler handler) {
    _handlers.remove(handler);
  }

  /// Intercept and process error
  Future<void> intercept(
    AuthException exception, {
    String? userId,
    Map<String, dynamic>? context,
  }) async {
    // Log error
    AuthErrorLogger().logException(
      exception,
      userId: userId,
      context: context,
    );

    // Notify all handlers
    for (final handler in _handlers) {
      final shouldContinue = await handler.handle(exception);
      if (!shouldContinue) break;
    }
  }

  /// Clear all handlers
  void clearHandlers() {
    _handlers.clear();
  }

  /// Get number of registered handlers
  int get handlerCount => _handlers.length;
}

/// Abstract error handler
abstract class ErrorInterceptorHandler {
  /// Handle error
  /// Returns true to continue processing, false to stop
  Future<bool> handle(AuthException exception);
}

/// Error handler implementations
class NetworkErrorHandler extends ErrorInterceptorHandler {
  final void Function()? onNetworkError;

  NetworkErrorHandler({this.onNetworkError});

  @override
  Future<bool> handle(AuthException exception) async {
    if (exception is NetworkException || exception is TimeoutException) {
      onNetworkError?.call();
      return false; // Stop processing
    }
    return true; // Continue
  }
}

/// Authentication error handler
class AuthenticationErrorHandler extends ErrorInterceptorHandler {
  final void Function()? onUnauthorized;
  final void Function()? onTokenExpired;

  AuthenticationErrorHandler({
    this.onUnauthorized,
    this.onTokenExpired,
  });

  @override
  Future<bool> handle(AuthException exception) async {
    if (exception is TokenExpiredException) {
      onTokenExpired?.call();
      return false;
    }

    if (exception is UnauthorizedException) {
      onUnauthorized?.call();
      return false;
    }

    return true;
  }
}

/// Validation error handler
class ValidationErrorHandler extends ErrorInterceptorHandler {
  final void Function(ValidationException)? onValidationError;

  ValidationErrorHandler({this.onValidationError});

  @override
  Future<bool> handle(AuthException exception) async {
    if (exception is ValidationException) {
      onValidationError?.call(exception);
      return false;
    }
    return true;
  }
}

/// Account state error handler
class AccountStateErrorHandler extends ErrorInterceptorHandler {
  final void Function()? onAccountLocked;
  final void Function()? onAccountNotFound;

  AccountStateErrorHandler({
    this.onAccountLocked,
    this.onAccountNotFound,
  });

  @override
  Future<bool> handle(AuthException exception) async {
    if (exception is AccountLockedException) {
      onAccountLocked?.call();
      return false;
    }

    if (exception is AccountNotFoundException) {
      onAccountNotFound?.call();
      return false;
    }

    return true;
  }
}

/// Error recovery executor
class ErrorRecoveryExecutor {
  static final ErrorRecoveryExecutor _instance = ErrorRecoveryExecutor._internal();

  factory ErrorRecoveryExecutor() {
    return _instance;
  }

  ErrorRecoveryExecutor._internal();

  /// Execute recovery strategy
  Future<void> executeRecovery(
    AuthException exception, {
    required void Function() onRetry,
    required void Function() onNavigateToLogin,
    required void Function(String) onShowError,
  }) async {
    final strategy = ErrorRecoveryStrategy.forException(exception);

    if (strategy.autoRetry && strategy.autoRetryDelay != null) {
      await Future.delayed(strategy.autoRetryDelay!);
      onRetry();
    } else if (strategy.redirectToLogin) {
      onNavigateToLogin();
    } else if (strategy.showRetry) {
      onShowError(exception.message);
    } else {
      onShowError(exception.message);
    }
  }
}

/// Error context - tracks error state during operations
class ErrorContext {
  final List<AuthException> errors = [];
  AuthException? lastError;
  int totalErrorCount = 0;
  DateTime? firstErrorTime;
  DateTime? lastErrorTime;

  /// Record error
  void recordError(AuthException exception) {
    errors.add(exception);
    lastError = exception;
    totalErrorCount++;
    lastErrorTime = DateTime.now();
    firstErrorTime ??= DateTime.now();
  }

  /// Check if too many errors
  bool hasTooManyErrors({int threshold = 5}) {
    return totalErrorCount >= threshold;
  }

  /// Get error frequency
  double getErrorFrequency() {
    if (errors.isEmpty || firstErrorTime == null || lastErrorTime == null) {
      return 0.0;
    }
    final duration = lastErrorTime!.difference(firstErrorTime!).inSeconds;
    if (duration == 0) return 0.0;
    return errors.length / duration;
  }

  /// Check if circuit should be broken
  bool shouldBreakCircuit({
    int errorThreshold = 5,
    Duration timeWindow = const Duration(minutes: 1),
  }) {
    if (lastErrorTime == null) return false;

    final recentErrors = errors.where((error) {
      return true; // In real implementation, check timestamp
    }).length;

    return recentErrors >= errorThreshold;
  }

  /// Clear errors
  void clear() {
    errors.clear();
    lastError = null;
    totalErrorCount = 0;
    firstErrorTime = null;
    lastErrorTime = null;
  }

  /// Get error summary
  Map<String, dynamic> getSummary() {
    return {
      'totalErrors': totalErrorCount,
      'uniqueErrors': errors.map((e) => e.errorCode).toSet().length,
      'lastError': lastError?.errorCode,
      'errorFrequency': getErrorFrequency(),
      'timeWindow': lastErrorTime?.difference(firstErrorTime ?? DateTime.now()).inSeconds ?? 0,
    };
  }
}

/// Error circuit breaker - prevents cascading failures
class ErrorCircuitBreaker {
  static final ErrorCircuitBreaker _instance = ErrorCircuitBreaker._internal();

  factory ErrorCircuitBreaker() {
    return _instance;
  }

  ErrorCircuitBreaker._internal();

  final Map<String, CircuitBreakerState> _states = {};

  /// Check if operation should be allowed
  bool canExecute(String operationKey) {
    final state = _states[operationKey] ?? CircuitBreakerState.closed;
    return state != CircuitBreakerState.open;
  }

  /// Record success
  void recordSuccess(String operationKey) {
    _states[operationKey] = CircuitBreakerState.closed;
  }

  /// Record failure
  void recordFailure(String operationKey, {int failureThreshold = 5}) {
    final current = _states[operationKey] ?? CircuitBreakerState.closed;

    if (current == CircuitBreakerState.closed) {
      _states[operationKey] = CircuitBreakerState.open;
    } else if (current == CircuitBreakerState.open) {
      _states[operationKey] = CircuitBreakerState.halfOpen;
    }
  }

  /// Reset circuit breaker
  void reset(String operationKey) {
    _states.remove(operationKey);
  }

  /// Get state
  CircuitBreakerState getState(String operationKey) {
    return _states[operationKey] ?? CircuitBreakerState.closed;
  }

  /// Clear all states
  void clearAll() {
    _states.clear();
  }

  /// Get all states summary
  Map<String, String> getAllStates() {
    return _states.map((key, state) => MapEntry(key, state.name));
  }
}

/// Circuit breaker states
enum CircuitBreakerState {
  /// Normal operation
  closed,

  /// Blocking requests temporarily
  open,

  /// Testing if service recovered
  halfOpen;

  /// Check if circuit is broken
  bool get isBroken => this == open;

  /// Check if testing
  bool get isTesting => this == halfOpen;
}

/// Error aggregator - collects related errors
class ErrorAggregator {
  final Map<String, List<AuthException>> _errorGroups = {};

  /// Add error to group
  void addError(String groupKey, AuthException exception) {
    _errorGroups.putIfAbsent(groupKey, () => []).add(exception);
  }

  /// Get errors by group
  List<AuthException> getErrors(String groupKey) {
    return _errorGroups[groupKey] ?? [];
  }

  /// Get all errors
  List<AuthException> getAllErrors() {
    final allErrors = <AuthException>[];
    _errorGroups.values.forEach(allErrors.addAll);
    return allErrors;
  }

  /// Get most common error
  AuthException? getMostCommonError() {
    if (_errorGroups.isEmpty) return null;

    final allErrors = getAllErrors();
    if (allErrors.isEmpty) return null;

    final errorCounts = <String, int>{};
    for (final error in allErrors) {
      errorCounts[error.errorCode] = (errorCounts[error.errorCode] ?? 0) + 1;
    }

    final mostCommonCode = errorCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    return allErrors.firstWhere((e) => e.errorCode == mostCommonCode);
  }

  /// Clear aggregated errors
  void clear() {
    _errorGroups.clear();
  }

  /// Get summary
  Map<String, dynamic> getSummary() {
    return {
      'groupCount': _errorGroups.length,
      'totalErrors': getAllErrors().length,
      'mostCommonError': getMostCommonError()?.errorCode,
    };
  }
}
