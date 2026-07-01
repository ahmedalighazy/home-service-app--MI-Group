import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';

class SignInBlocListener extends StatelessWidget {
  const SignInBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is LoginSuccess ||
          current is RegisterSuccess ||
          current is GuestLoginSuccess ||
          current is LoginFailure ||
          current is RegisterFailure,
      listener: (context, state) {
        if (state is LoginSuccess ||
            state is RegisterSuccess ||
            state is GuestLoginSuccess) {
          context.go(AppRouter.home);
        } else {
          final msg = switch (state) {
            LoginFailure(message: var m) => m,
            RegisterFailure(message: var m) => m,
            _ => null,
          };
          if (msg != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    msg,
                    style: AppText.ibmDescription14(color: AppColors.white),
                  ),
                  backgroundColor: AppColors.errorRed,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
