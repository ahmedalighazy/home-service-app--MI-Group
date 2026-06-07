import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/notification/presentation/pages/notification_page.dart';
import 'package:home_service_app/features/search/presentation/pages/search_page.dart';
import 'package:home_service_app/features/home/presentation/pages/home_page.dart';

import '../../features/auth/presentation/screens/language_selection/language_selection_screen.dart';
import '../../features/auth/sing_up_screens/complete_profile_screen/complete_profile_screen.dart';
import '../../features/auth/sing_up_screens/otp_screen/otp_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/profile/data/models/subscription_model.dart';
import '../../features/profile/presentation/screens/contact_us_screen.dart';
import '../../features/profile/presentation/screens/delete_account_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/favorites_screen.dart';
import '../../features/profile/presentation/screens/my_visits_screen.dart';
import '../../features/profile/presentation/screens/payment_methods_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/saved_addresses_screen.dart';
import '../../features/profile/presentation/screens/subscription_detail_screen.dart';
import '../../features/profile/presentation/screens/subscriptions_screen.dart';
import '../../features/service_details/presentation/cubit/feature_cubit.dart';
import '../../features/service_details/presentation/views/corporate_services_view.dart';
import '../../features/service_details/presentation/views/service_details_view.dart';
import '../../features/service_details/presentation/views/worker_filter_view.dart';
import '../../features/setting/presentation/screens/chat_detail_screen.dart';
import '../../features/setting/presentation/screens/faq_screen.dart';
import '../../features/setting/presentation/screens/help_center_screen.dart';
import '../../features/setting/presentation/screens/legal_and_policies_screen.dart';
import '../../features/setting/presentation/screens/privacy_policy_screen.dart';
import '../../features/setting/presentation/screens/set_new_password_screen.dart';
import '../../features/setting/presentation/screens/settings_screen.dart';
import '../../features/setting/presentation/screens/terms_and_conditions_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../utils/l10n/app_strings.dart';

import '../../features/auth/sing_in/sing_in.dart';
import '../../features/auth/ Forget Password/forget_screen.dart';
import '../../features/auth/ Forget Password/verify_reset_code_screen.dart';
import '../../features/auth/set_new_pass/set_new_pass.dart';

class AppRouter {
  // Private constructor to prevent instantiation
  AppRouter._();
  static const String splash = '/';

  // Auth Routes
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';

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
  static const String search = '/search';
  static const String notification = '/notification';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String deleteAccount = '/delete-account';
  static const String setting = '/setting';
  static const String favorites = '/favorites';
  static const String helpCenter = '/help-center';
  static const String updatePassword = '/updatePassword';
  static const String legalAndPolicies = '/legal-and-policies';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String faq = '/faq';
  static const String chatDetail = '/chat-detail';
  static const String savedAddresses = '/saved-addresses';
  static const String paymentMethods = '/payment-methods';
  static const String subscriptions = '/subscriptions';
  static const String subscriptionDetail = '/subscription-detail';
  static const String myVisits = '/my-visits';
  static const String contactUs = '/contact-us';
  static const String serviceDetailsScreen = '/service_details_screen.dart';
  static const String workerFilter = '/worker_filter_card.dart';
  static const String corporateServices = '/corporate_services_screen.dart';

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

