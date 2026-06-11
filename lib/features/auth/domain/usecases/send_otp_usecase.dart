import 'package:fpdart/fpdart.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String phone,
  }) async {
    if (phone.isEmpty) {
      return Left(Failure('Phone number is required'));
    }
    return await repository.sendOtpToPhone(phone: phone);
  }
}
