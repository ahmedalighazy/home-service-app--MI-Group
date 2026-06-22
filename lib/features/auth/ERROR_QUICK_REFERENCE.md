# Error Handling - Quick Reference Card

## 🎯 Exception Types at a Glance

```dart
// Network Errors
NetworkException              // No internet (retryable)
TimeoutException             // Request timeout (retryable)

// Server Errors
ServerException              // 5xx errors (retryable)
BadRequestException          // 400 error (not retryable)

// Authentication
InvalidCredentialsException  // Wrong email/password
AccountNotFoundException     // Email not registered
AccountLockedException      // Too many attempts (retryable with delay)
TokenExpiredException       // Session ended
UnauthorizedException       // Unauthorized

// OTP/SMS
InvalidOtpException         // Wrong OTP (retryable)
OtpExpiredException         // OTP expired
SmsSendingException         // SMS send failed (retryable)

// Validation
ValidationException         // Input validation failed
EmailAlreadyExistsException // Duplicate email
PhoneAlreadyRegisteredException // Duplicate phone

// Storage
LocalStorageReadException   // Read failed (retryable)
LocalStorageWriteException  // Write failed (retryable)
CorruptedDataException      // JSON corrupted (retryable)

// Generic
UnknownAuthException        // Unknown error
```

---

## 📋 Error States Quick Map

```dart
// Network/Server Errors
NetworkErrorState           // No internet
TimeoutErrorState           // Request timeout
ServerErrorState            // 5xx errors
BadRequestErrorState        // 400 error

// Authentication
InvalidCredentialsErrorState     // Wrong creds + attempt tracking
AccountNotFoundErrorState        // Email not found
AccountLockedErrorState          // Locked + time remaining
TokenExpiredErrorState           // Session expired
UnauthorizedErrorState           // Unauthorized

// OTP
InvalidOtpErrorState             // Wrong OTP + attempts remaining
OtpExpiredErrorState             // OTP expired
SmsSendingErrorState             // SMS send failed

// Validation
ValidationErrorState             // Input validation failed
EmailAlreadyExistsErrorState     // Duplicate email
PhoneAlreadyRegisteredErrorState // Duplicate phone

// Storage
LocalStorageErrorState           // Storage operation failed

// Generic
UnknownErrorState               // Unknown + severity
```

---

## 🔄 Retry Policies Quick Select

```dart
// 5 retries, aggressive backoff (OTP, network)
AuthRetryPolicies.otp
AuthRetryPolicies.network

// 3 retries, moderate backoff (SMS, general)
AuthRetryPolicies.sms

// 2 retries, moderate backoff (login)
AuthRetryPolicies.login

// 1-2 retries, conservative backoff (token, storage)
AuthRetryPolicies.token
AuthRetryPolicies.storage
```

---

## 📝 Logging Examples

```dart
// Log exception with context
AuthErrorLogger().logException(
  exception,
  userId: 'user_123',
  httpStatusCode: 401,
  context: {'operation': 'signIn'},
);

// Log error
AuthErrorLogger().logError(
  'CUSTOM_ERROR_CODE',
  'User-facing message',
  isRetryable: true,
  severity: ErrorSeverity.warning,
);

// Query logs
AuthErrorLogger().allLogs;
AuthErrorLogger().getRecentLogs(limit: 10);
AuthErrorLogger().getLogsByErrorCode('INVALID_CREDENTIALS');
AuthErrorLogger().getErrorStatistics();
```

---

## 💡 Usage Patterns

### Repository
```dart
Future<Either<Failure, T>> method() async {
  try {
    final result = await AuthRetryPolicies.login.execute(
      () => _remoteDataSource.method(),
      operationName: 'MethodName',
    );
    
    if (!result.succeeded) {
      return Left(Failure(result.exception!.message));
    }
    
    return Right(result.result!);
  } catch (e, stackTrace) {
    AuthErrorLogger().logError(
      'METHOD_FAILED',
      'Error occurred',
      originalError: e,
      stackTrace: stackTrace,
    );
    return Left(Failure('حدث خطأ'));
  }
}
```

### Cubit
```dart
Future<void> method() async {
  emit(const AuthLoadingState());
  
  final result = await _repository.method();
  
  result.fold(
    (failure) => emit(_mapFailureToErrorState(failure.message)),
    (success) => emit(SuccessState()),
  );
}

AuthErrorState _mapFailureToErrorState(String message) {
  if (message.contains('بريد')) return InvalidCredentialsErrorState();
  if (message.contains('اتصال')) return NetworkErrorState();
  return UnknownErrorState(message: message);
}
```

### UI
```dart
if (state is InvalidCredentialsErrorState) {
  return ErrorWidget(
    message: state.message,
    showRetry: state.canRetry,
    showDetails: state.showDetails,
    details: state.exceptionDetails,
    onRetry: _onRetry,
  );
}
```

