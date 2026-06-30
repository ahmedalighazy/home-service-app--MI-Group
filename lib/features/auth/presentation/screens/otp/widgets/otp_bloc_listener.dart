import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
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
    final cubit = context.watch<AuthCubit>();

    if (!cubit.uiState.otpInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cubit.initOtp(email);
        cubit.controllers.otpFocusNode.requestFocus();
      });
    }

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is OtpVerifiedState) {
          cubit.setOtpFieldState(OtpFieldState.success);
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) context.go(AppRouter.completeProfile, extra: email);
          });
        } else if (state is OtpErrorState || state is AuthErrorState) {
          cubit.setOtpFieldState(OtpFieldState.error);
          cubit.uiState.otpAnimation.startShake();
          final msg = state is OtpErrorState ? state.message : (state as AuthErrorState).message;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(msg), backgroundColor: AppColors.errorRed, behavior: SnackBarBehavior.floating));
        } else if (state is OtpSentState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(LocalizationService.instance.translate('otpResendSuccess')), backgroundColor: AppColors.greenPrimary, behavior: SnackBarBehavior.floating));
        }
      },
      child: child,
    );
  }
}
