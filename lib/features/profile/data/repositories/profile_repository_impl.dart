import 'dart:io';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_service.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/change_password_responses.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService _apiService;

  ProfileRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      return Right(response.toEntity());
    } catch (e) {
      final apiError = ErrorHandler.handle(e);
      return Left(ServerFailure(apiError.message ?? 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    String? name,
    String? phone,
    String? bio,
    File? profileImage,
  }) async {
    try {
      final Map<String, dynamic> body = {};
      if (name != null) body['name'] = name;
      if (phone != null) body['phone'] = phone;
      if (bio != null) body['bio'] = bio;

      // Note: profileImage is not implemented in ApiService updateProfile yet.
      // Ignoring profileImage mapping for now to match old behavior.

      final response = await _apiService.updateProfile(body);
      return Right(response.toEntity());
    } catch (e) {
      final apiError = ErrorHandler.handle(e);
      return Left(ServerFailure(apiError.message ?? 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _apiService.changePassword(
        ChangePasswordResponses(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );
      return const Right(null);
    } catch (e) {
      final apiError = ErrorHandler.handle(e);
      return Left(ServerFailure(apiError.message ?? 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await _apiService.deleteAccount();
      return const Right(null);
    } catch (e) {
      final apiError = ErrorHandler.handle(e);
      return Left(ServerFailure(apiError.message ?? 'Unknown error occurred'));
    }
  }
}
