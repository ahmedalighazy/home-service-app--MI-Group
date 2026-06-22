import '../../domain/entities/service_page_entity.dart';
import '../../domain/entities/time_slot_entity.dart';
import '../../domain/repositories/service_details_repository.dart';
import '../datasources/service_details_remote_datasource.dart';
import '../datasources/service_details_local_datasource.dart';
import '../models/service_page_model.dart';
import '../models/time_slot_model.dart';

class ServiceDetailsRepositoryImpl implements ServiceDetailsRepository {
  final ServiceDetailsRemoteDataSource remoteDataSource;
  final ServiceDetailsLocalDataSource localDataSource;

  ServiceDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<ServicePageEntity> getServicePage(String serviceId) async {
    try {
      final model = await remoteDataSource.getServicePage(serviceId);
      await localDataSource.cacheServicePage(model);
      return _toServicePageEntity(model);
    } catch (e) {
      final cached = await localDataSource.getCachedServicePage(serviceId);
      if (cached != null) {
        return _toServicePageEntity(cached);
      }
      rethrow;
    }
  }

  @override
  Future<List<TimeSlotEntity>> getAvailableTimeSlots(String date) async {
    try {
      final models = await remoteDataSource.getAvailableTimeSlots(date);
      await localDataSource.cacheTimeSlots(models);
      return models.map((model) => _toTimeSlotEntity(model)).toList();
    } catch (e) {
      final cached = await localDataSource.getCachedTimeSlots(date);
      if (cached != null) {
        return cached.map((model) => _toTimeSlotEntity(model)).toList();
      }
      rethrow;
    }
  }

  @override
  Future<void> bookService(Map<String, dynamic> bookingData) async {
    await remoteDataSource.bookService(bookingData);
  }

  @override
  Future<void> applyPromoCode(String promoCode) async {
    await remoteDataSource.applyPromoCode(promoCode);
  }

  @override
  Future<void> saveFavoriteService(String serviceId) async {
    await remoteDataSource.saveFavoriteService(serviceId);
  }

  @override
  Future<void> removeFavoriteService(String serviceId) async {
    await remoteDataSource.removeFavoriteService(serviceId);
  }

  ServicePageEntity _toServicePageEntity(ServicePageModel model) {
    return ServicePageEntity(
      coverImage: model.coverImage,
      mainTitle: model.mainTitle,
      rate: model.rate,
      reviews: model.reviews,
      totalSteps: model.totalSteps,
      currentStep: model.currentStep,
      categories: model.categories.map((cat) => ServiceCategoryEntity(
        id: cat.title,
        name: cat.title,
        icon: cat.image,
      )).toList(),
      promoCode: model.promoCode,
      promoDiscount: model.promoDiscount,
      serviceGroups: model.serviceGroups.map((group) => ServiceGroupEntity(
        id: group.categoryTitle,
        name: group.categoryTitle,
        items: group.items.map((item) => ServiceItemEntity(
          image: item.image,
          title: item.title,
          description: item.description,
          price: item.price,
        )).toList(),
      )).toList(),
    );
  }

  TimeSlotEntity _toTimeSlotEntity(TimeSlot model) {
    return TimeSlotEntity(
      startTime: model.startTime,
      endTime: model.endTime,
    );
  }
}
