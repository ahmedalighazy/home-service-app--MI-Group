import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import '../../../core/utils/helpers/app_snackbar.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is OtpSendLoading ||
          current is OtpSendSuccess ||
          current is OtpSendFailure,
      listener: (context, state) {
        if (state is OtpSendLoading) {
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
          if (state is OtpSendSuccess) {
            context.push(AppRouter.otp, extra: state.email);
          } else if (state is OtpSendFailure) {
            AppSnackBar.showError(context, state.message);
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
