import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_routes.dart';
import '../widgets/onboarding_step_one_content.dart';
import '../widgets/onboarding_step_two_content.dart';
import '../../../../core/utils/helpers/cache_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage == 0) {
      setState(() => _currentPage = 1);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _skipToEnd() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (!mounted) return;
      if (value) {
        context.go(AppRouter.signIn); // روح Login مباشرة
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
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          // Screen 1: Onboarding Step One
          OnboardingStepOneContent(
            onNext: _nextPage,
            onSkip: _skipToEnd,
            currentPage: _currentPage,
          ),

          // Screen 2: Onboarding Step Two (Final)
          OnboardingStepTwoContent(
            onStart: _finishOnboarding,
            currentPage: _currentPage,
          ),
        ],
      ),
    );
  }
}
