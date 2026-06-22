import 'package:fpdart/fpdart.dart';
import '../entities/auth_token_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  Future<Either<Failure, AuthTokenEntity>> call({
    String? idToken,
  }) async {
    return await repository.signInWithGoogle(idToken: idToken);
  }
}
