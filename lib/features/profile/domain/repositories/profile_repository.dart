import '../entities/address_entity.dart';
import '../entities/payment_method_entity.dart';
import '../entities/subscription_entity.dart';
import '../entities/visit_entity.dart';

abstract class ProfileRepository {
  // Address operations
  Future<List<AddressEntity>> getAddresses();
  Future<void> addAddress(AddressEntity address);
  Future<void> updateAddress(AddressEntity address);
  Future<void> deleteAddress(String addressId);
  Future<void> setDefaultAddress(String addressId);

  // Payment method operations
  Future<List<PaymentMethodEntity>> getPaymentMethods();
  Future<void> addPaymentMethod(PaymentMethodEntity paymentMethod);
  Future<void> deletePaymentMethod(String paymentMethodId);
  Future<void> setDefaultPaymentMethod(String paymentMethodId);

  // Subscription operations
  Future<List<SubscriptionEntity>> getSubscriptions();
  Future<SubscriptionEntity?> getSubscriptionById(String subscriptionId);
  Future<void> cancelSubscription(String subscriptionId);

  // Visit operations
  Future<List<VisitEntity>> getVisits();
  Future<VisitEntity?> getVisitById(String visitId);

  // User profile operations
  Future<void> updateProfile(Map<String, dynamic> profileData);
  Future<void> deleteAccount();
}
