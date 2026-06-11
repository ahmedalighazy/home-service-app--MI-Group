import '../../domain/entities/onboarding_entity.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';
import '../models/onboarding_model.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<List<OnboardingEntity>> getOnboardingPages() async {
    final models = await localDataSource.getOnboardingPages();
    return models.map((model) => _toOnboardingEntity(model)).toList();
  }

  @override
  Future<void> completeOnboarding() async {
    await localDataSource.completeOnboarding();
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return await localDataSource.isOnboardingCompleted();
  }

  OnboardingEntity _toOnboardingEntity(OnboardingModel model) {
    return OnboardingEntity(
      title: model.title,
      description: model.description,
      imagePath: model.imagePath,
    );
  }
}
