import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../cubits/auth_cubit.dart';
import '../../../states/auth_state.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

mixin SignInLogic<T extends StatefulWidget> on State<T> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  bool rememberMe = false;
  bool hasError = false;

  bool get canSubmit =>
      emailCtrl.text.trim().isNotEmpty && passwordCtrl.text.isNotEmpty;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void onFieldChanged(String _) {
    if (hasError) setState(() => hasError = false);
  }

  void onRememberMeChanged(bool? value) {
    setState(() => rememberMe = value ?? false);
  }

  void onLogin(BuildContext context) {
    if (emailCtrl.text.trim().isEmpty || passwordCtrl.text.isEmpty) {
      setState(() => hasError = true);
      _showError(context, context.tr('errorFieldRequired'));
      return;
    }
    setState(() => hasError = false);
    getIt<AuthCubit>().login(
      identifier: emailCtrl.text.trim(),
      password: passwordCtrl.text,
    );
  }

  void onForgotPassword(BuildContext context) {
    context.push(AppRouter.forgetPassword);
  }

  void onGoogleSignIn(BuildContext context) {
    getIt<AuthCubit>().signInWithGoogle();
  }

  void onAppleSignIn(BuildContext context) {
    getIt<AuthCubit>().signInWithApple();
  }

  void onSignUp(BuildContext context) {
    context.go(AppRouter.signUp);
  }

  void handleState(BuildContext context, AuthState state) {
    if (state is AuthSuccessState &&
        (state.action == 'sign_in' ||
            state.action == 'google_sign_in' ||
            state.action == 'apple_sign_in')) {
      // ignore: avoid_print
      print("Navigate To Home");
      if (context.mounted) context.go(AppRouter.home);
    } else if (state is AuthErrorState) {
      setState(() => hasError = true);
      _showError(context, state.message);
    }
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
