import '../../domain/entities/address_entity.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/entities/visit_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../datasources/profile_local_datasource.dart';
import '../models/address_model.dart';
import '../models/payment_method_model.dart';
import '../models/subscription_model.dart' as sub_model;
import '../models/visit_model.dart' as visit_model;

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({
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
  Future<void> setDefaultAddress(String addressId) async {
    await remoteDataSource.setDefaultAddress(addressId);
  }

  @override
  Future<List<PaymentMethodEntity>> getPaymentMethods() async {
    try {
      final paymentMethodModels = await remoteDataSource.getPaymentMethods();
      await localDataSource.cachePaymentMethods(paymentMethodModels);
      return paymentMethodModels.map((model) => _toPaymentMethodEntity(model)).toList();
    } catch (e) {
      final cached = await localDataSource.getCachedPaymentMethods();
      if (cached != null) {
        return cached.map((model) => _toPaymentMethodEntity(model)).toList();
      }
      rethrow;
    }
  }

  @override
  Future<void> addPaymentMethod(PaymentMethodEntity paymentMethod) async {
    final model = _toPaymentMethodModel(paymentMethod);
    await remoteDataSource.addPaymentMethod(model);
  }

  @override
  Future<void> deletePaymentMethod(String paymentMethodId) async {
    await remoteDataSource.deletePaymentMethod(paymentMethodId);
  }

  @override
  Future<void> setDefaultPaymentMethod(String paymentMethodId) async {
    await remoteDataSource.setDefaultPaymentMethod(paymentMethodId);
  }

  @override
  Future<List<SubscriptionEntity>> getSubscriptions() async {
    try {
      final subscriptionModels = await remoteDataSource.getSubscriptions();
      await localDataSource.cacheSubscriptions(subscriptionModels);
      return subscriptionModels.map((model) => _toSubscriptionEntity(model)).toList();
    } catch (e) {
      final cached = await localDataSource.getCachedSubscriptions();
      if (cached != null) {
        return cached.map((model) => _toSubscriptionEntity(model)).toList();
      }
      rethrow;
    }
  }

  @override
  Future<SubscriptionEntity?> getSubscriptionById(String subscriptionId) async {
    final model = await remoteDataSource.getSubscriptionById(subscriptionId);
    return model != null ? _toSubscriptionEntity(model) : null;
  }

  @override
  Future<void> cancelSubscription(String subscriptionId) async {
    await remoteDataSource.cancelSubscription(subscriptionId);
  }

  @override
  Future<List<VisitEntity>> getVisits() async {
    try {
      final visitModels = await remoteDataSource.getVisits();
      await localDataSource.cacheVisits(visitModels);
      return visitModels.map((model) => _toVisitEntity(model)).toList();
    } catch (e) {
      final cached = await localDataSource.getCachedVisits();
      if (cached != null) {
        return cached.map((model) => _toVisitEntity(model)).toList();
      }
      rethrow;
    }
  }

  @override
  Future<VisitEntity?> getVisitById(String visitId) async {
    final model = await remoteDataSource.getVisitById(visitId);
    return model != null ? _toVisitEntity(model) : null;
  }

  @override
  Future<void> updateProfile(Map<String, dynamic> profileData) async {
    await remoteDataSource.updateProfile(profileData);
    await localDataSource.cacheUserProfile(profileData);
  }

  @override
  Future<void> deleteAccount() async {
    await remoteDataSource.deleteAccount();
    await localDataSource.clearCache();
  }

  AddressEntity _toAddressEntity(AddressModel model) {
    return AddressEntity(
      id: model.id ?? '',
      label: model.title ?? '',
      details: model.address ?? '',
      isDefault: model.isSelected ?? false,
      iconPath: model.iconPath ?? '',
    );
  }

  AddressModel _toAddressModel(AddressEntity entity) {
    return AddressModel(
      id: entity.id,
      title: entity.label,
      address: entity.details,
      isSelected: entity.isDefault,
      iconPath: entity.iconPath,
    );
  }

  PaymentMethodEntity _toPaymentMethodEntity(PaymentMethodModel model) {
    return PaymentMethodEntity(
      id: model.id,
      cardHolderName: '',
      lastFourDigits: model.lastFourDigits,
      expiryDate: '',
      brand: model.type,
      isDefault: model.isDefault,
      iconPath: '',
    );
  }

  PaymentMethodModel _toPaymentMethodModel(PaymentMethodEntity entity) {
    return PaymentMethodModel(
      id: entity.id,
      type: entity.brand,
      lastFourDigits: entity.lastFourDigits,
      isDefault: entity.isDefault,
    );
  }

  SubscriptionEntity _toSubscriptionEntity(sub_model.SubscriptionModel model) {
    return SubscriptionEntity(
      id: model.id,
      title: model.planName,
      type: 'Monthly',
      nextVisitDate: model.startDate.toIso8601String().split('T')[0],
      nextVisitTime: '10:00 AM',
      expiryDate: model.endDate?.toIso8601String().split('T')[0],
      price: 0.0,
      status: _parseSubscriptionStatus(model.status),
    );
  }

  SubscriptionStatus _parseSubscriptionStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return SubscriptionStatus.active;
      case 'paused':
        return SubscriptionStatus.paused;
      case 'ended':
      case 'cancelled':
        return SubscriptionStatus.ended;
      default:
        return SubscriptionStatus.active;
    }
  }

  VisitEntity _toVisitEntity(visit_model.VisitModel model) {
    return VisitEntity(
      id: model.id,
      date: "${model.date.year}-${model.date.month.toString().padLeft(2, '0')}-${model.date.day.toString().padLeft(2, '0')}",
      time: "${model.date.hour.toString().padLeft(2, '0')}:${model.date.minute.toString().padLeft(2, '0')}",
      status: _parseVisitStatus(model.status),
    );
  }

  VisitStatus _parseVisitStatus(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
      case 'pending':
        return VisitStatus.scheduled;
      case 'inprogress':
      case 'in_progress':
        return VisitStatus.inProgress;
      case 'completed':
      case 'finished':
        return VisitStatus.completed;
      default:
        return VisitStatus.scheduled;
    }
  }
}
