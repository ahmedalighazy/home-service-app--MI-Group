import '../entities/onboarding_entity.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingPagesUseCase {
  final OnboardingRepository repository;

  GetOnboardingPagesUseCase(this.repository);

  Future<List<OnboardingEntity>> call() {
    return repository.getOnboardingPages();
  }
}
