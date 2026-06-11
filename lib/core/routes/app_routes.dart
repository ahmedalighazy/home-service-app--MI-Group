import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:home_service_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/sign_in_screen/sign_in_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signUp = '/sign-up';
  static const String signIn = '/sign-in';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String completeProfile = '/complete-profile';
  static const String emailLogin = '/email-login';
  static const String forgetPassword = '/forget-password';
  static const String verifyResetCode = '/verify-reset-code';
  static const String checkYourEmail = '/check-your-email';
  static const String setNewPassword = '/set-new-password';
  static const String passwordChangedSuccessfully = '/password-changed-successfully';
  static const String home = '/home';
  static const String language = '/language';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Home Page'),
          ),
        ),
      ),
    ],
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email');
      final loggedIn = email != null && email.isNotEmpty;
      // Redirect unauthenticated users from protected routes to sign in
      if (!loggedIn && (state.matchedLocation == home)) {
        return signIn;
      }
      // Prevent authenticated users from accessing sign-in or sign-up screens
      if (loggedIn && (state.matchedLocation == signIn || state.matchedLocation == signUp)) {
        return home;
      }
      return null;
    },
  );
}

class AppRoutes {
  static const String splash = AppRouter.splash;
  static const String onboarding = AppRouter.onboarding;
  static const String signUp = AppRouter.signUp;
  static const String signIn = AppRouter.signIn;
  static const String login = AppRouter.login;
  static const String otp = AppRouter.otp;
  static const String completeProfile = AppRouter.completeProfile;
  static const String emailLogin = AppRouter.emailLogin;
  static const String forgetPassword = AppRouter.forgetPassword;
  static const String verifyResetCode = AppRouter.verifyResetCode;
  static const String checkYourEmail = AppRouter.checkYourEmail;
  static const String setNewPassword = AppRouter.setNewPassword;
  static const String passwordChangedSuccessfully = AppRouter.passwordChangedSuccessfully;
  static const String home = AppRouter.home;
  static const String language = AppRouter.language;
}
