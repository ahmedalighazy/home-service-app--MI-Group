
import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../error/auth_exceptions.dart';

// ════════════════════════════════════════════════════════════════
// Retry Configuration
// ════════════════════════════════════════════════════════════════

/// Configuration for retry behavior
class RetryConfig {
  /// Maximum number of retry attempts
  final int maxRetries;
  
  /// Initial delay between retries
  final Duration initialDelay;
  
  /// Maximum delay between retries (caps exponential backoff)
  final Duration maxDelay;
  
  /// Multiplier for exponential backoff
  final double backoffMultiplier;
  
  /// Random jitter to add (0.0 to 1.0)
  final double jitter;
  
  /// Exceptions that should trigger retry
  final List<Type> retryableExceptions;
  
  /// HTTP status codes that should trigger retry
  final List<int> retryableStatusCodes;

  const RetryConfig({
    this.maxRetries = 3,
    this.initialDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 30),
    this.backoffMultiplier = 2.0,
    this.jitter = 0.1,
    this.retryableExceptions = const [
      NetworkException,
      TimeoutException,
      ServerException,
      SmsSendingException,
      LocalStorageReadException,
      LocalStorageWriteException,
    ],
    this.retryableStatusCodes = const [408, 429, 500, 502, 503, 504],
  });

  /// Aggressive retry for critical operations
  static const aggressive = RetryConfig(
    maxRetries: 5,
    initialDelay: Duration(milliseconds: 200),
    maxDelay: Duration(seconds: 60),
    backoffMultiplier: 1.5,
  );

  /// Conservative retry for less critical operations
  static const conservative = RetryConfig(
    maxRetries: 2,
    initialDelay: Duration(milliseconds: 1000),
    maxDelay: Duration(seconds: 10),
    backoffMultiplier: 2.0,
  );

  /// No retry - fail immediately
  static const noRetry = RetryConfig(maxRetries: 0);
}

// ════════════════════════════════════════════════════════════════
// Retry Result
// ════════════════════════════════════════════════════════════════

/// Result of retry operation
class RetryResult<T> {
  /// Success result
  final T? result;
  
  /// Final exception if failed
  final AuthException? exception;
  
  /// Number of attempts made
  final int attempts;
  
  /// Total time spent retrying
  final Duration totalTime;
  
  /// Whether succeeded
  final bool isSuccess;

  RetryResult({
    required this.result,
    required this.exception,
    required this.attempts,
    required this.totalTime,
    required this.isSuccess,
  });

  /// Check if successful
  bool get succeeded => isSuccess;

  /// Check if failed
  bool get failed => !isSuccess;

  @override
  String toString() => '''
RetryResult {
  isSuccess: $isSuccess
  attempts: $attempts
  totalTime: $totalTime
  exception: ${exception?.errorCode}
}''';
}

// ════════════════════════════════════════════════════════════════
// Retry Policy
// ════════════════════════════════════════════════════════════════

/// Implements retry logic with exponential backoff
class AuthRetryPolicy {
  final RetryConfig config;

  AuthRetryPolicy({RetryConfig? config}) 
      : config = config ?? const RetryConfig();

  /// Execute operation with retries
  Future<RetryResult<T>> execute<T>(
    Future<T> Function() operation, {
    String? operationName,
  }) async {
    final stopwatch = Stopwatch()..start();
    int attempts = 0;
    AuthException? lastException;

    while (attempts < config.maxRetries + 1) {
      attempts++;

      try {
        _logRetryAttempt(
          operationName: operationName,
          attempt: attempts,
          maxRetries: config.maxRetries,
        );

        final result = await operation();
        
        _logRetrySuccess(
          operationName: operationName,
          attempts: attempts,
          totalTime: stopwatch.elapsed,
        );

        return RetryResult(
          result: result,
          exception: null,
          attempts: attempts,
          totalTime: stopwatch.elapsed,
          isSuccess: true,
        );
      } catch (error, stackTrace) {
        lastException = _handleException(
          error,
          stackTrace: stackTrace,
        );

        // Check if retryable
        if (!_isRetryable(lastException)) {
          _logRetryFailed(
            operationName: operationName,
            attempts: attempts,
            exception: lastException,
            retryable: false,
          );

          return RetryResult(
            result: null,
            exception: lastException,
            attempts: attempts,
            totalTime: stopwatch.elapsed,
            isSuccess: false,
          );
        }

        // Check if max retries reached
        if (attempts >= config.maxRetries + 1) {
          _logRetryFailed(
            operationName: operationName,
            attempts: attempts,
            exception: lastException,
            retryable: true,
          );

          return RetryResult(
            result: null,
            exception: lastException,
            attempts: attempts,
            totalTime: stopwatch.elapsed,
            isSuccess: false,
          );
        }

        // Calculate delay
        final delay = _calculateDelay(attempts);
        _logRetryDelay(
          operationName: operationName,
          delay: delay,
          attempt: attempts,
        );

        // Wait before retry
        await Future.delayed(delay);
      }
    }

    // Should not reach here, but just in case
    return RetryResult(
      result: null,
      exception: lastException ?? UnknownAuthException(),
      attempts: attempts,
      totalTime: stopwatch.elapsed,
      isSuccess: false,
    );
  }

