import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';
import '../../../core/utils/helpers/app_snackbar.dart';

class SetNewPasswordListener extends StatelessWidget {
  final Widget child;

  const SetNewPasswordListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          current is PasswordResetLoading ||
          current is PasswordResetSuccess ||
          current is PasswordResetFailure,
      listener: (context, state) {
        if (state is PasswordResetLoading) {
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
          if (state is PasswordResetSuccess) {
            context.read<ForgotPasswordCubit>().resetState();
            if (context.mounted) {
              GoRouter.of(context).go(AppRouter.passwordChangedSuccessfully);
            }
          } else if (state is PasswordResetFailure) {
            AppSnackBar.showError(context, state.message);
          }
        }
      },
      child: child,
    );
  }
}
