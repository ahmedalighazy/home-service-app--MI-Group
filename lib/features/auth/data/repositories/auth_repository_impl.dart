import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/auth_token_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import '../models/auth_token_model.dart';

/// Auth Repository Implementation - Data Layer
/// 
/// Implements abstract AuthRepository
/// Coordinates between remote and local data sources
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, AuthTokenEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      
      final tokenModel = AuthTokenModel.fromJson(response);
      
      // Save token to local storage
      await _localDataSource.saveToken(tokenModel);
      
      // Convert model to entity
      final tokenEntity = AuthTokenEntity(
        accessToken: tokenModel.accessToken,
        refreshToken: tokenModel.refreshToken,
        expiresAt: tokenModel.expiresAt,
        tokenType: tokenModel.tokenType,
      );
      
      return Right(tokenEntity);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, void>> sendOtpToPhone({
    required String phone,
  }) async {
    try {
      await _remoteDataSource.sendOtpToPhone(phone: phone);
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await _remoteDataSource.verifyOtp(
        phone: phone,
        otp: otp,
      );
      
      final tokenModel = AuthTokenModel.fromJson(response);
      
      // Save token to local storage
      await _localDataSource.saveToken(tokenModel);
      
      // Convert model to entity
      final tokenEntity = AuthTokenEntity(
        accessToken: tokenModel.accessToken,
        refreshToken: tokenModel.refreshToken,
        expiresAt: tokenModel.expiresAt,
        tokenType: tokenModel.tokenType,
      );
      
      return Right(tokenEntity);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> completeProfile({
    required String phone,
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  }) async {
    try {
      final response = await _remoteDataSource.completeProfile(
        phone: phone,
        name: name,
        email: email,
        gender: gender,
        address: address,
        bio: bio,
      );
      
      final userModel = UserModel.fromJson(response);
      
      // Save user to local storage
      await _localDataSource.saveUser(userModel);
      
      // Convert model to entity
      final userEntity = UserEntity(
        id: userModel.id,
        email: userModel.email,
        phone: userModel.phone,
        name: userModel.name,
        profileImage: userModel.profileImage,
        gender: userModel.gender,
        createdAt: userModel.createdAt,
        emailVerified: userModel.emailVerified,
        phoneVerified: userModel.phoneVerified,
      );
      
      return Right(userEntity);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, void>> requestPasswordReset({
    required String email,
  }) async {
    try {
      await _remoteDataSource.requestPasswordReset(email: email);
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, void>> verifyResetCode({
    required String email,
    required String code,
  }) async {
    try {
      await _remoteDataSource.verifyResetCode(
        email: email,
        code: code,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.resetPassword(
        email: email,
        newPassword: newPassword,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> signInWithGoogle({
    String? idToken,
  }) async {
    try {
      if (idToken == null) {
        return Left(Failure('Google ID token is required'));
      }
      final response = await _remoteDataSource.signInWithGoogle(
        idToken: idToken,
      );
      
      final tokenModel = AuthTokenModel.fromJson(response);
      
      // Save token to local storage
      await _localDataSource.saveToken(tokenModel);
      
      // Convert model to entity
      final tokenEntity = AuthTokenEntity(
        accessToken: tokenModel.accessToken,
        refreshToken: tokenModel.refreshToken,
        expiresAt: tokenModel.expiresAt,
        tokenType: tokenModel.tokenType,
      );
      
      return Right(tokenEntity);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> signInWithApple({
    String? identityToken,
  }) async {
    try {
      if (identityToken == null) {
        return Left(Failure('Apple identity token is required'));
      }
      final response = await _remoteDataSource.signInWithApple(
        identityToken: identityToken,
      );
      
      final tokenModel = AuthTokenModel.fromJson(response);
      
      // Save token to local storage
      await _localDataSource.saveToken(tokenModel);
      
      // Convert model to entity
      final tokenEntity = AuthTokenEntity(
        accessToken: tokenModel.accessToken,
        refreshToken: tokenModel.refreshToken,
        expiresAt: tokenModel.expiresAt,
        tokenType: tokenModel.tokenType,
      );
      
      return Right(tokenEntity);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final response = await _remoteDataSource.getCurrentUser();
      
      final userModel = UserModel.fromJson(response);
      
      // Save user to local storage
      await _localDataSource.saveUser(userModel);
      
      // Convert model to entity
      final userEntity = UserEntity(
        id: userModel.id,
        email: userModel.email,
        phone: userModel.phone,
        name: userModel.name,
        profileImage: userModel.profileImage,
        gender: userModel.gender,
        createdAt: userModel.createdAt,
        emailVerified: userModel.emailVerified,
        phoneVerified: userModel.phoneVerified,
      );
      
      return Right(userEntity);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await _remoteDataSource.refreshToken(
        refreshToken: refreshToken,
      );
      
      final tokenModel = AuthTokenModel.fromJson(response);
      
      // Save new token to local storage
      await _localDataSource.saveToken(tokenModel);
      
      // Convert model to entity
      final tokenEntity = AuthTokenEntity(
        accessToken: tokenModel.accessToken,
        refreshToken: tokenModel.refreshToken,
        expiresAt: tokenModel.expiresAt,
        tokenType: tokenModel.tokenType,
      );
      
      return Right(tokenEntity);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      await _localDataSource.clearAllAuthData();
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(_handleException(e)));
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return await _localDataSource.isUserLoggedIn();
  }

  @override
  UserEntity? getCachedUser() {
    // Implement getting cached user from local storage
    // This would need to be async, but we're keeping it sync for now
    return null;
  }

  @override
  AuthTokenEntity? getCachedToken() {
    // Implement getting cached token from local storage
    // This would need to be async, but we're keeping it sync for now
    return null;
  }

  /// Handle different types of exceptions and return appropriate error messages
  String _handleException(Exception e) {
    if (e is NetworkException) {
      return 'خطأ في الاتصال بالإنترنت';
    } else if (e is ServerException) {
      return 'خطأ في الخادم، حاول لاحقاً';
    } else if (e is UnauthorizedException) {
      return 'بيانات دخول غير صحيحة';
    } else if (e is ValidationException) {
      return e.message;
    } else {
      return 'حدث خطأ ما، يرجى المحاولة مرة أخرى';
    }
  }
}

// Custom Exception Classes
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}
