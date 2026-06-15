import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';
import '../../features/auth/presentation/screens/sign_in/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import '../../features/auth/presentation/screens/otp/otp_screen.dart';
import '../../features/auth/presentation/screens/complete_profile/complete_profile_screen.dart';
import '../../features/auth/presentation/screens/forget_password/forget_password_screen.dart';
import '../../features/auth/presentation/screens/verify_reset_code/verify_reset_code_screen.dart';
import '../../features/auth/presentation/screens/set_new_password/set_new_password_screen.dart';
import '../../features/auth/presentation/screens/password_changed/password_changed_screen.dart';

/// App Router - GoRouter configuration
///
/// ✅ Best Practice: BlocProvider يُنشأ في Router مع GetIt
/// يستخدم ShellRoute لتغليف كل Auth screens بـ BlocProvider واحد
/// بدلاً من تكراره في كل Route على حدة
class AppRouter {
  static final _getIt = GetIt.instance;

  // Route names for navigation
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';
  static const String otp = '/otp';
  static const String completeProfile = '/complete_profile';
  static const String forgotPassword = '/forgot_password';
  static const String verifyResetCode = '/verify_reset_code';
  static const String setNewPassword = '/set_new_password';
  static const String passwordChanged = '/password_changed';
  static const String updatePassword = '/update_password';
  static const String helpCenter = '/help_center';
  static const String legalAndPolicies = '/legal_and_policies';
  static const String faq = '/faq';
  static const String chatDetail = '/chat_detail';
  static const String privacyPolicy = '/privacy_policy';
  static const String termsAndConditions = '/terms_and_conditions';

  static final GoRouter router = GoRouter(
    initialLocation: '/sign_in',
    routes: [
      // ════════════════════════════════════════════════════════════════
      // Auth Shell: BlocProvider واحد لجميع شاشات Auth
      // ════════════════════════════════════════════════════════════════
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider<AuthCubit>(
            create: (_) => _getIt<AuthCubit>(),
            child: child,
          );
        },
        routes: [
          // ────────────────────────────────────────────────────────────
          // Sign In
          // ────────────────────────────────────────────────────────────
          GoRoute(
            path: '/sign_in',
            name: 'sign_in',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SignInScreen(),
            ),
          ),

          // ────────────────────────────────────────────────────────────
          // Sign Up
          // ────────────────────────────────────────────────────────────
          GoRoute(
            path: '/sign_up',
            name: 'sign_up',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SignUpScreen(),
            ),
          ),

          // ────────────────────────────────────────────────────────────
          // OTP Verification
          // ────────────────────────────────────────────────────────────
          GoRoute(
            path: '/otp',
            name: 'otp',
            pageBuilder: (context, state) {
              final phoneNumber = state.extra as String? ?? '';
              return NoTransitionPage(
                child: OtpScreen(phoneNumber: phoneNumber),
              );
            },
          ),

          // ────────────────────────────────────────────────────────────
          // Complete Profile
          // ────────────────────────────────────────────────────────────
          GoRoute(
            path: '/complete_profile',
            name: 'complete_profile',
            pageBuilder: (context, state) {
              final phoneNumber = state.extra as String? ?? '';
              return NoTransitionPage(
                child: CompleteProfileScreen(phoneNumber: phoneNumber),
              );
            },
          ),

          // ────────────────────────────────────────────────────────────
          // Forgot Password
          // ────────────────────────────────────────────────────────────
          GoRoute(
            path: '/forgot_password',
            name: 'forgot_password',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ForgetScreen(),
            ),
          ),

          // ────────────────────────────────────────────────────────────
          // Verify Reset Code
          // ────────────────────────────────────────────────────────────
          GoRoute(
            path: '/verify_reset_code',
            name: 'verify_reset_code',
            pageBuilder: (context, state) {
              final email = state.extra as String? ?? '';
              return NoTransitionPage(
                child: VerifyResetCodeScreen(email: email),
              );
            },
          ),

          // ────────────────────────────────────────────────────────────
          // Set New Password
          // ────────────────────────────────────────────────────────────
          GoRoute(
            path: '/set_new_password',
            name: 'set_new_password',
            pageBuilder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return NoTransitionPage(
                child: SetNewPasswordScreen(
                  email: extra?['email'] as String? ?? '',
                  code: extra?['code'] as String? ?? '',
                ),
              );
            },
          ),

          // ────────────────────────────────────────────────────────────
          // Password Changed Successfully
          // ────────────────────────────────────────────────────────────
          GoRoute(
            path: '/password_changed',
            name: 'password_changed',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: PasswordChangedSuccessfullyScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
