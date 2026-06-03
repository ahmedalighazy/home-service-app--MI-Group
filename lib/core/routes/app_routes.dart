import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ============ Core Screens ============
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';

// ============ Auth Screens ============
import '../../features/auth/presentation/screens/language_selection/language_selection_screen.dart';
import '../../features/auth/sing_in/sing_in.dart';
import '../../features/auth/sing_up_screens/otp_screen/otp_screen.dart';
import '../../features/auth/sing_up_screens/complete_profile_screen/complete_profile_screen.dart';
import '../../features/auth/ Forget Password/forget_screen.dart';
import '../../features/auth/ Forget Password/verify_reset_code_screen.dart';
import '../../features/auth/set_new_pass/set_new_pass.dart';

// ============ Main App Screens ============
import '../../features/home/presentation/pages/home_page.dart';

/// AppRouter - Centralized navigation using GoRouter
/// All app routes are defined here with type-safe navigation
class AppRouter {
  // Private constructor to prevent instantiation
  AppRouter._();

  //  Route Paths
  // Core Routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String language = '/language';

  // Auth Routes
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String otp = '/otp';
  static const String completeProfile = '/complete-profile';
  static const String forgetPassword = '/forget-password';
  static const String verifyResetCode = '/verify-reset-code';
  static const String setNewPassword = '/set-new-password';

  // Main App Routes
  static const String home = '/home';

  // GoRouter Configuration
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    errorPageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const Scaffold(
        body: Center(
          child: Text(
            'صفحة غير موجودة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      transitionsBuilder: _fadeTransition,
    ),
    routes: [
      // Core Routes
      GoRoute(
        path: splash,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      GoRoute(
        path: onboarding,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      GoRoute(
        path: language,
        redirect: (context, state) => signIn, // Redirect to sign in
      ),

      // ============ Auth Routes ============
      GoRoute(
        path: signIn,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SingIn(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      GoRoute(
        path: signUp,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SingIn(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      GoRoute(
        path: otp,
        pageBuilder: (context, state) {
          final phoneNumber = state.extra as String? ?? '+974XXXXXXXX';
          return CustomTransitionPage(
            key: state.pageKey,
            child: OtpScreen(phoneNumber: phoneNumber),
            transitionsBuilder: _fadeTransition,
          );
        },
      ),

      GoRoute(
        path: completeProfile,
        pageBuilder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return CustomTransitionPage(
            key: state.pageKey,
            child: CompleteProfileScreen(phoneNumber: phoneNumber),
            transitionsBuilder: _fadeTransition,
          );
        },
      ),

      GoRoute(
        path: forgetPassword,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ForgetScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      GoRoute(
        path: verifyResetCode,
        pageBuilder: (context, state) {
          final email = state.extra as String? ?? 'example@email.com';
          return CustomTransitionPage(
            key: state.pageKey,
            child: VerifyResetCodeScreen(email: email),
            transitionsBuilder: _fadeTransition,
          );
        },
      ),

      GoRoute(
        path: setNewPassword,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, String>?;
          return CustomTransitionPage(
            key: state.pageKey,
            child: SetNewPasswordScreen(
              email: args?['email'] ?? '',
              code: args?['code'] ?? '',
            ),
            transitionsBuilder: _fadeTransition,
          );
        },
      ),

      // Main App Routes
      GoRoute(
        path: home,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
    ],
  );

  // Transition Buildeer
  static Widget _fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

/// AppRoutes - Backward compatibility class
/// Provides old route names and references to AppRouter
@Deprecated('Use AppRouter instead')
class AppRoutes {
  // Core Routes
  static const String splash = AppRouter.splash;
  static const String onboarding = AppRouter.onboarding;
  static const String language = AppRouter.language;

  // Auth Routes (with aliases)
  static const String login = AppRouter.signIn; // Alias
  static const String signIn = AppRouter.signIn;
  static const String signUp = AppRouter.signUp;
  static const String emailLogin = AppRouter.signIn; // Alias
  static const String otp = AppRouter.otp;
  static const String completeProfile = AppRouter.completeProfile;
  static const String forgetPassword = AppRouter.forgetPassword;
  static const String verifyResetCode = AppRouter.verifyResetCode;
  static const String setNewPassword = AppRouter.setNewPassword;

  // Main App Routes
  static const String home = AppRouter.home;
}
