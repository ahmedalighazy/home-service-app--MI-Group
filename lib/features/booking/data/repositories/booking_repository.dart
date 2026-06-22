import '../models/booking_model.dart';
import '../../domain/entities/booking_entity.dart';

class BookingRepository {

  Future<List<BookingModel>> getBookings() async {

    return [
      BookingModel(
        id: 'LMS-125846',
        serviceId: '1',
        serviceName: 'تنظيف اثاث(كنب)',
        status: BookingStatus.confirmed,
        address: 'برج المرقاب . الطابق الثامن',
        date: DateTime(2026, 5, 15),
        time: '10:00 ص',
        totalPrice: 250,
        price: 250,
        imageUrl: 'assets/icons/Rectangle 48.png',
        paymentMethod: '**** 2345',
        notes: 'يوجد حيوانات اليفه في المنزل',
      ),
      BookingModel(
        id: 'LMS-125847',
        serviceId: '2',
        serviceName: 'مكافحة حشرات (بق)',
        status: BookingStatus.inProgress,
        address: 'الريان',
        date: DateTime(2026, 5, 15),
        time: '10:00 ص',
        totalPrice: 250,
        price: 250,
        imageUrl: 'assets/icons/Rectangle 48.png',
      ),
    ];
  }
}
