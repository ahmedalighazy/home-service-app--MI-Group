import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../widgets/onboarding_step_one_content.dart';
import '../widgets/onboarding_step_two_static.dart';
import '../widgets/onboarding_step_two_content.dart';

import '../../../../core/utils/helpers/cache_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _goToStepThree() {
    _pageController.animateToPage(
      1, // Onboarding 2 Static is now index 1
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _finishOnboarding() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (!mounted) return;
      if (value) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Prevent manual swipe to follow exact button clicks
        children: [
          // Screen 1: Onboarding 1 - Content
          OnboardingStepOneContent(
            onNext: _nextPage,
            onSkip: _goToStepThree,
          ),
          
          // Screen 2: Onboarding 2 - Static
          OnboardingStepTwoStatic(
            onStart: _nextPage,
          ),
          
          // Screen 3: Onboarding 2 - Content
          OnboardingStepTwoContent(
            onStart: _finishOnboarding,
          ),
        ],
      ),
    );
  }
}
