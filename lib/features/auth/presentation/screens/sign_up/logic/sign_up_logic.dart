import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../cubits/auth_cubit.dart';
import '../../../cubits/auth_state.dart';
import '../../../validators/sign_up_validator.dart';

mixin SignUpLogic<T extends StatefulWidget> on State<T> {
  // Controllers
  final TextEditingController phoneCtrl = TextEditingController();

  // State
  bool hasError = false;
  String? errorMessage;

  // Computed properties
  bool get canSubmit => phoneCtrl.text.trim().isNotEmpty;
  String get fullPhoneNumber => '+974${phoneCtrl.text.trim()}';

  @override
  void dispose() {
    phoneCtrl.dispose();
    super.dispose();
  }

  // Methods
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

    // Validate
    final error = SignUpValidator.validatePhone(phone);
    if (error != null) {
      setState(() {
        hasError = true;
        errorMessage = error;
      });
      return;
    }

    // Clear errors
    setState(() {
      hasError = false;
      errorMessage = null;
    });

    // Send OTP
    context.read<AuthCubit>().sendSmsCode(fullPhoneNumber);
  }

  void onGuestMode(BuildContext context) {
    context.go(AppRouter.home);
  }

  void onSignIn(BuildContext context) {
    context.go(AppRouter.signIn);
  }

  void onGoogleSignUp(BuildContext context) {
    _showComingSoon(context, 'جاري تطوير التسجيل عبر Google');
  }

  void onAppleSignUp(BuildContext context) {
    _showComingSoon(context, 'جاري تطوير التسجيل عبر Apple');
  }

  void handleState(BuildContext context, AuthState state) {
    if (state is SmsCodeSent) {
      context.push(AppRouter.otp, extra: fullPhoneNumber);
    } else if (state is AuthError) {
      _showError(context, state.message);
    }
  }

  void _showComingSoon(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppText.ibmDescription14(color: AppColors.white),
        ),
        backgroundColor: AppColors.greenPrimary,
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppText.ibmDescription14(color: AppColors.white),
          ),
          backgroundColor: AppColors.errorRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }
}
