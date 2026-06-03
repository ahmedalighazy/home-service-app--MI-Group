import 'package:flutter/material.dart';
import 'package:home_service_app/features/home/presentation/pages/home_page.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/language_selection_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/sing_up_screens/otp_screen.dart';
import '../../features/auth/sing_up_screens/complete_profile_screen.dart';
import '../../features/auth/sing_in/sing_in.dart';
import '../../features/auth/ Forget Password/forget_screen.dart';
import '../../features/auth/ Forget Password/verify_reset_code_screen.dart';
import '../../features/auth/set_new_pass/set_new_pass.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String language = '/language';
  static const String login = '/sign up screens';
  static const String otp = '/otp';
  static const String completeProfile = '/complete-profile';
  static const String emailLogin = '/email-sign up screens';
  static const String forgetPassword = '/forget-password';
  static const String verifyResetCode = '/verify-reset-code';
  static const String setNewPassword = '/set-new-password';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // smooth fade transition for all routes
    Route<dynamic> fadeRoute(Widget page) {
      return PageRouteBuilder(
        settings: settings,
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, _) => page,
        transitionsBuilder: (context, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
      );
    }

    switch (settings.name) {
      // ── Core flow ─────────────────────────────────────────
      case splash:
        return fadeRoute(const SplashScreen());

      case onboarding:
        return fadeRoute(const OnboardingScreen());

      case language:
        return fadeRoute(const LanguageSelectionScreen());

      case login:
        return fadeRoute(const SingIn());

      // ── Auth flow ──────────────────────────────────────────
      case otp:
        final phone = settings.arguments is String
            ? settings.arguments as String
            : '+974XXXXXXXX';
        return fadeRoute(OtpScreen(phoneNumber: phone));

      case completeProfile:
        final phone = settings.arguments is String
            ? settings.arguments as String
            : '';
        return fadeRoute(CompleteProfileScreen(phoneNumber: phone));

      case emailLogin:
        return fadeRoute(const SingIn());

      case forgetPassword:
        return fadeRoute(const ForgetScreen());

      case verifyResetCode:
        final email = settings.arguments is String
            ? settings.arguments as String
            : 'example@email.com';
        return fadeRoute(VerifyResetCodeScreen(email: email));

      case setNewPassword:
        final args = settings.arguments as Map<String, String>;
        return fadeRoute(
          SetNewPasswordScreen(
            email: args['email'] ?? '',
            code: args['code'] ?? '',
          ),
        );

      // ── Main app ───────────────────────────────────────────
      case home:
        return fadeRoute(const Scaffold(body: Center(child: HomePage())));

      default:
        return fadeRoute(
          const Scaffold(body: Center(child: Text('صفحة غير موجودة'))),
        );
    }
  }
}
