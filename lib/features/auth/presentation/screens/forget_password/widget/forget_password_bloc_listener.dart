import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/cubits/forget_password_cubit.dart';

class ForgetPasswordBlocListener extends StatelessWidget {
  const ForgetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
          listenWhen: (previous, current) => current is ForgetPasswordSendCodeRequested,
          listener: (context, state) {
            if (state is ForgetPasswordSendCodeRequested) {
              context.read<AuthCubit>().sendResetCode(state.email);
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              current is ResetCodeSentState || current is AuthErrorState,
          listener: (context, state) {
            if (state is ResetCodeSentState) {
              context.push(AppRouter.verifyResetCode, extra: state.email);
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
        ),
      ],
      child: const SizedBox.shrink(),
    );
  }
}
