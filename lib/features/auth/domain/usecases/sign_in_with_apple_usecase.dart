import 'package:fpdart/fpdart.dart';
import '../entities/auth_token_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithAppleUseCase {
  final AuthRepository repository;

  SignInWithAppleUseCase(this.repository);

  Future<Either<Failure, AuthTokenEntity>> call({
    String? identityToken,
  }) async {
    return await repository.signInWithApple(identityToken: identityToken);
  }
}
