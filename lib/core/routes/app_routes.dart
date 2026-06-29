import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/utils/helpers/cache_helper.dart';
import 'package:home_service_app/features/booking/presentation/screens/booking_screen.dart';
import 'package:home_service_app/features/service_details/presentation/cubit/feature_cubit.dart';
import 'package:home_service_app/features/service_details/presentation/views/corporate_services_view.dart';
import 'package:home_service_app/features/service_details/presentation/views/service_details_view.dart';
import 'package:home_service_app/features/service_details/presentation/views/worker_filter_view.dart';
import 'package:home_service_app/features/setting/presentation/screens/terms_and_conditions_screen.dart';
import 'package:home_service_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:home_service_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/otp_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/complete_profile/complete_profile_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/forget_password/forget_password_screen.dart';
import 'package:home_service_app/core/shell/main_shell.dart';
import 'package:home_service_app/features/auth/presentation/screens/verify_reset_code/verify_reset_code_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/set_new_password/set_new_password_screen.dart';
import 'package:home_service_app/features/auth/presentation/screens/password_changed/password_changed_screen.dart';
import 'package:home_service_app/features/profile/presentation/screens/favorites_screen.dart';
import 'package:home_service_app/features/profile/presentation/screens/subscriptions_screen.dart';
import 'package:home_service_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:home_service_app/features/profile/presentation/screens/saved_addresses_screen.dart';
import 'package:home_service_app/features/profile/presentation/screens/payment_methods_screen.dart';
import 'package:home_service_app/features/profile/presentation/screens/contact_us_screen.dart';
import 'package:home_service_app/features/profile/presentation/screens/delete_account_screen.dart';
import 'package:home_service_app/features/profile/presentation/screens/my_visits_screen.dart';
import 'package:home_service_app/features/profile/presentation/screens/subscription_detail_screen.dart';
import 'package:home_service_app/features/booking/presentation/screens/booking_details_screen.dart';
import 'package:home_service_app/features/booking/presentation/screens/reschedule_booking_screen.dart';
import 'package:home_service_app/features/booking/presentation/screens/cancel_booking_screen.dart';
import 'package:home_service_app/features/setting/presentation/screens/chat_detail_screen.dart';
import 'package:home_service_app/features/setting/presentation/screens/faq_screen.dart';
import 'package:home_service_app/features/setting/presentation/screens/help_center_screen.dart';
import 'package:home_service_app/features/setting/presentation/screens/legal_and_policies_screen.dart';
import 'package:home_service_app/features/setting/presentation/screens/privacy_policy_screen.dart';
import 'package:home_service_app/features/setting/presentation/screens/settings_screen.dart';
import 'package:home_service_app/features/notification/presentation/pages/notification_page.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:home_service_app/features/search/presentation/pages/search_page.dart';
import 'package:home_service_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:home_service_app/features/profile/data/models/subscription_model.dart';
import 'package:home_service_app/features/booking/data/models/booking_model.dart';
import 'package:home_service_app/features/auth/presentation/screens/check_your_email/check_your_email_screen.dart';
import 'package:home_service_app/core/di/injection.dart';

