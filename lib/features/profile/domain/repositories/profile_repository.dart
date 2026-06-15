import '../entities/address_entity.dart';
import '../entities/payment_method_entity.dart';
import '../entities/subscription_entity.dart';
import '../entities/visit_entity.dart';

abstract class ProfileRepository {

  Future<List<AddressEntity>> getAddresses();
  Future<void> addAddress(AddressEntity address);
  Future<void> updateAddress(AddressEntity address);
  Future<void> deleteAddress(String addressId);
  Future<void> setDefaultAddress(String addressId);

  Future<List<PaymentMethodEntity>> getPaymentMethods();
  Future<void> addPaymentMethod(PaymentMethodEntity paymentMethod);
  Future<void> deletePaymentMethod(String paymentMethodId);
  Future<void> setDefaultPaymentMethod(String paymentMethodId);

  Future<List<SubscriptionEntity>> getSubscriptions();
  Future<SubscriptionEntity?> getSubscriptionById(String subscriptionId);
  Future<void> cancelSubscription(String subscriptionId);

  Future<List<VisitEntity>> getVisits();
  Future<VisitEntity?> getVisitById(String visitId);

  Future<void> updateProfile(Map<String, dynamic> profileData);
  Future<void> deleteAccount();
}
