import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';
import '../../../core/utils/helpers/app_snackbar.dart';

class ForgotPasswordBlocListener extends StatelessWidget {
  const ForgotPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          current is ResetCodeSendLoading ||
          current is ResetCodeSendSuccess ||
          current is ResetCodeSendFailure,
      listener: (context, state) {
        if (state is ResetCodeSendLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(color: Color(0xFF189AB4)),
            ),
          );
        } else {
          try {
            Navigator.of(context, rootNavigator: true).pop();
          } catch (_) {}
          if (state is ResetCodeSendSuccess) {
            context.push(AppRouter.verifyResetCode, extra: state.email);
          } else if (state is ResetCodeSendFailure) {
            AppSnackBar.showError(context, state.message);
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
