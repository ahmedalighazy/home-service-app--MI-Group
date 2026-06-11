import '../../domain/entities/booking_entity.dart';
import '../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<BookingModel> createBooking(Map<String, dynamic> bookingData);
  Future<List<BookingModel>> getBookings();
  Future<BookingModel?> getBookingById(String bookingId);
  Future<void> cancelBooking(String bookingId);
  Future<void> updateBookingStatus(String bookingId, BookingStatus status);
}
