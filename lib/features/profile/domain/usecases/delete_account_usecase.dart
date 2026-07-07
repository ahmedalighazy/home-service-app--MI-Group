import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class DeleteAccountUseCase {
  final ProfileRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<Either<Failure, void>> call() {
    return _repository.deleteAccount();
  }
}
