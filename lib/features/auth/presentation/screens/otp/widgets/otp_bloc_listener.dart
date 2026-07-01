import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'otp_field_state.dart';

class OtpBlocListener extends StatelessWidget {
  final String email;
  final Widget child;

  const OtpBlocListener({
    super.key,
    required this.email,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    if (!cubit.otpInitialized) {
      cubit.initOtp(email);
      cubit.otpFocusNode.requestFocus();
    }

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is OtpVerifySuccess) {
          cubit.setOtpFieldState(OtpFieldState.success);
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) context.go(AppRouter.completeProfile, extra: email);
          });
        } else if (state is OtpVerifyFailure) {
          cubit.setOtpFieldState(OtpFieldState.error);
          cubit.otpAnimation.startShake();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorRed,
              behavior: SnackBarBehavior.floating,
            ));
        } else if (state is OtpSendSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(context.tr('otpResendSuccess')),
              backgroundColor: AppColors.greenPrimary,
              behavior: SnackBarBehavior.floating,
            ));
        }
      },
      child: child,
    );
  }
}
