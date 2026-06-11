import '../../domain/entities/service_page_entity.dart';
import '../../domain/entities/time_slot_entity.dart';

abstract class ServiceDetailsState {}

class ServiceDetailsInitial extends ServiceDetailsState {}

class ServiceDetailsLoading extends ServiceDetailsState {}

class ServiceDetailsLoaded extends ServiceDetailsState {
  final ServicePageEntity servicePage;
  
  ServiceDetailsLoaded(this.servicePage);
}

class ServiceDetailsError extends ServiceDetailsState {
  final String message;
  
  ServiceDetailsError(this.message);
}

class TimeSlotsLoading extends ServiceDetailsState {}

class TimeSlotsLoaded extends ServiceDetailsState {
  final List<TimeSlotEntity> timeSlots;
  
  TimeSlotsLoaded(this.timeSlots);
}

class TimeSlotsError extends ServiceDetailsState {
  final String message;
  
  TimeSlotsError(this.message);
}

class BookingLoading extends ServiceDetailsState {}

class BookingSuccess extends ServiceDetailsState {}

class BookingError extends ServiceDetailsState {
  final String message;
  
  BookingError(this.message);
}

class PromoCodeLoading extends ServiceDetailsState {}

class PromoCodeApplied extends ServiceDetailsState {
  final String discount;
  
  PromoCodeApplied(this.discount);
}

class PromoCodeError extends ServiceDetailsState {
  final String message;
  
  PromoCodeError(this.message);
}

class FavoriteToggled extends ServiceDetailsState {
  final bool isFavorite;
  
  FavoriteToggled(this.isFavorite);
}
