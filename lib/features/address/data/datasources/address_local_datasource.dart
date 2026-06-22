import '../models/address_model.dart';

abstract class AddressLocalDataSource {
  Future<void> cacheAddresses(List<AddressModel> addresses);
  Future<List<AddressModel>?> getCachedAddresses();
  Future<void> clearCache();
}
