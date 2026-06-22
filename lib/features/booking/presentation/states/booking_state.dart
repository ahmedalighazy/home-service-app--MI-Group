import '../../domain/entities/booking_entity.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingCreated extends BookingState {
  final BookingEntity booking;

  BookingCreated(this.booking);
}

class BookingsLoaded extends BookingState {
  final List<BookingEntity> bookings;

  BookingsLoaded(this.bookings);
}

class BookingError extends BookingState {
  final String message;

  BookingError(this.message);
}

class BookingCancelled extends BookingState {}

class BookingStatusUpdated extends BookingState {
  final BookingEntity booking;

  BookingStatusUpdated(this.booking);
}
