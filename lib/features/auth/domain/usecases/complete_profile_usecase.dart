import 'package:fpdart/fpdart.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class CompleteProfileUseCase {
  final AuthRepository repository;

  CompleteProfileUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String phone,
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  }) async {
    if (name.isEmpty) {
      return Left(Failure('Name is required'));
    }
    if (email.isEmpty) {
      return Left(Failure('Email is required'));
    }
    if (gender.isEmpty) {
      return Left(Failure('Gender is required'));
    }
    return await repository.completeProfile(
      phone: phone,
      name: name,
      email: email,
      gender: gender,
      address: address,
      bio: bio,
    );
  }
}
