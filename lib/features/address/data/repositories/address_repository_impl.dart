import '../../domain/repositories/address_repository.dart';
import '../datasources/address_remote_datasource.dart';
import '../datasources/address_local_datasource.dart';
import '../../../profile/domain/entities/address_entity.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;
  final AddressLocalDataSource localDataSource;

  AddressRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<AddressEntity>> getAddresses() async {
    try {
      final addressModels = await remoteDataSource.getAddresses();
      await localDataSource.cacheAddresses(addressModels);
      return addressModels.map((model) => _toAddressEntity(model)).toList();
    } catch (e) {
      final cached = await localDataSource.getCachedAddresses();
      if (cached != null) {
        return cached.map((model) => _toAddressEntity(model)).toList();
      }
      rethrow;
    }
  }

  @override
  Future<void> addAddress(AddressEntity address) async {
    final model = _toAddressModel(address);
    await remoteDataSource.addAddress(model);
  }

  @override
  Future<void> updateAddress(AddressEntity address) async {
    final model = _toAddressModel(address);
    await remoteDataSource.updateAddress(model);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await remoteDataSource.deleteAddress(addressId);
  }

  @override
  Future<void> selectAddress(String addressId) async {
    await remoteDataSource.selectAddress(addressId);
  }

  // Mapping methods
  AddressEntity _toAddressEntity(dynamic model) {
    return AddressEntity(
      id: model.id ?? '',
      label: model.title ?? '',
      details: model.address ?? '',
      isDefault: model.isSelected ?? false,
      iconPath: model.iconPath ?? '',
    );
  }

  dynamic _toAddressModel(AddressEntity entity) {
    return {
      'id': entity.id,
      'title': entity.label,
      'address': entity.details,
      'isSelected': entity.isDefault,
      'iconPath': entity.iconPath,
    };
  }
}
