import '../models/onboarding_model.dart';

abstract class OnboardingLocalDataSource {
  Future<List<OnboardingModel>> getOnboardingPages();
  Future<void> completeOnboarding();
  Future<bool> isOnboardingCompleted();
}
