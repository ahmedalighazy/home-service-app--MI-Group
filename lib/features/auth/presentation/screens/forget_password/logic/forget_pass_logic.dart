import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/auth_cubit.dart';
import '../../../cubits/auth_state.dart';
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
      context.read<AuthCubit>().sendResetCode(state.email);
    }
  }

  void handleAuthState(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
    } else if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  void dispose() {
    emailController.dispose();
  }
}