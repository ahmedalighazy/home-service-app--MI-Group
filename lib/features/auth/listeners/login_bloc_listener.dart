import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import '../../../core/utils/helpers/app_snackbar.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is LoginLoading ||
          current is LoginSuccess ||
          current is LoginFailure ||
          current is GuestLoginSuccess,
      listener: (context, state) {
        if (state is LoginLoading) {
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
          if (state is LoginSuccess || state is GuestLoginSuccess) {
            context.go(AppRouter.home);
          } else if (state is LoginFailure) {
            AppSnackBar.showError(context, state.message);
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
