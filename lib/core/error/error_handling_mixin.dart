import 'auth_exceptions.dart';
import '../utils/auth_error_logger.dart';

mixin ErrorHandlingMixin {
  Future<T?> executeWithErrorHandling<T>({
    required Future<T> Function() operation,
    required void Function(AuthException) onError,
    bool logError = true,
    String? userId,
    Map<String, dynamic>? context,
  }) async {
    try {
      return await operation();
    } on AuthException catch (e) {
      _handleAuthException(
        e,
        onError: onError,
        logError: logError,
        userId: userId,
        context: context,
      );
      return null;
    } catch (e, stackTrace) {
      final authException = AuthExceptionFactory.fromException(
        e,
        stackTrace: stackTrace,
      );
      _handleAuthException(
        authException,
        onError: onError,
        logError: logError,
        userId: userId,
        context: context,
      );
      return null;
    }
  }

  Map<String, String> validateAndCollectErrors({
    required Map<String, String?> validationResults,
  }) {
    final errors = <String, String>{};
    validationResults.forEach((key, value) {
      if (value != null) {
        errors[key] = value;
      }
    });
    return errors;
  }

  Future<T> retryWithBackoff<T>({
    required Future<T> Function() operation,
    int maxRetries = 3,
    Duration initialDelay = const Duration(milliseconds: 100),
    double backoffMultiplier = 2.0,
    String? operationName,
  }) async {
    int attempt = 0;
    Duration delay = initialDelay;

    while (true) {
      try {
        return await operation();
      } on AuthException catch (e) {
        attempt++;

        if (!e.isRetryable || attempt >= maxRetries) {
          AuthErrorLogger().logError(
            'RETRY_FAILED_${e.errorCode}',
            'Retry exhausted for operation: $operationName after $attempt attempts',
            originalError: e,
            context: {'maxRetries': maxRetries, 'operationName': operationName},
          );
          rethrow;
        }

        AuthErrorLogger().logInfo(
          'RETRY_ATTEMPT',
          'Retrying $operationName (attempt $attempt/$maxRetries) '
              'after ${delay.inMilliseconds}ms',
          context: {
            'attempt': attempt,
            'maxRetries': maxRetries,
            'delayMs': delay.inMilliseconds,
          },
        );

        await Future.delayed(delay);
        delay *= backoffMultiplier;
      }
    }
  }

  Future<void> chainOperations(
    List<Future<void> Function()> operations, {
    required void Function(AuthException) onError,
    bool stopOnError = true,
  }) async {
    for (int i = 0; i < operations.length; i++) {
      try {
        await operations[i]();
      } on AuthException catch (e) {
        onError(e);
        if (stopOnError) break;
      } catch (e, stackTrace) {
        final authException = AuthExceptionFactory.fromException(
          e,
          stackTrace: stackTrace,
        );
        onError(authException);
        if (stopOnError) break;
      }
    }
  }

  void handleErrorWithRecovery(
    AuthException exception, {
    required void Function() onRetry,
    required void Function() onRedirectToLogin,
    required void Function(String message) onShowError,
  }) {
    final strategy = ErrorRecoveryStrategy.forException(exception);

    AuthErrorLogger().logException(
      exception,
      context: {'recoveryStrategy': strategy.toString()},
    );

    if (strategy.redirectToLogin) {
      onRedirectToLogin();
    } else if (strategy.showRetry) {
      onShowError(exception.message);
      onRetry();
    } else {
      onShowError(exception.message);
    }
  }

  void _handleAuthException(
    AuthException exception, {
    required void Function(AuthException) onError,
    bool logError = true,
    String? userId,
    Map<String, dynamic>? context,
  }) {
    if (logError) {
      AuthErrorLogger().logException(
        exception,
        userId: userId,
        context: context,
      );
    }
    onError(exception);
  }
}

mixin CubitErrorHandling<T> {
  Future<void> safeExecute(
    Future<void> Function() operation, {
    required void Function(String errorMessage) onError,
    String? userId,
    Map<String, dynamic>? context,
  }) async {
    try {
      await operation();
    } on AuthException catch (e) {
      AuthErrorLogger().logException(e, userId: userId, context: context);
      onError(e.message);
    } catch (e, stackTrace) {
      final authException = AuthExceptionFactory.fromException(
        e,
        stackTrace: stackTrace,
      );
      AuthErrorLogger().logException(
        authException,
        userId: userId,
        context: context,
      );
      onError(authException.message);
    }
  }
}

class ErrorHandledResult<T> {
  final T? data;
  final AuthException? error;
  final bool isSuccess;

  ErrorHandledResult({this.data, this.error}) : isSuccess = error == null;

  bool get isError => !isSuccess;

  T getOrThrow() {
    if (isSuccess && data != null) {
      return data!;
    }
    throw error ?? UnknownAuthException(message: 'Unknown error occurred');
  }

  ErrorHandledResult<U> map<U>(U Function(T) mapper) {
    if (isSuccess && data != null) {
      try {
        return ErrorHandledResult(data: mapper(data as T));
      } catch (e, stackTrace) {
        final authException = AuthExceptionFactory.fromException(
          e,
          stackTrace: stackTrace,
        );
        return ErrorHandledResult(error: authException);
      }
    }
    return ErrorHandledResult(error: error);
  }

  R fold<R>(R Function(AuthException) onError, R Function(T) onSuccess) {
    if (isSuccess && data != null) {
      return onSuccess(data as T);
    }
    return onError(error ?? UnknownAuthException());
  }

  @override
  String toString() => isSuccess
      ? 'Success: $data'
      : 'Error: ${error?.errorCode} - ${error?.message}';
}

extension AuthExceptionExtension on AuthException {
  bool get isNetworkError =>
      this is NetworkException || this is TimeoutException;

  bool get isAuthError =>
      this is InvalidCredentialsException ||
      this is UnauthorizedException ||
      this is TokenExpiredException;

  bool get isValidationError => this is ValidationException;

  String getUserMessage() {
    return message;
  }

  String getTechnicalDetails() {
    return '''
Error Code: $errorCode
Message: $message
Retryable: $isRetryable
Original Error: $originalError
Stack Trace: $stackTrace
''';
  }
}

extension ResultExtension<T> on Future<T> {
  Future<ErrorHandledResult<T>> toErrorHandledResult() async {
    try {
      final result = await this;
      return ErrorHandledResult(data: result);
    } on AuthException catch (e) {
      return ErrorHandledResult(error: e);
    } catch (e, stackTrace) {
      final authException = AuthExceptionFactory.fromException(
        e,
        stackTrace: stackTrace,
      );
      return ErrorHandledResult(error: authException);
    }
  }
}
