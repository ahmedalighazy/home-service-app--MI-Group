import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_onboarding_pages_usecase.dart';
import '../../domain/usecases/complete_onboarding_usecase.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../states/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final GetOnboardingPagesUseCase getOnboardingPagesUseCase;
  final CompleteOnboardingUseCase completeOnboardingUseCase;
  final OnboardingRepository onboardingRepository;

  OnboardingCubit({
    required this.getOnboardingPagesUseCase,
    required this.completeOnboardingUseCase,
    required this.onboardingRepository,
  }) : super(OnboardingInitial());

  Future<void> loadOnboardingPages() async {
    emit(OnboardingLoading());
    try {
      final pages = await getOnboardingPagesUseCase();
      emit(OnboardingLoaded(pages: pages));
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  void nextPage() {
    if (state is OnboardingLoaded) {
      final loadedState = state as OnboardingLoaded;
      if (loadedState.currentPage < loadedState.pages.length - 1) {
        emit(OnboardingLoaded(
          pages: loadedState.pages,
          currentPage: loadedState.currentPage + 1,
        ));
      }
    }
  }

  void previousPage() {
    if (state is OnboardingLoaded) {
      final loadedState = state as OnboardingLoaded;
      if (loadedState.currentPage > 0) {
        emit(OnboardingLoaded(
          pages: loadedState.pages,
          currentPage: loadedState.currentPage - 1,
        ));
      }
    }
  }

  Future<void> completeOnboarding() async {
    try {
      await completeOnboardingUseCase();
      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  Future<void> skipOnboarding() async {
    try {
      await completeOnboardingUseCase();
      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}
