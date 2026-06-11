import 'package:fpdart/fpdart.dart';
import '../repositories/auth_repository.dart';

class RequestPasswordResetUseCase {
  final AuthRepository repository;

  RequestPasswordResetUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
  }) async {
    if (email.isEmpty) {
      return Left(Failure('Email is required'));
    }
    return await repository.requestPasswordReset(email: email);
  }
}
