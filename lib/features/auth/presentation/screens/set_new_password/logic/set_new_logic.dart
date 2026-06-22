import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/states/auth_state.dart';
import '../../../../../../core/di/injection.dart';

class SetNewPasswordLogic {
  final VoidCallback onStateChanged;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String password = '';
  String confirmPassword = '';

  SetNewPasswordLogic({required this.onStateChanged}) {
    passwordController.addListener(() {
      password = passwordController.text;
      onStateChanged();
    });
    confirmPasswordController.addListener(() {
      confirmPassword = confirmPasswordController.text;
      onStateChanged();
    });
  }

  bool get isEmpty => password.isEmpty || confirmPassword.isEmpty;
  bool get isError => !isEmpty && password != confirmPassword;
  bool get isSuccess => !isEmpty && password == confirmPassword;

  Color getBorderColor() {
    if (isError) return AppColors.errorRed;
    if (isSuccess) return AppColors.greenPrimary;
    return AppColors.borderInputs;
  }

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    onStateChanged();
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    onStateChanged();
  }

  void onConfirm({
    required BuildContext context,
    required String email,
    required String code,
  }) {
    if (password.isEmpty || password != confirmPassword) return;
    getIt<AuthCubit>().resetPassword(
      email: email,
      code: code,
      newPassword: password,
    );
  }

  void handleState({
    required BuildContext context,
    required AuthState state,
    required VoidCallback onSuccess,
  }) {
    if (state is AuthSuccessState && state.action == 'password_reset') {
      onSuccess();
      return;
    }

    String? errorMsg;
    if (state is PasswordResetErrorState) {
      errorMsg = state.message;
    } else if (state is AuthErrorState) {
      errorMsg = state.message;
    }

    if (errorMsg != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(errorMsg),
          backgroundColor: AppColors.errorRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
    }
  }

  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
