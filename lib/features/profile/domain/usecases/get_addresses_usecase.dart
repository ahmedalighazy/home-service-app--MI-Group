import '../entities/address_entity.dart';
import '../repositories/profile_repository.dart';

class GetAddressesUseCase {
  final ProfileRepository repository;

  GetAddressesUseCase(this.repository);

  Future<List<AddressEntity>> call() {
    return repository.getAddresses();
  }
}
