import '../entities/visit_entity.dart';
import '../repositories/profile_repository.dart';

class GetVisitsUseCase {
  final ProfileRepository repository;

  GetVisitsUseCase(this.repository);

  Future<List<VisitEntity>> call() {
    return repository.getVisits();
  }
}
