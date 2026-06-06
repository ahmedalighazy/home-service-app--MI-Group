import 'package:flutter/material.dart';
import 'package:home_service_app/features/home/presentation/pages/home_page.dart';

import '../../features/auth/presentation/screens/language_selection/language_selection_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_one_content.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_one_static.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_two_content.dart';
import '../../features/onboarding/presentation/widgets/onboarding_step_two_static.dart';
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
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/language_selection_screen.dart';
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
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String deleteAccount = '/delete-account';
  static const String setting = '/setting';
  static const String favorites = '/favorites';
  static const String helpCenter = '/help-center';
  static const String updatePassword = '/Update-password';
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
      case updatePassword:
        return fadeRoute(const UpdatePasswordScreen());
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
      case subscriptions:
        return fadeRoute(const SubscriptionsScreen());
      case subscriptionDetail:
        final subscription = settings.arguments as SubscriptionModel;
        return fadeRoute(SubscriptionDetailScreen(subscription: subscription));
      case myVisits:
        return fadeRoute(const MyVisitsScreen());

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
        return fadeRoute(const HomePage());
      case contactUs:
        return fadeRoute(const ContactUsScreen());

      default:
        return fadeRoute(
          const Scaffold(body: Center(child: Text(AppStrings.unknownRoute))),
        );
    }
  }
}
