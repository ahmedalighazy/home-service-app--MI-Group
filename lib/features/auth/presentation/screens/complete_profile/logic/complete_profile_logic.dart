import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_state.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class CompleteProfileLogic {
  final VoidCallback onStateChanged;

  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  bool obscurePass = true;
  bool obscureConfirm = true;

  CompleteProfileLogic({required this.onStateChanged});

  void toggleObscurePass() {
    obscurePass = !obscurePass;
    onStateChanged();
  }

  void toggleObscureConfirm() {
    obscureConfirm = !obscureConfirm;
    onStateChanged();
  }

  void onComplete({required BuildContext context, required String phoneNumber}) {
    if (!formKey.currentState!.validate()) return;
    context.read<AuthCubit>().register(
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      phone: phoneNumber,
      password: passCtrl.text,
    );
  }

  void handleState(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      context.go(AppRouter.home);
    } else if (state is AuthError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.message,
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

  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
  }
}