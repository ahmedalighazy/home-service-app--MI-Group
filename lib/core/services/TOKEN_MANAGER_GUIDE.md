# Token Manager Guide

## Overview

Token Manager مسؤول عن إدارة الـ Authentication Tokens بشكل آمن:
- حفظ الـ Access Token
- حفظ الـ Refresh Token
- حفظ بيانات المستخدم
- التحقق من صلاحية الـ Token
- تحديث الـ Token عند انتهاء الصلاحية

---

## الملفات

### 1. **token_manager.dart** (الأساسي)
```dart
// Abstract class والـ Implementation البسيطة
abstract class TokenManager { ... }
class TokenManagerImpl implements TokenManager { ... }
```

### 2. **token_manager_secure.dart** ⭐ (الموصى به)
```dart
// Enhanced version مع dart:convert و JSON handling أفضل
class SecureTokenManager { ... }
```

---

## الاستخدام

### 1. **Setup في DI:**

```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/token_manager_secure.dart';

void setupTokenManager() {
  final prefs = await SharedPreferences.getInstance();
  final tokenManager = SecureTokenManager(preferences: prefs);
  getIt.registerSingleton<SecureTokenManager>(tokenManager);
}
```

### 2. **في main.dart:**

```dart
import 'core/services/token_manager_secure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Setup Token Manager
  final prefs = await SharedPreferences.getInstance();
  final tokenManager = SecureTokenManager(preferences: prefs);
  getIt.registerSingleton<SecureTokenManager>(tokenManager);
  
  // Setup باقي المحتويات
  setupAuthProviders();
  
  runApp(const MyApp());
}
```

### 3. **في Repository:**

```dart
import 'core/services/token_manager_secure.dart';

class AuthRepositoryImplWithTokens implements AuthRepository {
  final SecureTokenManager _tokenManager;

  Future<Either<Failure, AuthTokenEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );

      // حفظ الـ Token
      await _tokenManager.saveToken(result.accessToken);
      if (result.refreshToken != null) {
        await _tokenManager.saveRefreshToken(result.refreshToken!);
      }
      if (result.expiresIn != null) {
        final expiryTime = DateTime.now().add(
          Duration(seconds: result.expiresIn!),
        );
        await _tokenManager.saveTokenExpiry(expiryTime);
      }

      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Sign in failed: $e'));
    }
  }
}
```

---

## API Methods

### حفظ البيانات

```dart
// حفظ الـ Access Token
await tokenManager.saveToken('access_token_here');

// حفظ الـ Refresh Token
await tokenManager.saveRefreshToken('refresh_token_here');

// حفظ بيانات المستخدم
await tokenManager.saveUserData({
  'userId': '123',
  'email': 'user@example.com',
  'name': 'Ahmed Mohammed',
});

// حفظ وقت انتهاء الـ Token
await tokenManager.saveTokenExpiry(DateTime.now().add(Duration(hours: 1)));
```

### تحميل البيانات

```dart
// تحميل الـ Token
final token = await tokenManager.getToken();

// تحميل الـ Refresh Token
final refreshToken = await tokenManager.getRefreshToken();

// تحميل بيانات المستخدم
final userData = await tokenManager.getUserData();

// الحصول على الـ Token مع Bearer prefix
final bearerToken = await tokenManager.getBearerToken(); // "Bearer xxx"
```

### التحقق من الصلاحية

```dart
// التحقق من وجود Token
final hasToken = await tokenManager.hasToken();

// التحقق من صحة الـ Token
final isValid = await tokenManager.isTokenValid();

// التحقق من انتهاء الصلاحية قريباً
final expiringSoon = await tokenManager.isTokenExpiringSoon(); // خلال دقيقة

// الحصول على الوقت المتبقي
final timeLeft = await tokenManager.getTimeUntilExpiry();
```

### حذف البيانات

```dart
// حذف الـ Token (Logout)
await tokenManager.deleteToken();

// حذف جميع البيانات
await tokenManager.clearAll();
```

---

## المفهوم - كيف يعمل

### 1. **Sign In Flow:**
```
User enters email/password
    ↓
API returns access_token + refresh_token + expires_in
    ↓
TokenManager.saveToken(access_token)
    ↓
TokenManager.saveRefreshToken(refresh_token)
    ↓
TokenManager.saveTokenExpiry(DateTime.now() + Duration)
    ↓
User logged in ✅
```

### 2. **Check Authentication:**
```
Check if hasToken() → false → redirect to login
    ↓
Check if isTokenValid() → false → try refresh
    ↓
isTokenExpiringSoon() → true → refresh token proactively
    ↓
Token valid → proceed ✅
```

### 3. **Refresh Token Flow:**
```
Token expires or expiring soon
    ↓
Call API with refresh_token
    ↓
API returns new access_token
    ↓
TokenManager.saveToken(new_access_token)
    ↓
TokenManager.saveTokenExpiry(new_expiry)
    ↓
Continue with new token ✅
```

