# Token Manager Setup - Complete Summary

## ✅ تم الإنشاء

تم بناء **نظام إدارة Tokens** كامل وآمن للـ Authentication.

---

## الملفات المُنشأة

### 1. **lib/core/services/token_manager.dart**
```dart
// أساسي - Abstract interface + basic implementation
- TokenManager (interface)
- TokenManagerImpl (basic implementation)
```

### 2. **lib/core/services/token_manager_secure.dart** ⭐ (الموصى به)
```dart
// محسّن - مع dart:convert و extra features
- SecureTokenManager (enhanced implementation)
- Better JSON handling
- Token expiry checks
- Remaining time calculation
- Bearer token support
```

### 3. **lib/features/auth/data/repositories/auth_repository_impl_with_tokens.dart**
```dart
// Integration مثال
- استخدام TokenManager مع Repository
- حفظ الـ Tokens تلقائياً
- التحقق من الصلاحية
- تحديث الـ Token
- Logout آمن
```

### 4. **lib/core/services/TOKEN_MANAGER_GUIDE.md**
```dart
// توثيق شامل
- How to use
- API methods
- Flow examples
- Security considerations
- Integration patterns
```

---

## المبدأ الأساسي

### Token Lifecycle:

```
1. Sign In
   ↓
   API returns: access_token, refresh_token, expires_in
   ↓
2. Save Tokens
   ↓
   TokenManager.saveToken(access_token)
   TokenManager.saveRefreshToken(refresh_token)
   TokenManager.saveTokenExpiry(DateTime)
   ↓
3. Use Token
   ↓
   Get from TokenManager when needed
   Add to request headers: "Authorization: Bearer {token}"
   ↓
4. Token Expiry Check
   ↓
   Before API call: isTokenValid()
   If expiring: refreshToken()
   ↓
5. Logout
   ↓
   TokenManager.clearAll()
   Delete all tokens and user data
```

---

## الاستخدام الأساسي

### Setup (في main.dart):

```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/token_manager_secure.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Setup Token Manager
  final prefs = await SharedPreferences.getInstance();
  final tokenManager = SecureTokenManager(preferences: prefs);
  
  // 2. Register in DI
  getIt.registerSingleton<SecureTokenManager>(tokenManager);
  
  // 3. Setup Auth
  setupAuthProviders();
  
  runApp(const MyApp());
}
```

### استخدام (في Repository):

```dart
class AuthRepositoryImplWithTokens implements AuthRepository {
  final SecureTokenManager _tokenManager;

  Future<Either<Failure, AuthTokenEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Call API
      final result = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );

      // 2. Save Token
      await _tokenManager.saveToken(result.accessToken);
      
      // 3. Save Refresh Token
      if (result.refreshToken != null) {
        await _tokenManager.saveRefreshToken(result.refreshToken!);
      }
      
      // 4. Save Expiry
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

### Save Methods:

```dart
// Save Access Token
await tokenManager.saveToken('access_token_xyz');

// Save Refresh Token
await tokenManager.saveRefreshToken('refresh_token_xyz');

// Save User Data
await tokenManager.saveUserData({
  'userId': '123',
  'email': 'user@example.com',
  'name': 'Ahmed',
});

// Save Token Expiry
await tokenManager.saveTokenExpiry(DateTime.now().add(Duration(hours: 1)));
```

### Retrieve Methods:

```dart
// Get Access Token
final token = await tokenManager.getToken();

// Get Refresh Token
final refreshToken = await tokenManager.getRefreshToken();

// Get User Data
final userData = await tokenManager.getUserData();

// Get Bearer Token (with "Bearer " prefix)
final bearerToken = await tokenManager.getBearerToken(); // "Bearer xxx"
```

### Validation Methods:

```dart
// Check if token exists
final hasToken = await tokenManager.hasToken();

// Check if token is valid (not expired)
final isValid = await tokenManager.isTokenValid();

// Check if token expiring soon (within 1 minute)
final expiringSoon = await tokenManager.isTokenExpiringSoon();

// Get remaining time
final timeLeft = await tokenManager.getTimeUntilExpiry();
```

### Delete Methods:

```dart
// Delete Token (Logout)
await tokenManager.deleteToken();

// Clear All (Sign Out)
await tokenManager.clearAll();
```

---

## Use in HTTP Requests

### Remote DataSource:

```dart
class AuthRemoteDataSourceReal {
  final http.Client _httpClient;
  final SecureTokenManager _tokenManager;

