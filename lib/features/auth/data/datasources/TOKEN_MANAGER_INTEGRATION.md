# Token Manager Integration Guide

## Overview

The Token Manager has been integrated directly into the `AuthLocalDataSource` interface and implementations. This provides a centralized, secure way to manage access tokens, refresh tokens, token expiry, and user data.

## Architecture

```
AuthLocalDataSource (Interface)
├── Traditional Methods: saveUser, getUser, deleteUser, etc.
└── Token Manager Methods: saveAccessToken, getAccessToken, isTokenValid, etc.

AuthLocalDataSourceReal (SharedPreferences Implementation)
├── Uses SharedPreferences for persistence
├── Handles token expiry timestamps
├── Provides bearer token support
└── Auto-expires tokens when necessary

AuthLocalDataSourceMock (In-Memory Implementation)
├── Uses Map for testing
├── Same interface as Real implementation
└── Useful for unit tests
```

## Token Manager Methods

All these methods are now available in `AuthLocalDataSource`:

### Saving Tokens

```dart
/// Save access token
await localDataSource.saveAccessToken('your_access_token');

/// Save refresh token
await localDataSource.saveRefreshToken('your_refresh_token');

/// Save token expiry time
await localDataSource.saveTokenExpiry(
  DateTime.now().add(Duration(hours: 1))
);

/// Save user data as JSON
await localDataSource.saveUserData({
  'userId': '123',
  'email': 'user@example.com',
  'name': 'John Doe',
});
```

### Retrieving Tokens

```dart
/// Get access token
final token = await localDataSource.getAccessToken(); // 'your_access_token'

/// Get refresh token
final refreshToken = await localDataSource.getRefreshToken();

/// Get bearer token (with "Bearer " prefix)
final bearerToken = await localDataSource.getBearerToken(); // 'Bearer your_access_token'

/// Get user data
final userData = await localDataSource.getUserData();
```

### Token Validation

```dart
/// Check if token exists
final hasToken = await localDataSource.hasToken();

/// Check if token is valid (not expired)
final isValid = await localDataSource.isTokenValid();

/// Get time remaining until expiry
final timeLeft = await localDataSource.getTimeUntilExpiry();
if (timeLeft != null) {
  print('Token expires in ${timeLeft.inMinutes} minutes');
}

/// Check if token is expiring soon (within 60 seconds)
final expiringSoon = await localDataSource.isTokenExpiringSoon();
if (expiringSoon) {
  // Refresh token before it expires
  await refreshAccessToken();
}
```

### Cleanup

```dart
/// Delete only tokens (keeps user data)
await localDataSource.deleteToken();
await localDataSource.deleteAccessToken();
await localDataSource.deleteRefreshToken();

/// Clear all auth data (tokens + user)
await localDataSource.clearAllAuthData();
```

## Usage in Repository