import '../../features/setting/presentation/screens/set_new_password_screen.dart';

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
  static const String passwordChangedSuccessfully =
      '/password-changed-successfully';
  static const String home = '/home';
  static const String language = '/language';
  static const String updatePassword = '/update_password';
  static const String helpCenter = '/help_center';
  static const String legalAndPolicies = '/legal_and_policies';
  static const String faq = '/faq';
  static const String chatDetail = '/chat_detail';
  static const String privacyPolicy = '/privacy_policy';
  static const String termsAndConditions = '/terms_and_conditions';
  static const String bookingDetails = '/booking_details';
  static const String rescheduleBooking = '/reschedule_booking';
  static const String cancelBooking = '/cancel_booking';
  static const String serviceDetails = '/service_details';
  static const String workerFilter = '/worker_filter';
  static const String corporateServices = '/corporate_services';
  static const String editProfile = '/edit_profile';
  static const String notification = '/notification';
  static const String search = '/search';
  static const String deleteAccount = '/delete_account';
  static const String savedAddresses = '/saved_addresses';
  static const String subscriptions = '/subscriptions';
  static const String paymentMethods = '/payment_methods';
  static const String setting = '/setting';
  static const String contactUs = '/contact_us';
  static const String myVisits = '/my_visits';
  static const String subscriptionDetail = '/subscription_detail';
  static const String favorites = '/favorites';
  static const String bookings = '/bookings';
  static const String updatePasswordScreen = '/UpdatePasswordScreen';

  static final router = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: updatePasswordScreen,
        builder: (context, state) => const UpdatePasswordScreen(),
      ),
      GoRoute(path: signUp, builder: (context, state) => const SignUpScreen()),
      GoRoute(path: signIn, builder: (context, state) => const SignInScreen()),
      GoRoute(
        path: otp,
        builder: (context, state) =>
            OtpScreen(email: state.extra as String? ?? ''),
      ),
      GoRoute(
        path: completeProfile,
        builder: (context, state) =>
            CompleteProfileScreen(email: state.extra as String?),
      ),
      GoRoute(
        path: forgetPassword,
        builder: (context, state) => const ForgetScreen(),
      ),
      GoRoute(
        path: verifyResetCode,
        builder: (context, state) =>
            VerifyResetCodeScreen(email: state.extra as String? ?? ''),
      ),
      GoRoute(
        path: checkYourEmail,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return VerificationScreen(
            email: extra?['email'] as String? ?? '',
            code: extra?['code'] as String? ?? '',
          );
        },
      ),
      GoRoute(
        path: setNewPassword,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return SetNewPasswordScreen(
            email: extra?['email'] as String? ?? '',
            code: extra?['code'] as String? ?? '',
          );
        },
      ),
      GoRoute(path: home, builder: (context, state) => const MainShell()),
      GoRoute(
        path: favorites,
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: subscriptions,
        builder: (context, state) => const SubscriptionsScreen(),
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: savedAddresses,
        builder: (context, state) => const SavedAddressesScreen(),
      ),
      GoRoute(
        path: paymentMethods,
        builder: (context, state) => const PaymentMethodsScreen(),
      ),
      GoRoute(
        path: contactUs,
        builder: (context, state) => const ContactUsScreen(),
      ),
      GoRoute(
        path: deleteAccount,
        builder: (context, state) => const DeleteAccountScreen(),
      ),
      GoRoute(
        path: myVisits,
        builder: (context, state) => const MyVisitsScreen(),
      ),
      GoRoute(
        path: subscriptionDetail,
        builder: (context, state) => SubscriptionDetailScreen(
          subscription: state.extra as SubscriptionModel,
        ),
      ),
      GoRoute(
        path: bookingDetails,
        builder: (context, state) =>
            BookingDetailsScreen(booking: state.extra as BookingModel),
      ),
      GoRoute(
        path: rescheduleBooking,
        builder: (context, state) => const RescheduleBookingScreen(),
      ),
      GoRoute(
        path: cancelBooking,
        builder: (context, state) => const CancelBookingScreen(),
      ),
      GoRoute(
        path: chatDetail,
        builder: (context, state) => const ChatDetailScreen(),
      ),
      GoRoute(path: faq, builder: (context, state) => const FAQScreen()),
      GoRoute(
        path: helpCenter,
        builder: (context, state) => const HelpCenterScreen(),
      ),
      GoRoute(
        path: legalAndPolicies,
        builder: (context, state) => const LegalAndPoliciesScreen(),
      ),
      GoRoute(
        path: privacyPolicy,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),

      GoRoute(
        path: setting,
        builder: (context, state) => const SettingsScreen(),
      ),

      GoRoute(
        path: notification,
        builder: (context, state) => BlocProvider.value(
          value: getIt<NotificationCubit>(),
          child: const NotificationPage(),
        ),
      ),

      GoRoute(
        path: search,
        builder: (context, state) => BlocProvider(
          create: (_) => SearchCubit(),
          child: const SearchPage(),
        ),
      ),

      GoRoute(
        path: passwordChangedSuccessfully,
        builder: (context, state) => const PasswordChangedSuccessfullyScreen(),
      ),

      GoRoute(
        path: serviceDetails,
        builder: (context, state) => BlocProvider(
          create: (_) => FeatureCubit(),
          child: const ServiceDetailsScreen(),
        ),
      ),

      GoRoute(
        path: workerFilter,
        builder: (context, state) => BlocProvider(
          create: (_) => FeatureCubit(),
          child: WorkerFilterCard(cartTotal: 0),
        ),
      ),

      GoRoute(
        path: corporateServices,
        builder: (context, state) => BlocProvider(
          create: (_) => FeatureCubit(),
          child: const CorporateServicesScreen(),
        ),
      ),

      GoRoute(path: bookings, builder: (context, state) => BookingScreen()),

      GoRoute(
        path: termsAndConditions,
        builder: (context, state) => const TermsAndConditionsScreen(),
      ),
    ],
    redirect: (context, state) {
      if (state.matchedLocation == home) {
        final email = CacheHelper.getData(key: 'email') as String?;
        final loggedIn = email != null && email.isNotEmpty;
        if (!loggedIn) return signIn;
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
  static const String passwordChangedSuccessfully =
      AppRouter.passwordChangedSuccessfully;
  static const String home = AppRouter.home;
  static const String language = AppRouter.language;
}
