import '../models/address_model.dart';
import '../models/payment_method_model.dart';
import '../models/subscription_model.dart';
import '../models/visit_model.dart';

abstract class ProfileRemoteDataSource {

  Future<List<AddressModel>> getAddresses();
  Future<void> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
  Future<void> deleteAddress(String addressId);
  Future<void> setDefaultAddress(String addressId);

  Future<List<PaymentMethodModel>> getPaymentMethods();
  Future<void> addPaymentMethod(PaymentMethodModel paymentMethod);
  Future<void> deletePaymentMethod(String paymentMethodId);
  Future<void> setDefaultPaymentMethod(String paymentMethodId);

  Future<List<SubscriptionModel>> getSubscriptions();
  Future<SubscriptionModel?> getSubscriptionById(String subscriptionId);
  Future<void> cancelSubscription(String subscriptionId);

  Future<List<VisitModel>> getVisits();
  Future<VisitModel?> getVisitById(String visitId);

  Future<void> updateProfile(Map<String, dynamic> profileData);
  Future<void> deleteAccount();
}
