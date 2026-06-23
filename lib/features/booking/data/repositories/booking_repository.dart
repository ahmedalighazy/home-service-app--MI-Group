import '../models/booking_model.dart';

class BookingRepository {
  // Logic to fetch bookings
  Future<List<BookingModel>> getBookings() async {
    // Return dummy data for now to match YAML UI
    return [
      const BookingModel(
        id: 'LMS-125846',
        serviceName: 'تنظيف اثاث(كنب)',
        status: 'مجدولة',
        address: 'برج المرقاب . الطابق الثامن',
        date: 'الاحد.15 مايو ٢٠٢٦',
        time: '10:00 ص',
        price: '250 ر.ق',
        imageUrl: 'assets/icons/Rectangle 48.png',
        paymentMethod: '**** 2345',
        notes: 'يوجد حيوانات اليفه في المنزل',
      ),
      const BookingModel(
        id: 'LMS-125847',
        serviceName: 'مكافحة حشرات (بق)',
        status: 'قيد التنفيذ',
        address: 'الريان',
        date: 'الاحد.15 مايو ٢٠٢٦',
        time: '10:00 ص',
        price: '250 ر.ق',
        imageUrl: 'assets/icons/Rectangle 48.png',
      ),
    ];
  }
}
