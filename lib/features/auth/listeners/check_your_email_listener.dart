import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';
import '../../../core/utils/helpers/app_snackbar.dart';

class CheckYourEmailListener extends StatefulWidget {
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
  State<CheckYourEmailListener> createState() => _CheckYourEmailListenerState();
}

class _CheckYourEmailListenerState extends State<CheckYourEmailListener> {
  late final ForgotPasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ForgotPasswordCubit>();
    _cubit.initEmailVerification();
    if (widget.code.isNotEmpty && widget.code.length == 6) {
      for (int i = 0; i < 6; i++) {
        _cubit.emailVerificationControllers[i].text = widget.code[i];
      }
      _cubit.checkEmailVerificationCompletion();
    }
  }

  @override
  void dispose() {
    _cubit.emailVerificationTimer?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          current is ResetCodeVerifySuccess ||
          current is ResetCodeVerifyFailure ||
          current is ResetCodeSendSuccess,
      listener: (context, state) {
        if (state is ResetCodeVerifySuccess) {
          if (!context.mounted) return;

          context.push(
            AppRouter.setNewPassword,
            extra: <String, dynamic>{
              'email': widget.email,
              'code': _cubit.emailVerificationOtpCode,
            },
          );
        } else if (state is ResetCodeVerifyFailure) {
          AppSnackBar.showError(context, state.message);
        } else if (state is ResetCodeSendSuccess) {
          AppSnackBar.showSuccess(context, state.message ?? '');
        }
      },
      child: widget.child,
    );
  }
}
