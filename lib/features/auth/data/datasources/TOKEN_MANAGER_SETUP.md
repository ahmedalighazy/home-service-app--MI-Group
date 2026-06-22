# Token Manager Setup - Quick Start

## What Changed?

Token Manager functionality has been integrated directly into `AuthLocalDataSource`. No need for a separate TokenManager class anymore!

## Files Updated

1. **auth_local_datasource.dart** - Added 12 new Token Manager methods to interface
2. **auth_local_datasource_real.dart** - Implemented Token Manager with SharedPreferences
3. **auth_local_datasource_impl.dart** - Added Token Manager to Mock implementation

## Key Methods Now Available

### Save Methods
```dart
await localDataSource.saveAccessToken('token_string');
await localDataSource.saveRefreshToken('refresh_token_string');
await localDataSource.saveTokenExpiry(DateTime.now().add(Duration(hours: 1)));
await localDataSource.saveUserData({'userId': '123', 'email': 'user@example.com'});
```

### Retrieve Methods
```dart
final token = await localDataSource.getAccessToken();
final refreshToken = await localDataSource.getRefreshToken();
final bearerToken = await localDataSource.getBearerToken(); // 'Bearer token_string'
final userData = await localDataSource.getUserData();
```

### Validation Methods
```dart
final hasToken = await localDataSource.hasToken();
final isValid = await localDataSource.isTokenValid();
final timeLeft = await localDataSource.getTimeUntilExpiry();
final expiringSoon = await localDataSource.isTokenExpiringSoon();
```

### Cleanup Methods
```dart
await localDataSource.deleteToken(); // Delete both access and refresh tokens
await localDataSource.clearAllAuthData(); // Clear everything
```

## How to Use in Repository

```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, AuthTokenEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Call API
      final tokenModel = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );

      // 2. Save tokens in LocalDataSource (Token Manager)
      await _localDataSource.saveAccessToken(tokenModel.accessToken);
      
      if (tokenModel.refreshToken != null) {
        await _localDataSource.saveRefreshToken(tokenModel.refreshToken!);
      }

      if (tokenModel.expiresIn != null) {
        final expiryTime = DateTime.now().add(
          Duration(seconds: tokenModel.expiresIn!),
        );
        await _localDataSource.saveTokenExpiry(expiryTime);
      }

      return Right(tokenModel);
    } catch (e) {
      return Left(ServerFailure('Sign in failed: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _localDataSource.clearAllAuthData();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Logout failed: $e'));
    }
  }
}
```

## How to Use in Cubit

```dart
class AuthCubitV2 extends Cubit<AuthState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;

  Future<void> checkAuthOnAppStart() async {
    try {
      // Check if token exists and is valid
      final result = await _checkAuthStatusUseCase();

      result.fold(
        (failure) => emit(const AuthInitialState()),
        (isAuthenticated) {
          if (isAuthenticated) {
            emit(const AuthSuccessState(
              action: 'app_started_authenticated',
              data: {},
            ));
          } else {
            emit(const AuthInitialState());
          }
        },
      );
    } catch (e) {
      emit(AuthErrorState(message: 'Auth check failed'));
    }
  }
}
```

## Data Flow

```
┌─────────────────────────────────────────────────────┐
│                    API Response                      │
│         { accessToken, refreshToken, ... }          │
└────────────────────┬────────────────────────────────┘
                     │
                     ▼
        ┌────────────────────────────┐
        │  AuthRepositoryImpl         │
        │  - signIn()                │
        │  - signUp()                │
        │  - refreshToken()          │
        │  - logout()                │
        └────────────────────────────┘
                     │
                     ▼
    ┌─────────────────────────────────────────┐
    │     AuthLocalDataSource (Interface)     │
    │  - saveAccessToken()                    │
    │  - saveRefreshToken()                   │
    │  - saveTokenExpiry()                    │
    │  - getAccessToken()                     │
    │  - isTokenValid()                       │
    │  - getBearerToken()                     │
    └─────────────────────────────────────────┘
                     │
                     ▼
    ┌─────────────────────────────────────────┐
    │  AuthLocalDataSourceReal                │
    │  (Uses SharedPreferences)               │
    │                                         │
    │  Storage Keys:                          │
    │  - secure_auth_token                    │
    │  - secure_refresh_token                 │
    │  - secure_token_expiry                  │
    │  - secure_user_data                     │
    └─────────────────────────────────────────┘
                     │
                     ▼
          ┌──────────────────────┐
          │  SharedPreferences   │
          │  (Device Storage)    │
          └──────────────────────┘
```

## Common Patterns

### Check Token on App Start
```dart
Future<void> initializeAuth() async {
  try {
    final isValid = await _localDataSource.isTokenValid();
    
    if (!isValid) {
      // Try to refresh
      final refreshResult = await _authRepository.refreshAccessToken();
      // Handle result
    } else {
      // Token is valid, proceed normally
    }
  } catch (e) {
    // Token check failed, go to login
  }
}
```

### Get Token for API Requests
```dart
Future<void> makeAuthenticatedRequest() async {
  final bearerToken = await _localDataSource.getBearerToken();
  if (bearerToken != null) {
    // Use in headers: Authorization: Bearer token
    final response = await http.get(
      Uri.parse('https://api.example.com/user'),
      headers: {'Authorization': bearerToken},
    );
  }
}
```

### Refresh Token Before Expiry
```dart
Future<void> setupTokenRefresh() async {
  Timer.periodic(Duration(minutes: 1), (_) async {
    final expiringSoon = await _localDataSource.isTokenExpiringSoon();
    if (expiringSoon) {
      await _authRepository.refreshAccessToken();
    }
  });
}
```

## Testing

```dart
test('Token Management', () async {
  final mockDataSource = AuthLocalDataSourceMock();
  
  // Save token
  await mockDataSource.saveAccessToken('test_token_123');
  
  // Verify saved
  expect(await mockDataSource.hasToken(), isTrue);
  
  // Retrieve
  expect(
    await mockDataSource.getAccessToken(),
    equals('test_token_123'),
  );
  
  // Bearer format
  expect(
    await mockDataSource.getBearerToken(),
    equals('Bearer test_token_123'),
  );
  
  // Cleanup
  await mockDataSource.clearAllAuthData();
  expect(await mockDataSource.hasToken(), isFalse);
});
```

## No More Separate TokenManager!

✅ Token Manager is now **built into** `AuthLocalDataSource`  
✅ Uses same interface for Mock and Real implementations  
✅ Managed by SharedPreferences in production  
✅ Simple in-memory storage for tests  

## Next Steps

1. Update your AuthRepository to use the Token Manager methods
2. Update DI to provide AuthLocalDataSourceReal with SharedPreferences
3. Test token save/retrieve in your tests
4. Implement token refresh logic in Repository
5. Handle token expiry in Cubit
