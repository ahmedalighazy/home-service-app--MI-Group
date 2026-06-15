import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_datasource.dart';
import '../datasources/booking_local_datasource.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final BookingLocalDataSource localDataSource;

  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<BookingEntity> createBooking(Map<String, dynamic> bookingData) async {
    final model = await remoteDataSource.createBooking(bookingData);
    return _toBookingEntity(model);
  }

  @override
  Future<List<BookingEntity>> getBookings() async {
    try {
      final bookingModels = await remoteDataSource.getBookings();
      await localDataSource.cacheBookings(bookingModels);
      return bookingModels.map((model) => _toBookingEntity(model)).toList();
    } catch (e) {
      final cached = await localDataSource.getCachedBookings();
      if (cached != null) {
        return cached.map((model) => _toBookingEntity(model)).toList();
      }
      rethrow;
    }
  }

  @override
  Future<BookingEntity?> getBookingById(String bookingId) async {
    final model = await remoteDataSource.getBookingById(bookingId);
    return model != null ? _toBookingEntity(model) : null;
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    await remoteDataSource.cancelBooking(bookingId);
  }

  @override
  Future<void> updateBookingStatus(String bookingId, BookingStatus status) async {
    await remoteDataSource.updateBookingStatus(bookingId, status);
  }

  BookingEntity _toBookingEntity(BookingModel model) {
    return BookingEntity(
      id: model.id,
      serviceId: model.serviceId,
      serviceName: model.serviceName,
      date: model.date,
      time: model.time,
      address: model.address,
      totalPrice: model.totalPrice,
      status: model.status,
    );
  }
}
