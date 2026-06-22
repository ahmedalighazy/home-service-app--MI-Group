class BookingEntity {
  final String id;
  final String serviceId;
  final String serviceName;
  final DateTime date;
  final String time;
  final String address;
  final double totalPrice;
  final BookingStatus status;

  BookingEntity({
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

enum BookingStatus { pending, confirmed, inProgress, completed, cancelled }
