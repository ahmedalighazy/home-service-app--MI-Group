import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:home_service_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:home_service_app/features/notification/presentation/pages/notification_page.dart';
import 'package:home_service_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:home_service_app/features/search/presentation/pages/search_page.dart';
import 'package:home_service_app/features/home/presentation/pages/home_page.dart';
import '../../features/auth/presentation/screens/forget_password/forget_password_screen.dart';
import '../../features/auth/presentation/screens/complete_profile/complete_profile_screen.dart';
import '../../features/auth/presentation/screens/otp/otp_screen.dart';
import '../../features/auth/presentation/screens/set_new_password/set_new_password_screen.dart';
import '../../features/auth/presentation/screens/sign_in/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import '../../features/auth/presentation/screens/verify_reset_code/verify_reset_code_screen.dart';
import '../../features/booking/presentation/screens/booking_screen.dart';
import '../../features/booking/presentation/screens/booking_details_screen.dart';
import '../../features/booking/presentation/screens/reschedule_booking_screen.dart';
import '../../features/booking/presentation/screens/cancel_booking_screen.dart';
import '../../features/booking/data/models/booking_model.dart';
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

class AppRouter {
  // Private constructor
  AppRouter._();

  // ============ Route Names Constants ============
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
  static const String search = '/search';
  static const String notification = '/notification';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String deleteAccount = '/delete-account';
  static const String setting = '/setting';
  static const String favorites = '/favorites';
  static const String helpCenter = '/help-center';
  static const String updatePassword = '/update-password';
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
  static const String serviceDetails = '/service-details';
  static const String workerFilter = '/worker-filter';
  static const String corporateServices = '/corporate-services';
  static const String bookings = '/bookings';
  static const String bookingDetails = '/booking-details';
  static const String rescheduleBooking = '/reschedule-booking';
  static const String cancelBooking = '/cancel-booking';

  // ============ GoRouter Configuration ============
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    // debugLogDiagnostics: true,
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: [
      // Core Routes
      GoRoute(
        path: splash,
        name: splash,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const SplashScreen(), state),
      ),

