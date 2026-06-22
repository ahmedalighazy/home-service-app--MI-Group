# Token Manager - Quick Reference

## 🎯 Core Methods

### 💾 Save
```dart
await ds.saveAccessToken('token');           // Store access token
await ds.saveRefreshToken('refresh_token');  // Store refresh token
await ds.saveTokenExpiry(expiryTime);        // Store expiry timestamp
await ds.saveUserData({'id': '123'});        // Store user data
```

### 📖 Get
```dart
await ds.getAccessToken();    // Returns: String? | 'token'
await ds.getRefreshToken();   // Returns: String? | 'refresh_token'
await ds.getBearerToken();    // Returns: String? | 'Bearer token'
await ds.getUserData();       // Returns: Map<String, dynamic>? | {'id': '123'}
```

### ✅ Check
```dart
await ds.hasToken();              // Returns: bool | true/false
await ds.isTokenValid();           // Returns: bool | expired?
await ds.isTokenExpiringSoon();    // Returns: bool | < 60 sec?
await ds.getTimeUntilExpiry();     // Returns: Duration? | time left
```

### 🗑️ Delete
```dart
await ds.deleteToken();          // Delete tokens
await ds.clearAllAuthData();     // Delete everything
```

---

## 📋 Common Patterns

### Pattern 1: Sign In & Save Token
```dart
// In Repository
Future<Either<Failure, AuthTokenEntity>> signIn({...}) async {
  final apiResponse = await _remote.signIn(email, password);
  
  // Save tokens
  await _local.saveAccessToken(apiResponse.accessToken);
  await _local.saveRefreshToken(apiResponse.refreshToken);
  await _local.saveTokenExpiry(DateTime.now().add(Duration(hours: 1)));
  
  return Right(apiResponse);
}
```

### Pattern 2: Use Token in Requests
```dart
// In Repository
Future<void> completeProfile({...}) async {
  final token = await _local.getBearerToken();
  
  await _remote.completeProfile(
    token: token,
    data: userData,
  );
}
```

### Pattern 3: Check Auth on Startup
```dart
// In Cubit
Future<void> checkAuthStatus() async {
  try {
    final isValid = await _authRepository.isTokenValid();
    
    if (isValid) {
      emit(const AuthSuccessState(action: 'auth_restored', data: {}));
    } else {
      // Try refresh or go to login
    }
  } catch (e) {
    emit(const AuthInitialState());
  }
}
```

### Pattern 4: Token Refresh
```dart
// In Repository
Future<Either<Failure, AuthTokenEntity>> refreshAccessToken() async {
  final refreshToken = await _local.getRefreshToken();
  final apiResponse = await _remote.refreshToken(refreshToken);
  
  await _local.saveAccessToken(apiResponse.accessToken);
  await _local.saveTokenExpiry(DateTime.now().add(Duration(hours: 1)));
  
  return Right(apiResponse);
}
```

### Pattern 5: Logout
```dart
// In Repository
Future<Either<Failure, void>> logout() async {
  await _remote.logout();
  await _local.clearAllAuthData();
  return const Right(null);
}
```

---

## 🔑 Storage Keys (Internal)

For debugging in SharedPreferences:

| Key | Type | Example |
|-----|------|---------|
| `secure_auth_token` | String | `"eyJhbGc..."` |
| `secure_refresh_token` | String | `"eyJyZW..."` |
| `secure_token_expiry` | String | `"2026-06-10T15:30:00.000Z"` |
| `secure_user_data` | String | `{"id":"123","email":"user@example.com"}` |

---

## 🧪 Testing Template

