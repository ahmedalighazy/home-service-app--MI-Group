import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../cubits/auth_cubit.dart';
import '../../../states/auth_state.dart';
import '../../../cubits/forget_password_cubit.dart';

class ForgetScreenLogic {
  final TextEditingController emailController = TextEditingController();

  void onEmailChanged(BuildContext context, String value) {
    context.read<ForgetPasswordCubit>().updateEmail(value);
  }

  void onSendResetCode(BuildContext context) {
    context.read<ForgetPasswordCubit>().onSendResetCode();
  }

  void handleForgetPasswordState(BuildContext context, ForgetPasswordState state) {
    if (state is ForgetPasswordSendCodeRequested) {
      getIt<AuthCubit>().sendResetCode(state.email);
    }
  }

  void handleAuthState(BuildContext context, AuthState state) {
    if (state is ResetCodeSentState) {
      context.push(AppRouter.verifyResetCode, extra: state.email);
    } else if (state is AuthErrorState) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(state.message),
          backgroundColor: const Color(0xFFE05C5C),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
    }
  }

  void dispose() {
    emailController.dispose();
  }
}
