import 'package:equatable/equatable.dart';

class BookingModel extends Equatable {
  final String id;
  final String serviceName;
  final String status;
  final String address;
  final String date;
  final String time;
  final String price;
  final String? imageUrl;
  final String? paymentMethod;
  final String? notes;

  const BookingModel({
    required this.id,
    required this.serviceName,
    required this.status,
    required this.address,
    required this.date,
    required this.time,
    required this.price,
    this.imageUrl,
    this.paymentMethod,
    this.notes,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      serviceName: json['serviceName'] as String,
      status: json['status'] as String,
      address: json['address'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      price: json['price'] as String,
      imageUrl: json['imageUrl'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'status': status,
      'address': address,
      'date': date,
      'time': time,
      'price': price,
      'imageUrl': imageUrl,
      'paymentMethod': paymentMethod,
      'notes': notes,
    };
  }

  @override
  List<Object?> get props => [
        id,
        serviceName,
        status,
        address,
        date,
        time,
        price,
        imageUrl,
        paymentMethod,
        notes,
      ];
}
