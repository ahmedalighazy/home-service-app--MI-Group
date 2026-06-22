import '../error/auth_exceptions.dart';
import '../utils/auth_error_logger.dart';

class AuthErrorInterceptor {
  static final AuthErrorInterceptor _instance = AuthErrorInterceptor._internal();

  factory AuthErrorInterceptor() {
    return _instance;
  }

  AuthErrorInterceptor._internal();

  final List<ErrorInterceptorHandler> _handlers = [];

  void registerHandler(ErrorInterceptorHandler handler) {
    _handlers.add(handler);
  }

  void removeHandler(ErrorInterceptorHandler handler) {
    _handlers.remove(handler);
  }

  Future<void> intercept(
    AuthException exception, {
    String? userId,
    Map<String, dynamic>? context,
  }) async {

    AuthErrorLogger().logException(
      exception,
      userId: userId,
      context: context,
    );

    for (final handler in _handlers) {
      final shouldContinue = await handler.handle(exception);
      if (!shouldContinue) break;
    }
  }

  void clearHandlers() {
    _handlers.clear();
  }

  int get handlerCount => _handlers.length;
}

abstract class ErrorInterceptorHandler {

  Future<bool> handle(AuthException exception);
}

class NetworkErrorHandler extends ErrorInterceptorHandler {
  final void Function()? onNetworkError;

  NetworkErrorHandler({this.onNetworkError});

  @override
  Future<bool> handle(AuthException exception) async {
    if (exception is NetworkException || exception is TimeoutException) {
      onNetworkError?.call();
      return false;
    }
    return true;
  }
}

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

class ErrorRecoveryExecutor {
  static final ErrorRecoveryExecutor _instance = ErrorRecoveryExecutor._internal();

  factory ErrorRecoveryExecutor() {
    return _instance;
  }

  ErrorRecoveryExecutor._internal();

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

class ErrorContext {
  final List<AuthException> errors = [];
  AuthException? lastError;
  int totalErrorCount = 0;
  DateTime? firstErrorTime;
  DateTime? lastErrorTime;

  void recordError(AuthException exception) {
    errors.add(exception);
    lastError = exception;
    totalErrorCount++;
    lastErrorTime = DateTime.now();
    firstErrorTime ??= DateTime.now();
  }

  bool hasTooManyErrors({int threshold = 5}) {
    return totalErrorCount >= threshold;
  }

  double getErrorFrequency() {
    if (errors.isEmpty || firstErrorTime == null || lastErrorTime == null) {
      return 0.0;
    }
    final duration = lastErrorTime!.difference(firstErrorTime!).inSeconds;
    if (duration == 0) return 0.0;
    return errors.length / duration;
  }

  bool shouldBreakCircuit({
    int errorThreshold = 5,
    Duration timeWindow = const Duration(minutes: 1),
  }) {
    if (lastErrorTime == null) return false;

    final recentErrors = errors.where((error) {
      return true;
    }).length;

    return recentErrors >= errorThreshold;
  }

  void clear() {
    errors.clear();
    lastError = null;
    totalErrorCount = 0;
    firstErrorTime = null;
    lastErrorTime = null;
  }

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

class ErrorCircuitBreaker {
  static final ErrorCircuitBreaker _instance = ErrorCircuitBreaker._internal();

  factory ErrorCircuitBreaker() {
    return _instance;
  }

  ErrorCircuitBreaker._internal();

  final Map<String, CircuitBreakerState> _states = {};

  bool canExecute(String operationKey) {
    final state = _states[operationKey] ?? CircuitBreakerState.closed;
    return state != CircuitBreakerState.open;
  }

  void recordSuccess(String operationKey) {
    _states[operationKey] = CircuitBreakerState.closed;
  }

  void recordFailure(String operationKey, {int failureThreshold = 5}) {
    final current = _states[operationKey] ?? CircuitBreakerState.closed;

    if (current == CircuitBreakerState.closed) {
      _states[operationKey] = CircuitBreakerState.open;
    } else if (current == CircuitBreakerState.open) {
      _states[operationKey] = CircuitBreakerState.halfOpen;
    }
  }

  void reset(String operationKey) {
    _states.remove(operationKey);
  }

  CircuitBreakerState getState(String operationKey) {
    return _states[operationKey] ?? CircuitBreakerState.closed;
  }

  void clearAll() {
    _states.clear();
  }

  Map<String, String> getAllStates() {
    return _states.map((key, state) => MapEntry(key, state.name));
  }
}

enum CircuitBreakerState {

  closed,

  open,

  halfOpen;

  bool get isBroken => this == open;

  bool get isTesting => this == halfOpen;
}

class ErrorAggregator {
  final Map<String, List<AuthException>> _errorGroups = {};

  void addError(String groupKey, AuthException exception) {
    _errorGroups.putIfAbsent(groupKey, () => []).add(exception);
  }

  List<AuthException> getErrors(String groupKey) {
    return _errorGroups[groupKey] ?? [];
  }

  List<AuthException> getAllErrors() {
    final allErrors = <AuthException>[];
    _errorGroups.values.forEach(allErrors.addAll);
    return allErrors;
  }

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

  void clear() {
    _errorGroups.clear();
  }

  Map<String, dynamic> getSummary() {
    return {
      'groupCount': _errorGroups.length,
      'totalErrors': getAllErrors().length,
      'mostCommonError': getMostCommonError()?.errorCode,
    };
  }
}
