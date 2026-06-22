import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class CreateBookingUseCase {
  final BookingRepository repository;

  CreateBookingUseCase(this.repository);

  Future<BookingEntity> call(Map<String, dynamic> bookingData) {
    return repository.createBooking(bookingData);
  }
}
