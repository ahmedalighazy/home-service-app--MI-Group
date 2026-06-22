import '../models/address_model.dart';
import '../models/payment_method_model.dart';
import '../models/subscription_model.dart';
import '../models/visit_model.dart';

abstract class ProfileLocalDataSource {

  Future<void> cacheAddresses(List<AddressModel> addresses);
  Future<List<AddressModel>?> getCachedAddresses();

  Future<void> cachePaymentMethods(List<PaymentMethodModel> paymentMethods);
  Future<List<PaymentMethodModel>?> getCachedPaymentMethods();

  Future<void> cacheSubscriptions(List<SubscriptionModel> subscriptions);
  Future<List<SubscriptionModel>?> getCachedSubscriptions();

  Future<void> cacheVisits(List<VisitModel> visits);
  Future<List<VisitModel>?> getCachedVisits();

  Future<void> cacheUserProfile(Map<String, dynamic> profileData);
  Future<Map<String, dynamic>?> getCachedUserProfile();

  Future<void> clearCache();
}
