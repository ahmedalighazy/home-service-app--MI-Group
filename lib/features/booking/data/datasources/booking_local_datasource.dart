import '../models/booking_model.dart';

abstract class BookingLocalDataSource {
  Future<void> cacheBookings(List<BookingModel> bookings);
  Future<List<BookingModel>?> getCachedBookings();
  Future<void> clearCache();
}