### 4. **Logout Flow:**
```
User clicks logout
    ↓
TokenManager.clearAll()
    ↓
All tokens and user data deleted
    ↓
Redirect to login ✅
```

---

## مثال متكامل

```dart
// In your Auth UseCase or Repository:

class SignInUseCase {
  final AuthRepository _authRepository;
  final SecureTokenManager _tokenManager;

  SignInUseCase(this._authRepository, this._tokenManager);

  Future<Either<Failure, AuthTokenEntity>> call({
    required String email,
    required String password,
  }) async {
    // 1. Call API
    final result = await _authRepository.signIn(
      email: email,
      password: password,
    );

    // 2. If success, save tokens
    return result.fold(
      (failure) => Left(failure),
      (token) async {
        // Save to Token Manager
        await _tokenManager.saveToken(token.accessToken);
        if (token.refreshToken != null) {
          await _tokenManager.saveRefreshToken(token.refreshToken!);
        }
        
        // Save user data
        await _tokenManager.saveUserData({
          'userId': token.userId,
          'email': email,
        });

        // Save expiry
        if (token.expiresIn != null) {
          final expiry = DateTime.now().add(
            Duration(seconds: token.expiresIn!),
          );
          await _tokenManager.saveTokenExpiry(expiry);
        }

        return Right(token);
      },
    );
  }
}
```

---

## استخدام الـ Token في API Calls

```dart
// In Remote DataSource:

class AuthRemoteDataSourceReal implements AuthRemoteDataSource {
  final http.Client _httpClient;
  final SecureTokenManager _tokenManager;

  Future<UserModel> getUser(String userId) async {
    // الحصول على الـ Token
    final token = await _tokenManager.getBearerToken();
    if (token == null) throw UnauthorizedException('No token');

    final response = await _httpClient.get(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {
        'Authorization': token,  // ✅ استخدام Token
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      // Token expired, try refresh
      throw UnauthorizedException('Token expired');
    } else {
      throw ServerException('Failed to get user');
    }
  }
}
```

---

## Token Refresh Interceptor Pattern

```dart
// Create an HTTP Client wrapper that handles token refresh:

class AuthHttpClient extends http.BaseClient {
  final http.Client _innerClient;
  final SecureTokenManager _tokenManager;

  AuthHttpClient({
    required http.Client innerClient,
    required SecureTokenManager tokenManager,
  })  : _innerClient = innerClient,
        _tokenManager = tokenManager;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // 1. Add token to request
    final token = await _tokenManager.getBearerToken();
    if (token != null) {
      request.headers['Authorization'] = token;
    }

    // 2. Send request
    var response = await _innerClient.send(request);

    // 3. If 401, try refresh and retry
    if (response.statusCode == 401) {
      final refreshToken = await _tokenManager.getRefreshToken();
      if (refreshToken != null) {
        // Refresh token logic here
        // Then retry the request with new token
      }
    }

    return response;
  }
}
```

---

## الأمان (Security)

### 1. **استخدام SharedPreferences:**
```dart
// ✅ آمن للـ Public data
// ❌ غير آمن للـ Sensitive data (استخدم Secure Storage)
```

### 2. **لـ Enhanced Security استخدم:**
```dart
// استبدل SharedPreferences ب Secure Storage:
// - flutter_secure_storage (للـ iOS/Android)
// - platform_channels (للـ native implementation)
```

### 3. **مثال مع Secure Storage:**
```dart
import 'flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();

// Instead of SharedPreferences:
await secureStorage.write(
  key: 'auth_token',
  value: token,
);

final token = await secureStorage.read(key: 'auth_token');
```

---

## Error Handling

```dart
try {
  await tokenManager.saveToken(token);
} on TokenManagerSecureException catch (e) {
  print('Token save failed: ${e.message}');
  // Handle error
}
```

---

## Use Cases

### 1. **Auto Logout when Token Expired:**
```dart
// In app startup
if (await tokenManager.hasToken()) {
  if (!await tokenManager.isTokenValid()) {
    await tokenManager.clearAll();
    // Redirect to login
  }
}
```

### 2. **Proactive Token Refresh:**
```dart
// Before making API call
if (await tokenManager.isTokenExpiringSoon()) {
  await repository.refreshToken();
}
```

### 3. **Remember User Data:**
```dart
final userData = await tokenManager.getUserData();
if (userData != null) {
  // Show user info
}
```

---

## Summary

✅ **SecureTokenManager** - استخدم هذا
✅ **حفظ وتحميل Tokens بسهولة**
✅ **التحقق من الصلاحية**
✅ **تحديث الـ Token**
✅ **Logout نظيف**

---

## Files:
- `token_manager.dart` - Basic implementation
- `token_manager_secure.dart` ⭐ - Enhanced (recommended)
- `auth_repository_impl_with_tokens.dart` - Integration example
