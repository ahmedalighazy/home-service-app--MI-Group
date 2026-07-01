import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';

class VerifyResetCodeBlocListener extends StatelessWidget {
  final String email;
  final Widget child;

  const VerifyResetCodeBlocListener({
    super.key,
    required this.email,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    cubit.resetFocusNode.requestFocus();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetCodeVerifySuccess) {
          cubit.setResetFieldState(OtpFieldState.success);
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              context.push(
                AppRouter.setNewPassword,
                extra: <String, dynamic>{
                  'email': email,
                  'code': cubit.resetCodeCtrl.text,
                },
              );
            }
          });
        } else if (state is ResetCodeVerifyFailure) {
          cubit.setResetFieldState(OtpFieldState.error);
          cubit.resetAnimation.startShake();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorRed,
              behavior: SnackBarBehavior.floating,
            ));
        } else if (state is ResetCodeSendSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(context.tr('resendCodeSuccess')),
              backgroundColor: AppColors.greenPrimary,
              behavior: SnackBarBehavior.floating,
            ));
        }
      },
      child: child,
    );
  }
}
