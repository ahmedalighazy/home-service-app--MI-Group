import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/presentation/cubits/auth_cubit_v2.dart';
import '../../features/auth/presentation/screens/sign_in_screen/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen/sign_up_screen.dart';
import '../../features/auth/presentation/screens/otp_screen/otp_screen.dart';
import '../../features/auth/presentation/screens/complete_profile_screen/complete_profile_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/verify_reset_code_screen/verify_reset_code_screen.dart';
import '../../features/auth/presentation/screens/set_new_password_screen/set_new_password_screen.dart';
import '../../features/auth/presentation/screens/password_changed_successfully_screen/password_changed_successfully_screen.dart';

/// App Router - GoRouter configuration
///
/// ✅ Best Practice: BlocProvider يُنشأ في Router مع GetIt
/// يستخدم ShellRoute لتغليف كل Auth screens بـ BlocProvider واحد
/// بدلاً من تكراره في كل Route على حدة
class AppRouter {
  static final _getIt = GetIt.instance;

  static final GoRouter router = GoRouter(
    initialLocation: '/sign_in',
    routes: [
      // ════════════════════════════════════════════════════════════════
      // Auth Shell: BlocProvider واحد لجميع شاشات Auth
      // ════════════════════════════════════════════════════════════════
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider<AuthCubitV2>(
            create: (_) => _getIt<AuthCubitV2>(),
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
              child: ForgotPasswordScreen(),
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
              final email = state.extra as String? ?? '';
              return NoTransitionPage(
                child: SetNewPasswordScreen(email: email),
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
