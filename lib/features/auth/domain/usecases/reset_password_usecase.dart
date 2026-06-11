import 'package:fpdart/fpdart.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String newPassword,
  }) async {
    if (email.isEmpty) {
      return Left(Failure('Email is required'));
    }
    if (newPassword.isEmpty) {
      return Left(Failure('New password is required'));
    }
    return await repository.resetPassword(email: email, newPassword: newPassword);
  }
}
