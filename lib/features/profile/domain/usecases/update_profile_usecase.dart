import 'dart:io';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> call({
    String? name,
    String? phone,
    String? bio,
    File? profileImage,
  }) {
    return _repository.updateProfile(
      name: name,
      phone: phone,
      bio: bio,
      profileImage: profileImage,
    );
  }
}
