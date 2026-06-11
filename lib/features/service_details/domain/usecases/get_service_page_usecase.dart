import '../entities/service_page_entity.dart';
import '../repositories/service_details_repository.dart';

class GetServicePageUseCase {
  final ServiceDetailsRepository repository;

  GetServicePageUseCase(this.repository);

  Future<ServicePageEntity> call(String serviceId) {
    return repository.getServicePage(serviceId);
  }
}
