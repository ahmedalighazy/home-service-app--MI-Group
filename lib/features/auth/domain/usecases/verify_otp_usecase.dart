import 'package:fpdart/fpdart.dart';
import '../entities/auth_token_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, AuthTokenEntity>> call({
    required String phone,
    required String otp,
  }) async {
    if (phone.isEmpty) {
      return Left(Failure('Phone number is required'));
    }
    if (otp.isEmpty) {
      return Left(Failure('OTP is required'));
    }
    return await repository.verifyOtp(phone: phone, otp: otp);
  }
}
