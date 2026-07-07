import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../repositories/address_repository.dart';

class DeleteAddressUseCase {
  final AddressRepository _repository;

  DeleteAddressUseCase(this._repository);

  Future<Either<Failure, void>> call(String id) {
    return _repository.deleteAddress(id);
  }
}

