import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';
import '../../../core/utils/helpers/app_snackbar.dart';

class VerifyResetCodeListener extends StatelessWidget {
  final String email;
  final Widget child;

  const VerifyResetCodeListener({
    super.key,
    required this.email,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.resetFocusNode.requestFocus();
    if (cubit.resetCodeTimer == null) {
      cubit.initResetCodeTimer(email);
    }

    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          current is ResetCodeVerifySuccess ||
          current is ResetCodeVerifyFailure ||
          current is ResetCodeSendSuccess ||
          current is ResetCodeSendFailure,
      listener: (context, state) {
        if (state is ResetCodeVerifySuccess) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              context.push(
                AppRouter.setNewPassword,
                extra: <String, dynamic>{
                  'email': email,
                  'code': cubit.resetCodeCtrl.text,
                },
              );
            }
          });
        } else if (state is ResetCodeVerifyFailure) {
          cubit.resetCodeCtrl.clear();

          AppSnackBar.showError(context, state.message);
        } else if (state is ResetCodeSendSuccess) {
          AppSnackBar.showSuccess(context, state.message ?? '');
        } else if (state is ResetCodeSendFailure) {
          AppSnackBar.showError(context, state.message);
        }
      },
      child: child,
    );
  }
}
