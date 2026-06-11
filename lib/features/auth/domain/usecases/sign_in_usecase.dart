import 'package:fpdart/fpdart.dart';
import '../entities/auth_token_entity.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, AuthTokenEntity>> call({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      return Left(Failure('Email is required'));
    }
    if (password.isEmpty) {
      return Left(Failure('Password is required'));
    }
    return await repository.signIn(email: email, password: password);
  }
}
