import 'package:fpdart/fpdart.dart';

import '../entities/login_response_entity.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, LoginResponseEntity>> call({
    required String identifier,
    required String password,
  }) async {
    if (identifier.trim().isEmpty) {
      return Left(Failure('Identifier is required'));
    }

    if (password.trim().isEmpty) {
      return Left(Failure('Password is required'));
    }

    return repository.signIn(identifier: identifier, password: password);
  }
}
