import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/states/auth_state.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class CompleteProfileLogic {
  final VoidCallback onStateChanged;
  final TickerProvider vsync;

  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final identifierCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  bool obscurePass = true;
  bool obscureConfirm = true;

  late AnimationController animCtrl;
  late Animation<double> fadeAnim;
  late Animation<Offset> slideAnim;

  CompleteProfileLogic({required this.onStateChanged, required this.vsync}) {
    _initAnimations();
  }

  void _initAnimations() {
    animCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 500),
    );
    fadeAnim = CurvedAnimation(parent: animCtrl, curve: Curves.easeOut);
    slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animCtrl, curve: Curves.easeOut));
    animCtrl.forward();
  }

  void toggleObscurePass() {
    obscurePass = !obscurePass;
    onStateChanged();
  }

  void toggleObscureConfirm() {
    obscureConfirm = !obscureConfirm;
    onStateChanged();
  }

  void onComplete({required BuildContext context, String email = ''}) {
    if (!formKey.currentState!.validate()) return;
    getIt<AuthCubit>().register(
      name: nameCtrl.text.trim(),
      email: identifierCtrl.text.trim().isNotEmpty
          ? identifierCtrl.text.trim()
          : email,
      phone: '',
      password: passCtrl.text,
    );
  }

  void handleState(BuildContext context, AuthState state) {
    if (state is AuthSuccessState && state.action == 'profile_completed') {
      if (context.mounted) context.go(AppRouter.home);
    } else if (state is AuthErrorState) {
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
    animCtrl.dispose();
    nameCtrl.dispose();
    identifierCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
  }
}