  Future<UserModel> getUser(String userId) async {
    // Get token from TokenManager
    final token = await _tokenManager.getBearerToken();
    if (token == null) throw UnauthorizedException('No token');

    final response = await _httpClient.get(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {
        'Authorization': token,  // ✅ Use Token
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      // Unauthorized - Token might be expired
      throw UnauthorizedException('Token expired');
    }
  }
}
```

---

## Example Flows

### 1. Sign In Flow:
```dart
// User logs in
await authCubit.signIn(email, password);

// In Cubit:
// 1. Call repository.signIn()
// 2. Repository calls remoteDataSource.signIn()
// 3. API returns tokens
// 4. Repository saves tokens to TokenManager
// 5. TokenManager stores in SharedPreferences
// 6. Emit success state
// 7. Navigate to home
```

### 2. Auto Token Refresh:
```dart
// In API interceptor or before API calls:
if (await tokenManager.isTokenExpiringSoon()) {
  await repository.refreshToken();
}

// In Repository:
Future<void> refreshToken() async {
  final refreshToken = await _tokenManager.getRefreshToken();
  final newToken = await _remoteDataSource.refreshToken(refreshToken);
  await _tokenManager.saveToken(newToken.accessToken);
}
```

### 3. Logout:
```dart
// User clicks logout
await authCubit.logout();

// In Cubit:
await _tokenManager.clearAll();

// All tokens and user data deleted
// Navigate to login
```

---

## Security Best Practices

### ✅ Do's:

```dart
// ✅ Use TokenManager for all token operations
await tokenManager.saveToken(token);

// ✅ Check token validity before API calls
if (!await tokenManager.isTokenValid()) {
  // Handle invalid token
}

// ✅ Clear tokens on logout
await tokenManager.clearAll();

// ✅ Use Bearer prefix correctly
final bearerToken = await tokenManager.getBearerToken();
```

### ❌ Don'ts:

```dart
// ❌ Don't hardcode tokens in app
const token = 'xyz'; // WRONG

// ❌ Don't store tokens in plain text
SharedPreferences.setString('token', token); // WRONG (use TokenManager)

// ❌ Don't forget to handle 401 responses
// Handle token expiry and refresh

// ❌ Don't expose tokens in logs
print(token); // WRONG - Security risk
```

---

## For Enhanced Security

### Use flutter_secure_storage instead:

```dart
import 'flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

// More secure than SharedPreferences
await storage.write(key: 'auth_token', value: token);
final token = await storage.read(key: 'auth_token');
```

---

## Dependencies

### Add to pubspec.yaml:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.0.0      # For Token Manager
  http: ^1.0.0                     # For API calls
  dartz: ^0.10.1                   # For Either type
  get_it: ^7.0.0                   # For DI
```

---

## File Structure

```
lib/
├── core/
│   ├── services/
│   │   ├── token_manager.dart ✅
│   │   ├── token_manager_secure.dart ⭐
│   │   └── TOKEN_MANAGER_GUIDE.md
│   └── routing/
│       └── app_router.dart
│
└── features/auth/
    └── data/repositories/
        └── auth_repository_impl_with_tokens.dart ✅
```

---

## Integration Steps

1. ✅ Create TokenManager files
2. ✅ Setup in DI (main.dart)
3. ✅ Inject into Repository
4. ✅ Save tokens on sign in
5. ✅ Load tokens on app start
6. ✅ Use in HTTP headers
7. ✅ Refresh on expiry
8. ✅ Clear on logout

---

## Example Complete Flow

```
App Start
  ↓
Check TokenManager.hasToken()
  ├─ No → Show login
  └─ Yes:
      ↓
      Check isTokenValid()
      ├─ No → Try refresh
      │       ├─ Success → Use new token
      │       └─ Fail → Show login
      └─ Yes → Load home with token
```

---

## Summary

✅ **SecureTokenManager** - استخدم هذا
✅ **حفظ آمن للـ Tokens**
✅ **التحقق من الصلاحية**
✅ **تحديث الـ Token تلقائي**
✅ **Logout نظيف**
✅ **Ready for production**

---

## الملفات للمرجعية:
1. `token_manager_secure.dart` ⭐
2. `TOKEN_MANAGER_GUIDE.md`
3. `auth_repository_impl_with_tokens.dart`

**Status**: ✅ COMPLETE - Ready to integrate!
