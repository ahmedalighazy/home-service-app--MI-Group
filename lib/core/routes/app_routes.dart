import 'package:flutter/material.dart';
import 'package:home_service_app/features/auth/presentation/screens/language_selection/language_selection_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/sign up/sing_up_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/sign in/sing_in_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/otp_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/complete profile/complete_profile_unified_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/Verify Reset Code/verify_reset_code_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/set new pass/set_new_password_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/Check Your Email/check_your_email.dart';
import 'package:home_service_app/features/auth/presentation/screens/password_changed_successfully/password_changed_successfully_screen.dart';
import 'package:home_service_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:home_service_app/features/onboarding/presentation/screens/onboarding_screen.dart';

class AppRoutes {
  static const String splash          = '/';
  static const String onboarding      = '/onboarding';
  static const String language        = '/language';
  static const String signUp         = '/sign-up';
  static const String login           = '/sign up screens';
  static const String otp             = '/otp';
  static const String completeProfile = '/complete-profile';
  static const String emailLogin      = '/email-sign up screens';
  static const String forgetPassword  = '/forget-password';
  static const String verifyResetCode = '/verify-reset-code';
  static const String checkYourEmail  = '/check-your-email';
  static const String setNewPassword  = '/set-new-password';
  static const String passwordChangedSuccessfully = '/password-changed-successfully';
  static const String home            = '/home';

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

      case signUp:
        return fadeRoute(const SignUpScreen());

      case login:
        return fadeRoute(const SignInScreen());

      // ── Auth flow ──────────────────────────────────────────
      case otp:
        return fadeRoute(const OtpVerificationScreen());

      case completeProfile:
        final phone = settings.arguments is String ? settings.arguments as String : '';
        return fadeRoute(CompleteProfileUnifiedScreen(phoneNumber: phone));

      case emailLogin:
        return fadeRoute(const SignInScreen());

      case forgetPassword:
        return fadeRoute(const ResetPasswordScreen());

      case verifyResetCode:
        final email = settings.arguments is String
            ? settings.arguments as String
            : 'example@email.com';
        return fadeRoute(ResetPasswordScreen(email: email));

      case checkYourEmail:
        return fadeRoute(EmailVerificationScreen());

      case setNewPassword:
        final args = settings.arguments as Map<String, String>;
        return fadeRoute(SetNewPasswordScreen(
          email: args['email'] ?? '',
          code: args['code'] ?? '',
        ));

      case passwordChangedSuccessfully:
        return fadeRoute(const PasswordChangedSuccessfullyScreen());

      // ── Main app ───────────────────────────────────────────
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
            body: Center(child: Text('صفحة غير موجودة')),
          ),
        );
    }
  }
}
