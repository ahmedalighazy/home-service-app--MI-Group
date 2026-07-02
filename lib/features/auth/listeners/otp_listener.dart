import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import '../../../core/utils/helpers/app_snackbar.dart';

class OtpListener extends StatefulWidget {
  final String email;
  final Widget child;

  const OtpListener({super.key, required this.email, required this.child});

  @override
  State<OtpListener> createState() => _OtpListenerState();
}

class _OtpListenerState extends State<OtpListener> {
  late final RegisterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RegisterCubit>();
    _cubit.initOtp(widget.email);
    _cubit.otpFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _cubit.otpTimer?.stop();
    _cubit.otpInitialized = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is OtpVerifySuccess ||
          current is OtpVerifyFailure ||
          current is OtpSendSuccess,
      listener: (context, state) {
        if (state is OtpVerifySuccess) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!context.mounted) return;
            context.go(AppRouter.completeProfile, extra: widget.email);
          });
        } else if (state is OtpVerifyFailure) {
          AppSnackBar.showError(context, state.message);
        } else if (state is OtpSendSuccess) {
          AppSnackBar.showSuccess(context, state.message ?? '');
        }
      },
      child: widget.child,
    );
  }
}