      GoRoute(
        path: onboarding,
        name: onboarding,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const OnboardingScreen(), state),
      ),

      // Auth Routes
      GoRoute(
        path: signIn,
        name: signIn,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const SignInScreen(), state),
      ),

      GoRoute(
        path: signUp,
        name: signUp,
        pageBuilder: (context, state) => _buildPageWithFade(
          const SignUpScreen(), // تأكد من أن هذا موجود
          state,
        ),
      ),

      GoRoute(
        path: otp,
        name: otp,
        pageBuilder: (context, state) {
          final phoneNumber = state.extra as String? ?? '+974XXXXXXXX';
          return _buildPageWithFade(OtpScreen(phoneNumber: phoneNumber), state);
        },
      ),

      GoRoute(
        path: completeProfile,
        name: completeProfile,
        pageBuilder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return _buildPageWithFade(
            CompleteProfileScreen(phoneNumber: phoneNumber),
            state,
          );
        },
      ),

      GoRoute(
        path: forgetPassword,
        name: forgetPassword,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const ForgetScreen(), state),
      ),

      GoRoute(
        path: verifyResetCode,
        name: verifyResetCode,
        pageBuilder: (context, state) {
          final email = state.extra as String? ?? 'example@email.com';
          return _buildPageWithFade(VerifyResetCodeScreen(email: email), state);
        },
      ),

      GoRoute(
        path: setNewPassword,
        name: setNewPassword,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, String>?;
          return _buildPageWithFade(
            SetNewPasswordScreen(
              email: args?['email'] ?? '',
              code: args?['code'] ?? '',
            ),
            state,
          );
        },
      ),

      // Main App Routes
      GoRoute(
        path: home,
        name: home,
        pageBuilder: (context, state) => _buildPageWithFade(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<HomeCubit>()..getHomeData()),
              BlocProvider(create: (_) => getIt<AddressCubit>()),
            ],
            child: const HomePage(),
          ),
          state,
        ),
      ),

      GoRoute(
        path: search,
        name: search,
        pageBuilder: (context, state) => _buildPageWithFade(
          BlocProvider(create: (_) => SearchCubit(), child: const SearchPage()),
          state,
        ),
      ),

      GoRoute(
        path: notification,
        name: notification,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const NotificationPage(), state),
      ),

      GoRoute(
        path: profile,
        name: profile,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const ProfileScreen(), state),
      ),

      GoRoute(
        path: editProfile,
        name: editProfile,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const EditProfileScreen(), state),
      ),

      GoRoute(
        path: deleteAccount,
        name: deleteAccount,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const DeleteAccountScreen(), state),
      ),

      GoRoute(
        path: setting,
        name: setting,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const SettingsScreen(), state),
      ),

      GoRoute(
        path: favorites,
        name: favorites,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const FavoritesScreen(), state),
      ),

      GoRoute(
        path: helpCenter,
        name: helpCenter,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const HelpCenterScreen(), state),
      ),

      GoRoute(
        path: updatePassword,
        name: updatePassword,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const UpdatePasswordScreen(), state),
      ),

      GoRoute(
        path: legalAndPolicies,
        name: legalAndPolicies,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const LegalAndPoliciesScreen(), state),
      ),

      GoRoute(
        path: privacyPolicy,
        name: privacyPolicy,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const PrivacyPolicyScreen(), state),
      ),

      GoRoute(
        path: termsAndConditions,
        name: termsAndConditions,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const TermsAndConditionsScreen(), state),
      ),

      GoRoute(
        path: faq,
        name: faq,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const FAQScreen(), state),
      ),

      GoRoute(
        path: chatDetail,
        name: chatDetail,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const ChatDetailScreen(), state),
      ),

      GoRoute(
        path: savedAddresses,
        name: savedAddresses,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const SavedAddressesScreen(), state),
      ),

      GoRoute(
        path: paymentMethods,
        name: paymentMethods,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const PaymentMethodsScreen(), state),
      ),

      GoRoute(
        path: subscriptions,
        name: subscriptions,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const SubscriptionsScreen(), state),
      ),

      GoRoute(
        path: subscriptionDetail,
        name: subscriptionDetail,
        pageBuilder: (context, state) {
          final subscription = state.extra as SubscriptionModel?;
          return _buildPageWithFade(
            SubscriptionDetailScreen(subscription: subscription!),
            state,
          );
        },
      ),

      GoRoute(
        path: myVisits,
        name: myVisits,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const MyVisitsScreen(), state),
      ),

      GoRoute(
        path: contactUs,
        name: contactUs,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const ContactUsScreen(), state),
      ),

      GoRoute(
        path: serviceDetails,
        name: serviceDetails,
        pageBuilder: (context, state) => _buildPageWithFade(
          BlocProvider(
            create: (_) => FeatureCubit(),
            child: const ServiceDetailsScreen(),
          ),
          state,
        ),
      ),

      GoRoute(
        path: workerFilter,
        name: workerFilter,
        pageBuilder: (context, state) => _buildPageWithFade(
          BlocProvider(
            create: (_) => FeatureCubit(),
            child: WorkerFilterCard(
              cartTotal: _cartTotalFromExtra(state.extra),
            ),
          ),
          state,
        ),
      ),

      GoRoute(
        path: corporateServices,
        name: corporateServices,
        pageBuilder: (context, state) => _buildPageWithFade(
          BlocProvider(
            create: (_) => FeatureCubit(),
            child: const CorporateServicesScreen(),
          ),
          state,
        ),
      ),
      GoRoute(
        path: bookings,
        name: bookings,
        pageBuilder: (context, state) =>
            _buildPageWithFade(BookingScreen(), state),
      ),
      GoRoute(
        path: bookingDetails,
        name: bookingDetails,
        pageBuilder: (context, state) {
          final booking = state.extra as BookingModel;
          return _buildPageWithFade(
            BookingDetailsScreen(booking: booking),
            state,
          );
        },
      ),
      GoRoute(
        path: rescheduleBooking,
        name: rescheduleBooking,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const RescheduleBookingScreen(), state),
      ),
      GoRoute(
        path: cancelBooking,
        name: cancelBooking,
        pageBuilder: (context, state) =>
            _buildPageWithFade(const CancelBookingScreen(), state),
      ),
    ],
  );

  // Helper method to build page with fade transition
  static Page<void> _buildPageWithFade(Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static double _cartTotalFromExtra(Object? extra) {
    if (extra is num) return extra.toDouble();
    if (extra is Map && extra['cartTotal'] is num) {
      return (extra['cartTotal'] as num).toDouble();
    }
    return 0;
  }
}

// Error Screen Widget
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'صفحة غير موجودة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                context.go(AppRouter.home);
              },
              child: const Text('الرجوع للرئيسية'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ Delete onGenerateRoute completely ============
// لا تحتاج إلى onGenerateRoute بعد الآن، كل شيء في GoRouter
