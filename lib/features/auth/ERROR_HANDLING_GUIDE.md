# Error Handling في Auth Feature

## 📋 نظرة عامة

تم بناء نظام error handling قوي يغطي جميع جوانب feature المصادقة بما فيها:
- ✅ Centralized Exception Definitions
- ✅ Comprehensive Error Logging
- ✅ Error Recovery Strategies
- ✅ Circuit Breaker Pattern
- ✅ Error Interception
- ✅ User-friendly Error Messages

---

## 🎯 المزايا الرئيسية

### 1. **Exception Hierarchy** (`auth_exceptions.dart`)
نظام استثناءات منظم ومفصل لكل حالة خطأ:

```dart
// Base class
abstract class AuthException implements Exception {
  final String message;
  final String errorCode;
  final bool isRetryable;
  final dynamic originalError;
  final StackTrace? stackTrace;
}

// Specific exceptions
- NetworkException      → No internet
- TimeoutException     → Request timeout
- ServerException      → 5xx errors
- InvalidCredentialsException → Wrong password
- TokenExpiredException → Need re-login
- InvalidOtpException  → Wrong OTP code
- ValidationException  → Input validation failed
- ... و 15+ exceptions أخرى
```

### 2. **Error Logging** (`auth_error_logger.dart`)
نظام logging مركزي مع analytics:

```dart
class AuthErrorLogger {
  // Single instance
  static final instance = AuthErrorLogger._instance;

  // Log operations
  void logException(AuthException exception, {...});
  void logError(String code, String message, {...});

  // Analytics
  List<ErrorLogEntry> getAllLogs();
  List<ErrorLogEntry> getRecentLogs(limit: 10);
  Map<String, dynamic> getErrorStatistics();
}

// Error Severity Levels
enum ErrorSeverity { info, warning, error, critical }
```

### 3. **Error Recovery** 
استراتيجيات recovery محددة حسب نوع الخطأ:

```dart
class ErrorRecoveryStrategy {
  bool showRetry;           // عرض زر إعادة المحاولة
  bool autoRetry;           // إعادة تلقائية
  Duration? autoRetryDelay; // تأخير إعادة المحاولة
  int maxRetries;           // الحد الأقصى للمحاولات
  bool redirectToLogin;     // الانتقال لشاشة تسجيل الدخول
  bool showDetailedError;   // عرض تفاصيل الخطأ
}
```

### 4. **Error Handling Mixins** (`error_handling_mixin.dart`)
Mixins قابلة للإعادة الاستخدام لمعالجة الأخطاء:

```dart
// For repositories and services
mixin ErrorHandlingMixin {
  Future<T?> executeWithErrorHandling<T>({...});
  Future<T> retryWithBackoff<T>({...});
  Future<void> chainOperations({...});
}

// For Cubits/Blocs
mixin CubitErrorHandling<T> on Cubit<T> {
  Future<void> safeEmit({...});
}
```

### 5. **Error Interceptor** (`error_interceptor.dart`)
نظام اعتراض الأخطاء العام:

```dart
class AuthErrorInterceptor {
  void registerHandler(ErrorInterceptorHandler handler);
  Future<void> intercept(AuthException exception);
}

// Built-in handlers
- NetworkErrorHandler
- AuthenticationErrorHandler
- ValidationErrorHandler
- AccountStateErrorHandler
```

### 6. **Circuit Breaker**
منع الفشل الكاسكادي:

```dart
class ErrorCircuitBreaker {
  bool canExecute(String operationKey);
  void recordSuccess(String operationKey);
  void recordFailure(String operationKey);
  CircuitBreakerState getState(String operationKey);
}

enum CircuitBreakerState { closed, open, halfOpen }
```

---

## 💡 أمثلة الاستخدام

### مثال 1: في Repository مع Error Handling

```dart
class AuthRepositoryImpl extends ErrorHandlingMixin implements AuthRepository {
  @override
  Future<Result<User>> signIn(String email, String password) async {
    return await executeWithErrorHandling(
      operation: () async {
        final response = await dioClient.post(
          '/auth/login',
          data: {'email': email, 'password': password},
        );
        return User.fromJson(response.data);
      },
      onError: (error) {
        // Handle error
      },
      userId: getCurrentUserId(),
      context: {'email': email},
    );
  }
}
```

### مثال 2: في Cubit مع Safe Emit

```dart
@injectable
class AuthCubitV2 extends Cubit<AuthState> with CubitErrorHandling {
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await safeEmit(
      () async {
        emit(const AuthLoadingState());
        
        final result = await _signInUseCase(
          email: email,
          password: password,
        );
        
        result.fold(
          (failure) => emit(AuthErrorState(failure.message)),
          (token) => emit(AuthSuccessState(action: 'sign_in', data: {
            'token': token.accessToken,
          })),
        );
      },
      userId: 'user_123',
    );
  }
}
```

### مثال 3: Retry with Exponential Backoff

```dart
// في Repository
Future<OtpResponse> sendOtp(String phone) {
  return retryWithBackoff(
    operation: () => dioClient.post('/auth/send-otp', data: {'phone': phone}),
    maxRetries: 3,
    initialDelay: Duration(milliseconds: 200),
    backoffMultiplier: 2.0,
    operationName: 'sendOtp',
  );
}
```

### مثال 4: Error Interceptor Setup

```dart
// في main.dart أو setup file
void setupErrorInterceptors() {
  final interceptor = AuthErrorInterceptor();
  
  // Network error handler
  interceptor.registerHandler(
    NetworkErrorHandler(
      onNetworkError: () {
        showNetworkErrorDialog();
      },
    ),
  );
  
  // Auth error handler
  interceptor.registerHandler(
    AuthenticationErrorHandler(
      onUnauthorized: () => navigateToLogin(),
      onTokenExpired: () => refreshTokenAndRetry(),
    ),
  );
}
```

