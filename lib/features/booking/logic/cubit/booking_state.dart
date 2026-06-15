import 'package:equatable/equatable.dart';
import '../../data/models/booking_model.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final List<BookingModel> bookings;
  const BookingSuccess(this.bookings);

  @override
  List<Object?> get props => [bookings];
}

class BookingEmpty extends BookingState {}

class BookingError extends BookingState {
  final String message;
  const BookingError(this.message);

  @override
  List<Object?> get props => [message];
}

class BookingDaySelected extends BookingState {
  final int index;
  const BookingDaySelected(this.index);

  @override
  List<Object?> get props => [index];
}

class BookingTimeSelected extends BookingState {
  final int index;
  const BookingTimeSelected(this.index);

  @override
  List<Object?> get props => [index];
}
