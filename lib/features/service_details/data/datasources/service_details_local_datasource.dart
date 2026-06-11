import '../models/service_page_model.dart';
import '../models/time_slot_model.dart';

abstract class ServiceDetailsLocalDataSource {
  Future<void> cacheServicePage(ServicePageModel servicePage);
  Future<ServicePageModel?> getCachedServicePage(String serviceId);
  Future<void> cacheTimeSlots(List<TimeSlot> timeSlots);
  Future<List<TimeSlot>?> getCachedTimeSlots(String date);
  Future<void> clearCache();
}
