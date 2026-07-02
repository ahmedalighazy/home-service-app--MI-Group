import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import '../../../core/utils/helpers/app_snackbar.dart';

class CompleteProfileListener extends StatelessWidget {
  final String? email;
  final Widget child;

  const CompleteProfileListener({super.key, required this.child, this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    if (email != null && email!.isNotEmpty && cubit.emailCtrl.text.isEmpty) {
      cubit.emailCtrl.text = email!;
    }

    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is CompleteProfileLoading ||
          current is CompleteProfileSuccess ||
          current is CompleteProfileFailure,
      listener: (context, state) {
        if (state is CompleteProfileLoading) {
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
          if (state is CompleteProfileSuccess) {
            if (!context.mounted) return;

            context.go(AppRouter.signIn);
          } else if (state is CompleteProfileFailure) {
            AppSnackBar.showError(context, state.message);
          }
        }
      },
      child: child,
    );
  }
}
