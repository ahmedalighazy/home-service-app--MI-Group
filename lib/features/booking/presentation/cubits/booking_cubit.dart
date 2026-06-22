import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/create_booking_usecase.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../../domain/repositories/booking_repository.dart';
import '../states/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final CreateBookingUseCase createBookingUseCase;
  final GetBookingsUseCase getBookingsUseCase;
  final BookingRepository bookingRepository;

  BookingCubit({
    required this.createBookingUseCase,
    required this.getBookingsUseCase,
    required this.bookingRepository,
  }) : super(BookingInitial());

  Future<void> createBooking(Map<String, dynamic> bookingData) async {
    emit(BookingLoading());
    try {
      final booking = await createBookingUseCase(bookingData);
      emit(BookingCreated(booking));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> loadBookings() async {
    emit(BookingLoading());
    try {
      final bookings = await getBookingsUseCase();
      emit(BookingsLoaded(bookings));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    try {
      await bookingRepository.cancelBooking(bookingId);
      emit(BookingCancelled());
      await loadBookings();
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> updateBookingStatus(String bookingId, BookingStatus status) async {
    try {
      await bookingRepository.updateBookingStatus(bookingId, status);
      final booking = await bookingRepository.getBookingById(bookingId);
      if (booking != null) {
        emit(BookingStatusUpdated(booking));
      }
      await loadBookings();
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
