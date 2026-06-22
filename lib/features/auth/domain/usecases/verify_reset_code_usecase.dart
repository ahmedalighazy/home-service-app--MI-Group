import 'package:fpdart/fpdart.dart';
import '../repositories/auth_repository.dart';

class VerifyResetCodeUseCase {
  final AuthRepository repository;

  VerifyResetCodeUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String code,
  }) async {
    if (email.isEmpty) {
      return Left(Failure('Email is required'));
    }
    if (code.isEmpty) {
      return Left(Failure('Code is required'));
    }
    return await repository.verifyResetCode(email: email, code: code);
  }
}
