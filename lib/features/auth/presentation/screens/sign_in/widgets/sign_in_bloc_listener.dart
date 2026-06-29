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
          current is LoginSuccessState ||
          current is RegisterSuccessState ||
          current is GuestLoginSuccessState ||
          current is AuthErrorState,
      listener: (context, state) {
        if (state is LoginSuccessState ||
            state is RegisterSuccessState ||
            state is GuestLoginSuccessState) {
          context.go(AppRouter.home);
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
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
      },
      child: const SizedBox.shrink(),
    );
  }
}
