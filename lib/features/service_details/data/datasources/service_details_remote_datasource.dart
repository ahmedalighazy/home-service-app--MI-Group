import '../models/service_page_model.dart';
import '../models/time_slot_model.dart';

abstract class ServiceDetailsRemoteDataSource {
  Future<ServicePageModel> getServicePage(String serviceId);
  Future<List<TimeSlot>> getAvailableTimeSlots(String date);
  Future<void> bookService(Map<String, dynamic> bookingData);
  Future<void> applyPromoCode(String promoCode);
  Future<void> saveFavoriteService(String serviceId);
  Future<void> removeFavoriteService(String serviceId);
}