```dart
void main() {
  late AuthLocalDataSourceMock mockDataSource;

  setUp(() => mockDataSource = AuthLocalDataSourceMock());

  group('Token Manager', () {
    test('saveAccessToken and getAccessToken', () async {
      await mockDataSource.saveAccessToken('test_token');
      expect(await mockDataSource.getAccessToken(), 'test_token');
    });

    test('getBearerToken includes Bearer prefix', () async {
      await mockDataSource.saveAccessToken('token123');
      expect(
        await mockDataSource.getBearerToken(),
        'Bearer token123',
      );
    });

    test('isTokenValid returns true for valid token', () async {
      await mockDataSource.saveAccessToken('token');
      await mockDataSource.saveTokenExpiry(
        DateTime.now().add(Duration(hours: 1)),
      );
      expect(await mockDataSource.isTokenValid(), true);
    });

    test('isTokenValid returns false for expired token', () async {
      await mockDataSource.saveAccessToken('token');
      await mockDataSource.saveTokenExpiry(
        DateTime.now().subtract(Duration(hours: 1)),
      );
      expect(await mockDataSource.isTokenValid(), false);
    });

    test('clearAllAuthData removes all tokens', () async {
      await mockDataSource.saveAccessToken('token');
      await mockDataSource.saveRefreshToken('refresh');
      
      await mockDataSource.clearAllAuthData();
      
      expect(await mockDataSource.hasToken(), false);
      expect(await mockDataSource.getRefreshToken(), null);
    });
  });
}
```

---

## 🏗️ Architecture Flow

```
User Action (Sign In)
        ↓
SignInUseCase.call()
        ↓
AuthRepository.signIn()
        ↓
AuthRemoteDataSource.signIn() ──→ API Call
        ↓
Receive: {accessToken, refreshToken, expiresIn}
        ↓
AuthRepository saves via LocalDataSource:
  ├─ saveAccessToken()
  ├─ saveRefreshToken()
  └─ saveTokenExpiry()
        ↓
Return Right(TokenEntity)
        ↓
Cubit emits AuthSuccessState
        ↓
UI shows home screen
```

---

## ⚡ Performance Tips

1. **Don't call repeatedly in loops**
   ```dart
   // ❌ Bad
   for (int i = 0; i < 100; i++) {
     final token = await ds.getAccessToken();
   }
   
   // ✅ Good
   final token = await ds.getAccessToken();
   for (int i = 0; i < 100; i++) {
     // Use token
   }
   ```

2. **Cache token in Cubit state**
   ```dart
   // ✅ Good - store in state
   final token = await ds.getAccessToken();
   emit(AuthSuccessState(data: {'token': token}));
   ```

3. **Check expiry before making requests**
   ```dart
   // ✅ Good - refresh if needed
   if (await ds.isTokenExpiringSoon()) {
     await refreshAccessToken();
   }
   ```

---

## 🐛 Troubleshooting

### Token is null?
```dart
final hasToken = await ds.hasToken();
if (!hasToken) {
  // Token not saved yet, go to login
}
```

### Token validation failing?
```dart
final isValid = await ds.isTokenValid();
if (!isValid) {
  // Token expired, refresh it
  await refreshAccessToken();
}
```

### Data not persisting?
```dart
// Make sure using Real implementation
final prefs = await SharedPreferences.getInstance();
final dataSource = AuthLocalDataSourceReal(prefs);
```

### Mock not working in tests?
```dart
// Use Mock for testing
final dataSource = AuthLocalDataSourceMock();
// Works exactly same as Real but in memory
```

---

## 📚 Learn More

- **Integration Guide**: `TOKEN_MANAGER_INTEGRATION.md`
- **Setup Guide**: `TOKEN_MANAGER_SETUP.md`
- **Completion Report**: `TOKEN_MANAGER_COMPLETION.md`

---

## ✅ Checklist

- [ ] Updated Repository to use Token Manager methods
- [ ] Wired AuthLocalDataSourceReal in DI
- [ ] Implemented token save on sign in
- [ ] Implemented token retrieval for API calls
- [ ] Added token validation on app startup
- [ ] Implemented token refresh logic
- [ ] Added error handling for token operations
- [ ] Wrote unit tests with Mock
- [ ] Tested on real device with Real implementation
- [ ] Handled logout (clearAllAuthData)

---

*Quick Reference v1.0 - Token Manager Integration*
