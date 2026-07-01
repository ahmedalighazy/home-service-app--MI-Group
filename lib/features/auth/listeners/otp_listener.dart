import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import '../../../core/utils/helpers/app_snackbar.dart';

class OtpListener extends StatelessWidget {
  final String email;
  final Widget child;

  const OtpListener({super.key, required this.email, required this.child});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    if (!cubit.otpInitialized) {
      cubit.initOtp(email);
      cubit.otpFocusNode.requestFocus();
    }

    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is OtpVerifySuccess ||
          current is OtpVerifyFailure ||
          current is OtpSendSuccess,
      listener: (context, state) {
        if (state is OtpVerifySuccess) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              context.go(AppRouter.completeProfile, extra: email);
            }
          });
        } else if (state is OtpVerifyFailure) {
          AppSnackBar.showError(context, state.message);
        } else if (state is OtpSendSuccess) {
          AppSnackBar.showSuccess(context, state.message ?? '');
        }
      },
      child: child,
    );
  }
}
