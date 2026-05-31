import 'package:flutter/material.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_one_static.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_one_content.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_two_static.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_two_content.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String onboarding1Static = '/onboarding1_static';
  static const String onboarding1 = '/onboarding1';
  static const String onboarding2Static = '/onboarding2_static';
  static const String onboarding2 = '/onboarding2';
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Route<dynamic> fadeRoute(Widget page) {
      return PageRouteBuilder(
        settings: settings,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    }

    switch (settings.name) {
      case splash:
        return fadeRoute(const SplashScreen());
      case onboarding:
        return fadeRoute(const OnboardingScreen());
      case onboarding1Static:
        return fadeRoute(
          Builder(
            builder: (context) => OnboardingStepOneStatic(
              onNext: () => Navigator.pushNamed(context, onboarding1),
              onSkip: () => Navigator.pushNamed(context, onboarding2Static),
            ),
          ),
        );
      case onboarding1:
        return fadeRoute(
          Builder(
            builder: (context) => OnboardingStepOneContent(
              onNext: () => Navigator.pushNamed(context, onboarding2Static),
              onSkip: () => Navigator.pushNamed(context, onboarding2Static),
            ),
          ),
        );
      case onboarding2Static:
        return fadeRoute(
          Builder(
            builder: (context) => OnboardingStepTwoStatic(
              onStart: () => Navigator.pushNamed(context, onboarding2),
            ),
          ),
        );
      case onboarding2:
        return fadeRoute(
          Builder(
            builder: (context) => OnboardingStepTwoContent(
              onStart: () => Navigator.pushReplacementNamed(context, login),
            ),
          ),
        );
      case login:
        return fadeRoute(const LoginScreen());
      case home:
        return fadeRoute(
          const Scaffold(
            body: Center(
              child: Text(
                'الرئيسية (قريباً)',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      default:
        return fadeRoute(
          const Scaffold(
            body: Center(
              child: Text('العنوان غير معروف'),
            ),
          ),
        );
    }
  }
}
