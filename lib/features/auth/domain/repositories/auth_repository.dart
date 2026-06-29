import 'package:fpdart/fpdart.dart';
import 'package:home_service_app/features/auth/domain/entities/login_response_entity.dart';
import '../entities/user_entity.dart';
import '../entities/auth_token_entity.dart';

/// Auth Repository Interface - Domain Layer
///
/// Abstract interface for authentication operations
/// Implementation is in data layer
abstract class AuthRepository {
  /// Sign in with email and password
  Future<Either<Failure, LoginResponseEntity>> signIn({
    required String identifier,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<Failure, AuthTokenEntity>> signUp({
    required String email,
    required String password,
  });

  /// Sign up with phone number (send OTP)
  Future<Either<Failure, void>> sendOtpToPhone({required String phone});

  /// Verify OTP code
  Future<Either<Failure, AuthTokenEntity>> verifyOtp({
    required String phone,
    required String otp,
  });

  /// Complete user profile after sign up
  Future<Either<Failure, UserEntity>> completeProfile({
    required String phone,
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  });

  /// Request password reset (send code to email)
  Future<Either<Failure, void>> requestPasswordReset({required String email});

  /// Verify reset code
  Future<Either<Failure, void>> verifyResetCode({
    required String email,
    required String code,
  });

  /// Reset password with new password
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String newPassword,
  });

  /// Sign in with Google
  Future<Either<Failure, AuthTokenEntity>> signInWithGoogle({String? idToken});

  /// Sign in with Apple
  Future<Either<Failure, AuthTokenEntity>> signInWithApple({
    String? identityToken,
  });

  /// Get current user profile
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Refresh access token using refresh token
  Future<Either<Failure, AuthTokenEntity>> refreshToken({
    required String refreshToken,
  });

  /// Sign out
  Future<Either<Failure, void>> signOut();

  /// Check if user is logged in
  Future<bool> isUserLoggedIn();

  /// Get cached user if available
  UserEntity? getCachedUser();

  /// Get cached token if available
  AuthTokenEntity? getCachedToken();
}

/// Failure class for error handling
class Failure {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}
