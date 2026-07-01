import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';
import '../helpers/app_snackbar.dart';

class CheckYourEmailListener extends StatelessWidget {
  final String email;
  final String code;
  final Widget child;

  const CheckYourEmailListener({
    super.key,
    required this.email,
    required this.code,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

    if (cubit.emailVerificationTimer == null) {
      cubit.initEmailVerification();
      if (code.isNotEmpty && code.length == 6) {
        for (int i = 0; i < 6; i++) {
          cubit.emailVerificationControllers[i].text = code[i];
        }
        cubit.checkEmailVerificationCompletion();
      }
    }

    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          current is ResetCodeVerifySuccess ||
          current is ResetCodeVerifyFailure ||
          current is ResetCodeSendSuccess,
      listener: (context, state) {
        if (state is ResetCodeVerifySuccess) {
          context.push(
            AppRouter.setNewPassword,
            extra: <String, dynamic>{
              'email': email,
              'code': cubit.emailVerificationOtpCode,
            },
          );
        } else if (state is ResetCodeVerifyFailure) {
          AppSnackBar.showError(context, state.message);
        } else if (state is ResetCodeSendSuccess) {
          AppSnackBar.showSuccess(context, state.message ?? '');
        }
      },
      child: child,
    );
  }
}
