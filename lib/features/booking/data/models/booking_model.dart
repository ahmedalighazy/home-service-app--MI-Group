import '../../domain/entities/booking_entity.dart';

class BookingModel {
  final String id;
  final String serviceId;
  final String serviceName;
  final DateTime date;
  final String time;
  final String address;
  final double totalPrice;
  final BookingStatus status;

  BookingModel({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.date,
    required this.time,
    required this.address,
    required this.totalPrice,
    required this.status,
  });
}