  /// Execute with stream response
  Stream<T> executeStream<T>(
    Stream<T> Function() operation, {
    String? operationName,
  }) async* {
    int attempts = 0;
    AuthException? lastException;

    while (attempts < config.maxRetries + 1) {
      attempts++;

      try {
        _logRetryAttempt(
          operationName: operationName,
          attempt: attempts,
          maxRetries: config.maxRetries,
        );

        yield* operation();
        return;
      } catch (error, stackTrace) {
        lastException = _handleException(error, stackTrace: stackTrace);

        if (!_isRetryable(lastException) || 
            attempts >= config.maxRetries + 1) {
          throw lastException;
        }

        final delay = _calculateDelay(attempts);
        await Future.delayed(delay);
      }
    }
  }

  // ══════════════════════════════════════════════════════════════
  // Private Methods
  // ══════════════════════════════════════════════════════════════

  bool _isRetryable(AuthException exception) {
    // Check if exception type is retryable
    if (config.retryableExceptions.contains(exception.runtimeType)) {
      return true;
    }

    // Check if exception has retry flag
    if (exception.isRetryable) {
      return true;
    }

    return false;
  }

  AuthException _handleException(dynamic error, {StackTrace? stackTrace}) {
    if (error is AuthException) {
      return error;
    }

    return AuthExceptionFactory.fromException(
      error,
      stackTrace: stackTrace,
    );
  }

  Duration _calculateDelay(int attemptNumber) {
    // Calculate exponential backoff: initialDelay * (multiplier ^ (attempt - 1))
    final exponentialDelay = config.initialDelay * 
        pow(config.backoffMultiplier, attemptNumber - 1) as double;

    // Cap at max delay
    final cappedDelay = Duration(
      milliseconds: exponentialDelay
          .toInt()
          .clamp(0, config.maxDelay.inMilliseconds),
    );

    // Add jitter
    final jitterMs = (cappedDelay.inMilliseconds * config.jitter).toInt();
    final randomJitter = (jitterMs * (0.5 + _random.nextDouble())).toInt();

    return cappedDelay + Duration(milliseconds: randomJitter);
  }

  static final _random = Random();

  void _logRetryAttempt({
    required String? operationName,
    required int attempt,
    required int maxRetries,
  }) {
    debugPrint(
      '🔄 [AuthRetry] Attempt $attempt/$maxRetries'
      '${operationName != null ? ' ($operationName)' : ''}',
    );
  }

  void _logRetryDelay({
    required String? operationName,
    required Duration delay,
    required int attempt,
  }) {
    debugPrint(
      '⏳ [AuthRetry] Waiting ${delay.inMilliseconds}ms before retry'
      '${operationName != null ? ' ($operationName)' : ''}',
    );
  }

  void _logRetrySuccess({
    required String? operationName,
    required int attempts,
    required Duration totalTime,
  }) {
    if (attempts > 1) {
      debugPrint(
        '✅ [AuthRetry] Success after $attempts attempts '
        '(${totalTime.inMilliseconds}ms)'
        '${operationName != null ? ' ($operationName)' : ''}',
      );
    }
  }

  void _logRetryFailed({
    required String? operationName,
    required int attempts,
    required AuthException exception,
    required bool retryable,
  }) {
    debugPrint(
      '❌ [AuthRetry] Failed after $attempts attempts'
      '${operationName != null ? ' ($operationName)' : ''}\n'
      '   Error: ${exception.errorCode}\n'
      '   Retryable: $retryable',
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Global Retry Policies
// ════════════════════════════════════════════════════════════════

/// Global retry policies for different scenarios
class AuthRetryPolicies {
  /// Login operations - moderate retry
  static final login = AuthRetryPolicy(
    config: const RetryConfig(
      maxRetries: 2,
      initialDelay: Duration(milliseconds: 500),
      maxDelay: Duration(seconds: 10),
    ),
  );

  /// OTP operations - aggressive retry
  static final otp = AuthRetryPolicy(
    config: RetryConfig.aggressive,
  );

  /// Token operations - conservative retry
  static final token = AuthRetryPolicy(
    config: const RetryConfig(
      maxRetries: 1,
      initialDelay: Duration(milliseconds: 300),
    ),
  );

  /// Network operations - aggressive retry
  static final network = AuthRetryPolicy(
    config: RetryConfig.aggressive,
  );

  /// SMS operations - moderate retry
  static final sms = AuthRetryPolicy(
    config: const RetryConfig(
      maxRetries: 3,
      initialDelay: Duration(milliseconds: 1000),
      maxDelay: Duration(seconds: 20),
    ),
  );

  /// Local storage operations - conservative, quick fail
  static final storage = AuthRetryPolicy(
    config: const RetryConfig(
      maxRetries: 1,
      initialDelay: Duration(milliseconds: 100),
    ),
  );
}

// Math helper for pow function
double pow(double base, double exponent) {
  return base * (exponent - 1 <= 0 ? 1 : pow(base, exponent - 1));
}
