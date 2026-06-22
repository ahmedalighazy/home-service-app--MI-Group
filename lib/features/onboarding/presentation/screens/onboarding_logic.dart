import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/utils/helpers/cache_helper.dart';

mixin OnboardingLogic<T extends StatefulWidget> on State<T> {
  final PageController onboardingPageCtrl = PageController();
  late AnimationController onboardingAnimCtrl;
  late Animation<double> onboardingFadeAnim;

  void initOnboardingAnimation(TickerProvider vsync) {
    onboardingAnimCtrl = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: vsync,
    );
    onboardingFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: onboardingAnimCtrl, curve: Curves.easeInOut),
    );
    onboardingAnimCtrl.forward();
  }

  void _resetAnimation() {
    onboardingAnimCtrl.reset();
    onboardingAnimCtrl.forward();
  }

  void goToNextPage() {
    _resetAnimation();
    onboardingPageCtrl.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void goToStepThree() {
    _resetAnimation();
    onboardingPageCtrl.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void finishOnboarding() {
    _resetAnimation();
    CacheHelper.saveData(key: 'onBoarding', value: true).then((saved) {
      if (!mounted) return;
      if (saved) {
        GoRouter.of(context).go(AppRouter.signUp);
      }
    });
  }

  @override
  void dispose() {
    onboardingPageCtrl.dispose();
    onboardingAnimCtrl.dispose();
    super.dispose();
  }
}
