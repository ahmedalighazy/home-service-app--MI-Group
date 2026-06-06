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

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  void _nextPage() {
    _animationController.reset();
    _animationController.forward();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _goToStepThree() {
    _animationController.reset();
    _animationController.forward();
    _pageController.animateToPage(
      2, // Onboarding 2 Content is index 2
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _finishOnboarding() {
    _animationController.reset();
    _animationController.forward();
    debugPrint('Finishing onboarding...');
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      debugPrint('Onboarding saved: $value');
      if (!mounted) return;
      if (value) {
        debugPrint('Navigating to language screen...');
        Navigator.of(context).pushReplacementNamed(AppRoutes.language);
      } else {
        debugPrint('Failed to save onboarding');
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: PageView(
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
      ),
    );
  }
}
