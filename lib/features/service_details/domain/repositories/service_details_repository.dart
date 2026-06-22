import '../entities/service_page_entity.dart';
import '../entities/time_slot_entity.dart';

abstract class ServiceDetailsRepository {
  Future<ServicePageEntity> getServicePage(String serviceId);
  Future<List<TimeSlotEntity>> getAvailableTimeSlots(String date);
  Future<void> bookService(Map<String, dynamic> bookingData);
  Future<void> applyPromoCode(String promoCode);
  Future<void> saveFavoriteService(String serviceId);
  Future<void> removeFavoriteService(String serviceId);
}
