import '../../domain/entities/onboarding_entity.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final List<OnboardingEntity> pages;
  final int currentPage;

  OnboardingLoaded({
    required this.pages,
    this.currentPage = 0,
  });
}

class OnboardingCompleted extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String message;

  OnboardingError(this.message);
}
