import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';
import '../../../../../core/utils/l10n/app_strings.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/auth_state.dart';

mixin SignInLogic<T extends StatefulWidget> on State<T> {
  // Controllers
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  // State
  bool rememberMe = false;
  bool hasError = false;

  // Computed properties
  bool get canSubmit =>
      emailCtrl.text.trim().isNotEmpty && passwordCtrl.text.isNotEmpty;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  // Methods
  void onFieldChanged(String _) {
    if (hasError) {
      setState(() => hasError = false);
    }
  }

  void onRememberMeChanged(bool? value) {
    setState(() => rememberMe = value ?? false);
  }

  void onLogin(BuildContext context) {
    if (!canSubmit) return;

    setState(() => hasError = false);

    context.read<AuthCubit>().loginWithEmail(
      emailCtrl.text.trim(),
      passwordCtrl.text,
    );
  }

  void onForgotPassword(BuildContext context) {
    context.push(AppRouter.forgetPassword);
  }

  void onGoogleSignIn(BuildContext context) {
    _showComingSoon(context, 'جاري تطوير تسجيل الدخول عبر Google');
  }

  void onAppleSignIn(BuildContext context) {
    _showComingSoon(context, 'جاري تطوير تسجيل الدخول عبر Apple');
  }

  void onSignUp(BuildContext context) {
    context.go(AppRouter.signUp);
  }

  void handleState(BuildContext context, AuthState state) {
    if (state is SignInSuccess) {
      setState(() => hasError = false);
      context.go(AppRouter.home);
    } else if (state is SignInInvalidCredentials) {
      setState(() => hasError = true);
      _showError(context, AppStrings.errorIncorrectPassword);
    } else if (state is SignInError) {
      setState(() => hasError = false);
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
