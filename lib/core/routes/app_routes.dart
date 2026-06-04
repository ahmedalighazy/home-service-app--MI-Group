import 'package:flutter/material.dart';
import 'package:home_service_app/features/home/presentation/pages/home_page.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_one_content.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_one_static.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_two_content.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_two_static.dart';
import '../../features/profile/presentation/screens/delete_account_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/favorites_screen.dart';
import '../../features/profile/presentation/screens/saved_addresses_screen.dart';
import '../../features/profile/presentation/screens/payment_methods_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/setting/presentation/screens/chat_detail_screen.dart';
import '../../features/setting/presentation/screens/faq_screen.dart';
import '../../features/setting/presentation/screens/help_center_screen.dart';
import '../../features/setting/presentation/screens/legal_and_policies_screen.dart';
import '../../features/setting/presentation/screens/privacy_policy_screen.dart';
import '../../features/setting/presentation/screens/set_new_password_screen.dart';
import '../../features/setting/presentation/screens/settings_screen.dart';
import '../../features/setting/presentation/screens/terms_and_conditions_screen.dart';
import '../utils/l10n/app_strings.dart';

class AppRoutes {
  // static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String onboarding1Static = '/onboarding1_static';
  static const String onboarding1 = '/onboarding1';
  static const String onboarding2Static = '/onboarding2_static';
  static const String onboarding2 = '/onboarding2';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String deleteAccount = '/delete-account';
  static const String setting = '/setting';
  static const String favorites = '/favorites';
  static const String helpCenter = '/help-center';
  static const String setNewPassword = '/set-new-password';
  static const String legalAndPolicies = '/legal-and-policies';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String faq = '/faq';
  static const String chatDetail = '/chat-detail';
  static const String savedAddresses = '/saved-addresses';
  static const String paymentMethods = '/payment-methods';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Route<dynamic> fadeRoute(Widget page) {
      return PageRouteBuilder(
        settings: settings,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
    }

    switch (settings.name) {
      // case splash:
      //   return fadeRoute(const SplashScreen());
      case profile:
        return fadeRoute(const ProfileScreen());
      case setting:
        return fadeRoute(const SettingsScreen());
      case deleteAccount:
        return fadeRoute(const DeleteAccountScreen());
      case editProfile:
        return fadeRoute(const EditProfileScreen());
      case favorites:
        return fadeRoute(const FavoritesScreen());
      case helpCenter:
        return fadeRoute(const HelpCenterScreen());
      case setNewPassword:
        return fadeRoute(const SetNewPasswordScreen());
      case legalAndPolicies:
        return fadeRoute(const LegalAndPoliciesScreen());
      case privacyPolicy:
        return fadeRoute(const PrivacyPolicyScreen());
      case termsAndConditions:
        return fadeRoute(const TermsAndConditionsScreen());
      case faq:
        return fadeRoute(const FAQScreen());
      case chatDetail:
        return fadeRoute(const ChatDetailScreen());
      case savedAddresses:
        return fadeRoute(const SavedAddressesScreen());
      case paymentMethods:
        return fadeRoute(const PaymentMethodsScreen());
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
        return fadeRoute(const HomePage());
      default:
        return fadeRoute(
          const Scaffold(body: Center(child: Text(AppStrings.unknownRoute))),
        );
    }
  }
}
