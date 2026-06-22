import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../cubits/auth_cubit.dart';
import '../../../states/auth_state.dart';
import '../../../validators/sign_up_validator.dart';

mixin SignUpLogic<T extends StatefulWidget> on State<T> {
  final TextEditingController phoneCtrl = TextEditingController();

  bool hasError = false;
  String? errorMessage;

  bool get canSubmit => phoneCtrl.text.trim().isNotEmpty;
  String get fullPhoneNumber => '+974${phoneCtrl.text.trim()}';

  @override
  void dispose() {
    phoneCtrl.dispose();
    super.dispose();
  }

  void onPhoneChanged() {
    if (hasError) {
      setState(() {
        hasError = false;
        errorMessage = null;
      });
    }
  }

  void onSendCode(BuildContext context) {
    final phone = phoneCtrl.text.trim();
    final error = SignUpValidator.validatePhone(phone);
    if (error != null) {
      setState(() {
        hasError = true;
        errorMessage = error;
      });
      return;
    }
    setState(() {
      hasError = false;
      errorMessage = null;
    });
    getIt<AuthCubit>().sendSmsCode(fullPhoneNumber);
  }

  void onGuestMode(BuildContext context) {
    getIt<AuthCubit>().loginAsGuest();
    // Navigation handled by handleState via BlocListener
  }

  void onSignIn(BuildContext context) {
    context.go(AppRouter.signIn);
  }

  void onGoogleSignUp(BuildContext context) {
    getIt<AuthCubit>().signUpWithGoogle();
  }

  void onAppleSignUp(BuildContext context) {
    getIt<AuthCubit>().signUpWithApple();
  }

  void handleState(BuildContext context, AuthState state) {
    if (state is OtpSentState) {
      context.push(AppRouter.otp, extra: fullPhoneNumber);
    } else if (state is AuthSuccessState &&
        (state.action == 'guest_login' ||
            state.action == 'google_sign_up' ||
            state.action == 'apple_sign_up')) {
      if (context.mounted) context.go(AppRouter.home);
    } else if (state is AuthErrorState) {
      _showError(context, state.message);
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message, style: AppText.ibmDescription14(color: AppColors.white)),
        backgroundColor: AppColors.errorRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
  }
}
