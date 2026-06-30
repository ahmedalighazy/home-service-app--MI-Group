import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        final cubit = context.read<AuthCubit>();
        if (state is ResetCodeVerifiedState) {
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
        } else if (state is ResetCodeError || state is AuthErrorState) {
          cubit.setResetFieldState(OtpFieldState.error);
          cubit.uiState.resetAnimation.startShake();
          final msg = state is ResetCodeError ? state.message : (state as AuthErrorState).message;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(msg),
              backgroundColor: AppColors.errorRed,
              behavior: SnackBarBehavior.floating,
            ));
        } else if (state is ResetCodeSentState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(LocalizationService.instance.translate('resendCodeSuccess')),
              backgroundColor: AppColors.greenPrimary,
              behavior: SnackBarBehavior.floating,
            ));
        }
      },
      child: child,
    );
  }
}