### Example: Sign In with Token Management

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
      // Call API
      final tokenModel = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );

      // Save access token
      await _localDataSource.saveAccessToken(tokenModel.accessToken);

      // Save refresh token if provided
      if (tokenModel.refreshToken != null) {
        await _localDataSource.saveRefreshToken(tokenModel.refreshToken!);
      }

      // Save token expiry
      if (tokenModel.expiresIn != null) {
        final expiryTime = DateTime.now().add(
          Duration(seconds: tokenModel.expiresIn!),
        );
        await _localDataSource.saveTokenExpiry(expiryTime);
      }

      // Also save the full token model (for backward compatibility)
      await _localDataSource.saveToken(tokenModel);

      return Right(tokenModel);
    } catch (e) {
      return Left(ServerFailure('Sign in failed'));
    }
  }
}
```

### Example: Complete Profile with Token

```dart
@override
Future<Either<Failure, UserEntity>> completeProfile({
  required String name,
  required String email,
  required String gender,
}) async {
  try {
    // Get token from local storage
    final token = await _localDataSource.getAccessToken();
    if (token == null) {
      return Left(ServerFailure('No token available'));
    }

    // Make API call with token
    final userModel = await _remoteDataSource.completeProfile(
      token: token,
      name: name,
      email: email,
      gender: gender,
    );

    // Save user data
    await _localDataSource.saveUser(userModel);

    return Right(userModel);
  } catch (e) {
    return Left(ServerFailure('Profile completion failed'));
  }
}
```

### Example: Token Refresh

```dart
Future<Either<Failure, AuthTokenEntity>> refreshAccessToken() async {
  try {
    // Get refresh token
    final refreshToken = await _localDataSource.getRefreshToken();
    if (refreshToken == null) {
      return Left(ServerFailure('No refresh token available'));
    }

    // Call API to refresh
    final newTokenModel = await _remoteDataSource.refreshToken(
      refreshToken: refreshToken,
    );

    // Save new access token
    await _localDataSource.saveAccessToken(newTokenModel.accessToken);

    // Update expiry
    if (newTokenModel.expiresIn != null) {
      final expiryTime = DateTime.now().add(
        Duration(seconds: newTokenModel.expiresIn!),
      );
      await _localDataSource.saveTokenExpiry(expiryTime);
    }

    return Right(newTokenModel);
  } catch (e) {
    return Left(ServerFailure('Token refresh failed'));
  }
}
```

### Example: Logout

```dart
Future<Either<Failure, void>> logout() async {
  try {
    // Call logout API
    await _remoteDataSource.logout();

    // Clear all auth data locally
    await _localDataSource.clearAllAuthData();

    return const Right(null);
  } catch (e) {
    return Left(ServerFailure('Logout failed'));
  }
}
```

## Usage in Cubit

### Example: Check Authentication Status

```dart
class AuthCubitV2 extends Cubit<AuthState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final AuthRepository _authRepository;

  Future<void> checkAuthStatus() async {
    emit(const AuthLoadingState());

    try {
      // Get token from local storage
      final hasToken = await _authRepository
          .getLocalDataSource() // You might need to expose this
          .hasToken();

      if (!hasToken) {
        emit(const AuthInitialState());
        return;
      }

      // Check if token is valid
      final isValid = await _authRepository
          .getLocalDataSource()
          .isTokenValid();

      if (!isValid) {
        // Try to refresh token
        final refreshResult = await _authRepository.refreshAccessToken();
        
        refreshResult.fold(
          (failure) => emit(const AuthInitialState()),
          (token) => emit(
            AuthSuccessState(
              action: 'authentication_restored',
              data: {'token': token.accessToken},
            ),
          ),
        );
        return;
      }

      // Token is valid, emit success
      emit(const AuthSuccessState(
        action: 'authentication_valid',
        data: {},
      ));
    } catch (e) {
      emit(AuthErrorState(message: 'Failed to check auth status'));
    }
  }
}
```

### Example: Handle Token Expiry

```dart
void _setupTokenExpiryListener() {
  // Check token expiry every minute
  Timer.periodic(Duration(minutes: 1), (timer) async {
    try {
      final expiringSoon = await _localDataSource.isTokenExpiringSoon();
      
      if (expiringSoon) {
        // Token expiring soon, refresh it
        final result = await _refreshAccessTokenUseCase();
        
        result.fold(
          (failure) => emit(AuthErrorState(message: 'Token refresh failed')),
          (token) {
            // Token refreshed successfully
            // No need to emit, just update in local storage
          },
        );
      }
    } catch (e) {
      // Handle error silently or emit if critical
    }
  });
}
```

## Key Storage Keys (Internal)

If you need to debug or understand what's stored:

- `secure_auth_token` - Access token
- `secure_refresh_token` - Refresh token
- `secure_token_expiry` - Token expiry timestamp (ISO8601)
- `secure_user_data` - User data as JSON
- `auth_user` - Full UserModel JSON (optional backup)
- `auth_token` - Full AuthTokenModel JSON (optional backup)

## Error Handling

```dart
try {
  final token = await localDataSource.getAccessToken();
} on AuthLocalDataSourceException catch (e) {
  print('Error: ${e.message}');
  // Handle Token Manager specific errors
} catch (e) {
  print('Unexpected error: $e');
}
```

## Testing with Mock

```dart
void main() {
  late AuthLocalDataSourceMock mockDataSource;

  setUp(() {
    mockDataSource = AuthLocalDataSourceMock();
  });

  test('Save and retrieve access token', () async {
    // Arrange
    const token = 'test_token_12345';

    // Act
    await mockDataSource.saveAccessToken(token);
    final retrievedToken = await mockDataSource.getAccessToken();

    // Assert
    expect(retrievedToken, equals(token));
  });

  test('Bearer token includes Bearer prefix', () async {
    // Arrange
    const token = 'test_token';
    await mockDataSource.saveAccessToken(token);

    // Act
    final bearerToken = await mockDataSource.getBearerToken();

    // Assert
    expect(bearerToken, equals('Bearer test_token'));
  });

  test('Token validation with expiry', () async {
    // Arrange
    await mockDataSource.saveAccessToken('test_token');
    final expiryTime = DateTime.now().add(Duration(hours: 1));
    await mockDataSource.saveTokenExpiry(expiryTime);

    // Act
    final isValid = await mockDataSource.isTokenValid();

    // Assert
    expect(isValid, isTrue);
  });

  test('Token validation fails when expired', () async {
    // Arrange
    await mockDataSource.saveAccessToken('test_token');
    final expiryTime = DateTime.now().subtract(Duration(hours: 1));
    await mockDataSource.saveTokenExpiry(expiryTime);

    // Act
    final isValid = await mockDataSource.isTokenValid();

    // Assert
    expect(isValid, isFalse);
  });
}
```

## Next Steps

1. Update your Repository to use Token Manager methods
2. Wire AuthLocalDataSource into your dependency injection (DI)
3. Update Cubit to check token validity on app startup
4. Implement token refresh logic using Timer or interceptor
5. Add unit tests for token management

## Files Modified

- `lib/features/auth/data/datasources/auth_local_datasource.dart` - Added Token Manager interface
- `lib/features/auth/data/datasources/auth_local_datasource_real.dart` - Added Token Manager implementation
- `lib/features/auth/data/datasources/auth_local_datasource_impl.dart` - Added Token Manager mock