---

## 🚀 Common Patterns

### Try-Catch Pattern
```dart
try {
  await operation();
} on InvalidCredentialsException catch (e) {
  // Handle specific exception
  emit(InvalidCredentialsErrorState(message: e.message));
} on NetworkException catch (e) {
  // Handle network error
  emit(NetworkErrorState(message: e.message));
} on AuthException catch (e) {
  // Handle other auth exceptions
  emit(UnknownErrorState(message: e.message));
}
```

### Retry Pattern
```dart
final result = await policy.execute(
  () => operation(),
  operationName: 'OperationName',
);

if (result.succeeded) {
  print('Success after ${result.attempts} attempts');
} else {
  print('Failed: ${result.exception?.errorCode}');
  throw result.exception!;
}
```

### Logging Pattern
```dart
catch (e, stackTrace) {
  final exception = e is AuthException 
    ? e 
    : AuthExceptionFactory.fromException(e, stackTrace: stackTrace);
    
  AuthErrorLogger().logException(
    exception,
    userId: currentUserId,
    context: {'operation': 'methodName'},
  );
  
  throw exception;
}
```

---

## ✅ Error Properties

```dart
// Every exception has:
exception.message           // User-facing message (Arabic)
exception.errorCode         // Code for categorization
exception.isRetryable       // Should retry?
exception.originalError     // Original error (for debugging)
exception.stackTrace        // Stack trace

// Every error state has:
state.message               // User-facing message
state.errorCode             // Code for categorization
state.canRetry              // Show retry button?
state.showDetails           // Show technical details?
state.exceptionDetails      // Original error (for logging)
state.context               // Additional data (Map)
```

---

## 🎯 Error Decision Tree

```
Is it a network error?
  → Yes: Use NetworkErrorState, show retry button
  → No: Continue

Is it a timeout?
  → Yes: Use TimeoutErrorState, show retry button, auto-retry
  → No: Continue

Is it invalid credentials?
  → Yes: Use InvalidCredentialsErrorState, track attempts
  → No: Continue

Is it token expired?
  → Yes: Use TokenExpiredErrorState, redirect to login
  → No: Continue

Is it OTP related?
  → Yes: Use InvalidOtpErrorState/OtpExpiredErrorState
  → No: Continue

Is it a validation error?
  → Yes: Use ValidationErrorState, don't retry
  → No: Continue

Is it server error (5xx)?
  → Yes: Use ServerErrorState, show retry button, auto-retry
  → No: Continue

→ Use UnknownErrorState
```

---

## 🔧 Implementation Checklist

- [ ] Throw specific `AuthException` (never generic)
- [ ] Catch at repository layer
- [ ] Use appropriate retry policy
- [ ] Log with context
- [ ] Emit specific error state
- [ ] Handle JSON parsing
- [ ] Validate input
- [ ] Preserve stack trace
- [ ] Provide Arabic messages
- [ ] Add recovery action

---

## 📊 Error Statistics

```dart
final stats = AuthErrorLogger().getErrorStatistics();

// {
//   'totalErrors': 42,
//   'retryableErrors': 18,
//   'errorsByCode': {
//     'INVALID_CREDENTIALS': 5,
//     'NETWORK_ERROR': 3,
//     'TOKEN_EXPIRED': 2,
//   },
//   'errorsBySeverity': {
//     'error': 35,
//     'warning': 5,
//     'critical': 2,
//   },
//   'lastError': { ... }
// }
```

---

## 🆘 Quick Fixes

**Q: Error not being logged?**
A: Ensure `AuthErrorLogger().logException(exception)` is called

**Q: Retry not working?**
A: Use `AuthRetryPolicies.* .execute()` instead of direct call

**Q: State not emitted?**
A: Check exception type matches error state type

**Q: JSON parsing fails silently?**
A: Use try-catch for `jsonDecode()`, throw `CorruptedDataException`

**Q: No stack trace?**
A: Pass `stackTrace` parameter to exception/logger

---

## 🎓 Best Practices

1. **Throw Early**: Validate input and throw `ValidationException` immediately
2. **Catch Specific**: Catch specific exceptions, not generic `Exception`
3. **Log Always**: Log every exception for analytics
4. **Retry Smart**: Use exponential backoff, not immediate retry
5. **Inform User**: Provide clear Arabic messages with actions
6. **Preserve Context**: Always include stack traces and context
7. **Type Safe**: Use specific error states, not strings
8. **Test Thoroughly**: Test all error paths, not just happy path

---

## 📚 Full Documentation

See `ERROR_HANDLING_GUIDE.md` for comprehensive documentation.

See files in `lib/features/auth/utils/` for implementation.
