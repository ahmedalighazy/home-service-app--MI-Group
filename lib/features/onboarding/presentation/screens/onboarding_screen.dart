import 'package:flutter/material.dart';
import '../widgets/onboarding_step_one_content.dart';
import '../widgets/onboarding_step_two_static.dart';
import '../widgets/onboarding_step_two_content.dart';
import 'onboarding_logic.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin, OnboardingLogic {
  @override
  void initState() {
    super.initState();
    initOnboardingAnimation(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: onboardingFadeAnim,
        child: PageView(
          controller: onboardingPageCtrl,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            OnboardingStepOneContent(
              onNext: goToNextPage,
              onSkip: goToStepThree,
            ),
            OnboardingStepTwoStatic(
              onStart: goToNextPage,
            ),
            OnboardingStepTwoContent(
              onStart: finishOnboarding,
            ),
          ],
        ),
      ),
    );
  }
}
