# ⚡ Error Handling - Quick Reference

## 📂 الملفات الأساسية

```
lib/features/auth/utils/
├── auth_exceptions.dart         (20+ استثناء محددة)
├── auth_error_logger.dart       (نظام logging مركزي)
├── error_handling_mixin.dart    (Mixins قابلة للإعادة)
└── error_interceptor.dart       (اعتراض الأخطاء العام)
```

---

## 🚀 الاستخدام السريع

### 1. في Repository

```dart
import 'package:home_service_app/features/auth/utils/error_handling_mixin.dart';

class AuthRepositoryImpl with ErrorHandlingMixin implements AuthRepository {
  Future<User> signIn(String email, String password) async {
    return await executeWithErrorHandling(
      operation: () => _api.post('/login', data: {'email': email, 'password': password}),
      onError: (error) => print('Error: ${error.message}'),
      userId: 'user_123',
    );
  }
}
```

### 2. في Cubit

```dart
import 'package:home_service_app/features/auth/utils/error_handling_mixin.dart';

class AuthCubit extends Cubit<AuthState> with CubitErrorHandling {
  Future<void> signIn(String email, String password) async {
    await safeEmit(() async {
      emit(AuthLoadingState());
      final result = await _repo.signIn(email, password);
      emit(AuthSuccessState(action: 'signin', data: {'email': email}));
    });
  }
}
```

### 3. في Screen

```dart
void handleAuthError(AuthException error) {
  if (error.isRetryable) {
    showSnackBar('${error.message}\nإعادة المحاولة...');
  } else {
    showErrorDialog(error.message);
  }
}
```

---

## 🎯 Exception Types

### Network
```dart
throw NetworkException();              // No internet
throw TimeoutException();              // Request timeout
throw ServerException(statusCode: 500); // 5xx error
```

### Authentication
```dart
throw InvalidCredentialsException();    // Wrong password
throw TokenExpiredException();          // Session ended
throw UnauthorizedException();          // Unauthorized
```

### OTP/Validation
```dart
throw InvalidOtpException();            // Wrong OTP
throw OtpExpiredException();            // OTP expired
throw ValidationException(
  message: 'Invalid email',
  fieldName: 'email',
);
```

### Storage
```dart
throw LocalStorageReadException();      // Can't read
throw LocalStorageWriteException();     // Can't write
throw CorruptedDataException();         // Data corrupted
```

---

## 🔄 Retry Pattern

```dart
// Single retry with backoff
final result = await retryWithBackoff(
  operation: () => apiCall(),
  maxRetries: 3,
  initialDelay: Duration(milliseconds: 200),
  backoffMultiplier: 2.0,
);
```

---

## 📊 Logging

```dart
// Log error
AuthErrorLogger().logError(
  'SIGN_IN_FAILED',
  'Invalid credentials',
  originalError: exception,
  context: {'email': email},
);

// Get statistics
final stats = AuthErrorLogger().getErrorStatistics();
print('Total errors: ${stats['totalErrors']}');
print('Retryable: ${stats['retryableErrors']}');
```

---

## 🛑 Circuit Breaker

```dart
final breaker = ErrorCircuitBreaker();

if (!breaker.canExecute('criticalOp')) {
  throw Exception('Service temporarily unavailable');
}

try {
  await riskyOperation();
  breaker.recordSuccess('criticalOp');
} catch (e) {
  breaker.recordFailure('criticalOp');
}
```

---

## 🎨 Error Messages (Arabic)

| Exception | Message |
|-----------|---------|
| NetworkException | لا يوجد اتصال بالإنترنت |
| TimeoutException | انتهت مهلة الاتصال |
| InvalidCredentialsException | بريد إلكتروني أو كلمة مرور غير صحيحة |
| TokenExpiredException | انتهت صلاحية الجلسة |
| InvalidOtpException | كود التحقق غير صحيح |

---

## ⚙️ Configuration

### Setup في main.dart

```dart
void main() {
  setupErrorInterceptors();
  runApp(const MyApp());
}

void setupErrorInterceptors() {
  final interceptor = AuthErrorInterceptor();
  
  interceptor.registerHandler(
    NetworkErrorHandler(
      onNetworkError: () => showNetworkError(),
    ),
  );
  
  interceptor.registerHandler(
    AuthenticationErrorHandler(
      onUnauthorized: () => logout(),
      onTokenExpired: () => refreshToken(),
    ),
  );
}
```

---

## 🔍 Debugging

```dart
// Get all recent errors
final logs = AuthErrorLogger().getRecentLogs(limit: 10);

// Filter by error code
final networkErrors = AuthErrorLogger()
    .getLogsByErrorCode('NETWORK_ERROR');

// Get error statistics
final stats = AuthErrorLogger().getErrorStatistics();

// Clear logs
AuthErrorLogger().clearLogs();
```

---

## ✅ Best Practices

- ✅ استخدم Exception المحددة (ليس generic)
- ✅ أضف context معلومات مهمة
- ✅ تتبع user IDs للأمان
- ✅ استخدم retry للعمليات القابلة للإعادة
- ✅ redirect to login على token expiry
- ✅ عرض رسائل بالعربية
- ✅ سجل الأخطاء دائماً

---

## 🚨 Common Patterns

### Network Call with Retry
```dart
Future<T> fetchWithRetry<T>(Future<T> Function() operation) {
  return retryWithBackoff(
    operation: operation,
    maxRetries: 3,
    initialDelay: Duration(milliseconds: 500),
  );
}
```

### Safe Emit Pattern
```dart
await safeEmit(() async {
  emit(LoadingState());
  final result = await operation();
  emit(SuccessState(result));
});
```

### Error Recovery Pattern
```dart
final strategy = ErrorRecoveryStrategy.forException(error);
if (strategy.redirectToLogin) {
  navigateToLogin();
} else if (strategy.showRetry) {
  retryLastOperation();
}
```

---

## 📱 In UI

```dart
// Show error snackbar
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(error.message)),
);

// Show error dialog
showDialog(
  context: context,
  builder: (_) => AlertDialog(
    title: Text('خطأ'),
    content: Text(error.message),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('حسناً'),
      ),
    ],
  ),
);

// Show with retry
showDialog(
  context: context,
  builder: (_) => AlertDialog(
    title: Text('خطأ'),
    content: Text(error.message),
    actions: [
      TextButton(
        onPressed: () => retry(),
        child: Text('إعادة'),
      ),
    ],
  ),
);
```

---

## 📈 Error Statistics

```dart
final stats = AuthErrorLogger().getErrorStatistics();

// Output:
{
  'totalErrors': 45,
  'retryableErrors': 12,
  'errorsByCode': {
    'NETWORK_ERROR': 10,
    'TIMEOUT_ERROR': 5,
    'INVALID_CREDENTIALS': 3,
  },
  'errorsBySeverity': {
    'error': 30,
    'warning': 15,
  },
  'lastError': {...},
}
```

---

## 🔗 Documentation Files

1. **ERROR_HANDLING_GUIDE.md** - دليل شامل
2. **ERROR_HANDLING_SUMMARY.md** - ملخص المميزات
3. **QUICK_ERROR_REFERENCE.md** - هذا الملف

---

## 💡 Tips

- استخدم `executeWithErrorHandling` للعمليات البسيطة
- استخدم `safeEmit` في Cubits
- استخدم `retryWithBackoff` للعمليات الحساسة
- سجل context معلومات مهمة
- اختبر recovery strategies قبل deployment

---

**آخر تحديث:** June 2026  
**الحالة:** ✅ Ready to Use
