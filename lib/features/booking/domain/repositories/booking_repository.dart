import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<BookingEntity> createBooking(Map<String, dynamic> bookingData);
  Future<List<BookingEntity>> getBookings();
  Future<BookingEntity?> getBookingById(String bookingId);
  Future<void> cancelBooking(String bookingId);
  Future<void> updateBookingStatus(String bookingId, BookingStatus status);
}
