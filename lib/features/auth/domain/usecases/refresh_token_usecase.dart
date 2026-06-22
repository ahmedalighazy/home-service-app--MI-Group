import 'package:fpdart/fpdart.dart';
import '../entities/auth_token_entity.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<Either<Failure, AuthTokenEntity>> call({
    required String refreshToken,
  }) async {
    if (refreshToken.isEmpty) {
      return Left(Failure('Refresh token is required'));
    }
    return await repository.refreshToken(refreshToken: refreshToken);
  }
}
