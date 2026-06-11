import '../../domain/entities/address_entity.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/entities/visit_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profileData;
  
  ProfileLoaded(this.profileData);
}

class ProfileError extends ProfileState {
  final String message;
  
  ProfileError(this.message);
}

// Address States
class AddressesLoading extends ProfileState {}

class AddressesLoaded extends ProfileState {
  final List<AddressEntity> addresses;
  
  AddressesLoaded(this.addresses);
}

class AddressesError extends ProfileState {
  final String message;
  
  AddressesError(this.message);
}

// Payment Methods States
class PaymentMethodsLoading extends ProfileState {}

class PaymentMethodsLoaded extends ProfileState {
  final List<PaymentMethodEntity> paymentMethods;
  
  PaymentMethodsLoaded(this.paymentMethods);
}

class PaymentMethodsError extends ProfileState {
  final String message;
  
  PaymentMethodsError(this.message);
}

// Subscriptions States
class SubscriptionsLoading extends ProfileState {}

class SubscriptionsLoaded extends ProfileState {
  final List<SubscriptionEntity> subscriptions;
  
  SubscriptionsLoaded(this.subscriptions);
}

class SubscriptionsError extends ProfileState {
  final String message;
  
  SubscriptionsError(this.message);
}

// Visits States
class VisitsLoading extends ProfileState {}

class VisitsLoaded extends ProfileState {
  final List<VisitEntity> visits;
  
  VisitsLoaded(this.visits);
}

class VisitsError extends ProfileState {
  final String message;
  
  VisitsError(this.message);
}