### مثال 5: Circuit Breaker

```dart
// في critical operations
final circuitBreaker = ErrorCircuitBreaker();

Future<void> riskyOperation() async {
  if (!circuitBreaker.canExecute('riskyOp')) {
    throw Exception('Circuit breaker is open');
  }
  
  try {
    await performRiskyOperation();
    circuitBreaker.recordSuccess('riskyOp');
  } catch (e) {
    circuitBreaker.recordFailure('riskyOp');
    rethrow;
  }
}
```

### مثال 6: Error Recovery

```dart
// في screens
void handleAuthError(AuthException error) {
  final recovery = ErrorRecoveryExecutor();
  
  recovery.executeRecovery(
    error,
    onRetry: () => retryLastOperation(),
    onNavigateToLogin: () => context.go('/login'),
    onShowError: (message) => showErrorSnackBar(message),
  );
}
```

---

## 📊 Error Statistics و Monitoring

```dart
// الحصول على إحصائيات الأخطاء
final logger = AuthErrorLogger();
final stats = logger.getErrorStatistics();

print(stats);
// Output:
// {
//   'totalErrors': 45,
//   'retryableErrors': 12,
//   'errorsByCode': {'NETWORK_ERROR': 10, 'TIMEOUT_ERROR': 5, ...},
//   'errorsBySeverity': {'error': 30, 'warning': 15, ...},
//   'lastError': {...},
// }
```

---

## 🔍 Debugging

### طباعة الأخطاء

```dart
AuthErrorLogger().logError(
  'CUSTOM_ERROR',
  'Something went wrong',
  originalError: exception,
  stackTrace: stackTrace,
  severity: ErrorSeverity.error,
  context: {'userId': userId, 'action': 'signIn'},
);

// Output في Debug Console:
// ❌ [AuthError] CUSTOM_ERROR
//    Message: Something went wrong
//    Retryable: false
//    LogID: log_1234567890_5
//    Details: FormatException: Invalid JSON
```

### الحصول على Recent Logs

```dart
final recentLogs = AuthErrorLogger().getRecentLogs(limit: 20);
for (final log in recentLogs) {
  print(log);
}
```

### تنظيف الأخطاء

```dart
AuthErrorLogger().clearLogs();
```

---

## ✅ Best Practices

### 1. ✨ استخدم Exception المناسبة
```dart
// ✅ صحيح
throw InvalidOtpException(
  attemptsRemaining: 2,
  originalError: exception,
);

// ❌ خطأ
throw Exception('Invalid OTP');
```

### 2. 📝 أضف Context معلومات
```dart
// ✅ صحيح
AuthErrorLogger().logError(
  'SIGN_IN_FAILED',
  'Invalid credentials',
  context: {'email': userEmail, 'timestamp': DateTime.now()},
);

// ❌ خطأ
AuthErrorLogger().logError('SIGN_IN_FAILED', 'Invalid credentials');
```

### 3. 🔄 استخدم Retry للعمليات القابلة للإعادة
```dart
// ✅ صحيح
if (error.isRetryable) {
  return await retryWithBackoff(
    operation: () => networkCall(),
    maxRetries: 3,
  );
}

// ❌ خطأ - بدون checking isRetryable
return await networkCall(); // Will fail on timeout
```

### 4. 🛑 استخدم Circuit Breaker للعمليات الحساسة
```dart
// ✅ صحيح
if (!circuitBreaker.canExecute('criticalOp')) {
  throw Exception('Service temporarily unavailable');
}

// ❌ خطأ - بدون circuit breaker
await riskyOperation();
```

### 5. 👤 أضف User ID للتتبع
```dart
// ✅ صحيح
AuthErrorLogger().logException(
  exception,
  userId: currentUser?.id,
  context: {'email': currentUser?.email},
);

// ❌ خطأ
AuthErrorLogger().logException(exception);
```

---

## 🚨 Error Messages في العربية

جميع الأخطاء لديها رسائل واضحة بالعربية:

| Exception | Message |
|-----------|---------|
| NetworkException | لا يوجد اتصال بالإنترنت. تحقق من الاتصال وحاول مجددًا. |
| TimeoutException | انتهت مهلة الاتصال. يرجى المحاولة مجددًا. |
| InvalidCredentialsException | بريد إلكتروني أو كلمة مرور غير صحيحة. |
| TokenExpiredException | انتهت صلاحية الجلسة. يرجى تسجيل الدخول مجددًا. |
| InvalidOtpException | كود التحقق غير صحيح. |
| OtpExpiredException | انتهت صلاحية كود التحقق. يرجى طلب كود جديد. |

---

## 📦 الملفات المتعلقة

1. **`auth_exceptions.dart`** - تعريفات الاستثناءات (20+ exceptions)
2. **`auth_error_logger.dart`** - نظام logging و analytics
3. **`error_handling_mixin.dart`** - Mixins قابلة للإعادة
4. **`error_interceptor.dart`** - اعتراض الأخطاء و recovery

---

## 🎓 مصادر إضافية

- **Pattern Used**: Result Pattern (Either type)
- **Logging**: Centralized with analytics
- **Recovery**: Automatic retry with exponential backoff
- **Monitoring**: Circuit breaker + Error aggregator
- **User Experience**: Localized error messages + recovery strategies

---

## 🔧 التحسينات المستقبلية

- [ ] Integration with Firebase Crashlytics
- [ ] Integration with Sentry for monitoring
- [ ] Real-time error dashboard
- [ ] Advanced error analytics
- [ ] Machine learning for error prediction
- [ ] Automated error triage system

---

**آخر تحديث**: June 2026  
**الحالة**: ✅ Production Ready