      // search App Routes
      GoRoute(
        path: search,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SearchPage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      GoRoute(
        path: notification,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NotificationPage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      GoRoute(
        path: serviceDetailsScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => FeatureCubit(),
            child: const ServiceDetailsScreen(),
          ),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      GoRoute(
        path: workerFilter,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => FeatureCubit(),
            child: WorkerFilterCard(cartTotal: _cartTotalFromExtra(state.extra)),
          ),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      GoRoute(
        path: corporateServices,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => FeatureCubit(),
            child: const CorporateServicesScreen(),
          ),
          transitionsBuilder: _fadeTransition,
        ),
      ),
    ],
  );

  static double _cartTotalFromExtra(Object? extra) {
    if (extra is num) return extra.toDouble();
    if (extra is Map && extra['cartTotal'] is num) {
      return (extra['cartTotal'] as num).toDouble();
    }
    return 0;
  }

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
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
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
    case AppRouter.splash:
      return fadeRoute(const SplashScreen());
    case AppRouter.profile:
      return fadeRoute(const ProfileScreen());
    case AppRouter.setting:
      return fadeRoute(const SettingsScreen());
    case AppRouter.deleteAccount:
      return fadeRoute(const DeleteAccountScreen());
    case AppRouter.editProfile:
      return fadeRoute(const EditProfileScreen());
    case AppRouter.favorites:
      return fadeRoute(const FavoritesScreen());
    case AppRouter.helpCenter:
      return fadeRoute(const HelpCenterScreen());
    case AppRouter.updatePassword:
      return fadeRoute(const UpdatePasswordScreen());
    case AppRouter.legalAndPolicies:
      return fadeRoute(const LegalAndPoliciesScreen());
    case AppRouter.privacyPolicy:
      return fadeRoute(const PrivacyPolicyScreen());
    case AppRouter.termsAndConditions:
      return fadeRoute(const TermsAndConditionsScreen());
    case AppRouter.faq:
      return fadeRoute(const FAQScreen());
    case AppRouter.chatDetail:
      return fadeRoute(const ChatDetailScreen());
    case AppRouter.savedAddresses:
      return fadeRoute(const SavedAddressesScreen());
    case AppRouter.paymentMethods:
      return fadeRoute(const PaymentMethodsScreen());
    case AppRouter.subscriptions:
      return fadeRoute(const SubscriptionsScreen());
    case AppRouter.subscriptionDetail:
      final subscription = settings.arguments as SubscriptionModel;
      return fadeRoute(SubscriptionDetailScreen(subscription: subscription));
    case AppRouter.myVisits:
      return fadeRoute(const MyVisitsScreen());
    case AppRouter.serviceDetailsScreen:
      return fadeRoute(
        BlocProvider(
          create: (_) => FeatureCubit(),
          child: const ServiceDetailsScreen(),
        ),
      );
    case AppRouter.workerFilter:
      return fadeRoute(
        BlocProvider(
          create: (_) => FeatureCubit(),
          child: WorkerFilterCard(
            cartTotal: AppRouter._cartTotalFromExtra(settings.arguments),
          ),
        ),
      );
    case AppRouter.corporateServices:
      return fadeRoute(
        BlocProvider(
          create: (_) => FeatureCubit(),
          child: const CorporateServicesScreen(),
        ),
      );

    case AppRouter.onboarding:
      return fadeRoute(const OnboardingScreen());

    case AppRouter.language:
      return fadeRoute(const LanguageSelectionScreen());

    case AppRouter.signIn:
      return fadeRoute(const SingIn());

    // ── Auth flow ──────────────────────────────────────────
    case AppRouter.otp:
      final phone = settings.arguments is String
          ? settings.arguments as String
          : '+974XXXXXXXX';
      return fadeRoute(OtpScreen(phoneNumber: phone));
    case AppRouter.completeProfile:
      final phone = settings.arguments is String
          ? settings.arguments as String
          : '';
      return fadeRoute(CompleteProfileScreen(phoneNumber: phone));

    case AppRouter.forgetPassword:
      return fadeRoute(const ForgetScreen());

    case AppRouter.verifyResetCode:
      final email = settings.arguments is String
          ? settings.arguments as String
          : 'example@email.com';
      return fadeRoute(VerifyResetCodeScreen(email: email));

    case AppRouter.setNewPassword:
      final args = settings.arguments as Map<String, String>;
      return fadeRoute(
        SetNewPasswordScreen(
          email: args['email'] ?? '',
          code: args['code'] ?? '',
        ),
      );

    // ── Main app ───────────────────────────────────────────
    case AppRouter.home:
      return fadeRoute(const HomePage());
    case AppRouter.search:
      return fadeRoute(const SearchPage());
    case AppRouter.contactUs:
      return fadeRoute(const ContactUsScreen());

    default:
      return fadeRoute(
        const Scaffold(body: Center(child: Text(AppStrings.unknownRoute))),
      );
  }
}
