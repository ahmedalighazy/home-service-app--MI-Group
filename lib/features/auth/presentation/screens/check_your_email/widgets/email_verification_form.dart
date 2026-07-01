import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'otp_circle_field.dart';
import 'check_email_header.dart';
import 'check_email_resend_row.dart';

class EmailVerificationForm extends StatelessWidget {
  final String email;

  const EmailVerificationForm({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        verticalSpace(24.h),
        CheckEmailHeader(email: email),
        verticalSpace(16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: OtpCircleField(
                  controller: cubit.emailVerificationControllers[index],
                  focusNode: cubit.emailVerificationFocusNodes[index],
                  onChanged: (value) {
                    if (value.length == 1 && index < 5) {
                      cubit.emailVerificationFocusNodes[index + 1]
                          .requestFocus();
                    } else if (value.isEmpty && index > 0) {
                      cubit.emailVerificationFocusNodes[index - 1]
                          .requestFocus();
                    }
                    cubit.checkEmailVerificationCompletion();
                  },
                ),
              ),
            );
          }),
        ),
        verticalSpace(32.h),
        CheckEmailResendRow(
          onResend: () {
            if (cubit.emailVerificationTimerActive) return;
            cubit.sendResetCode(email);
            cubit.initEmailVerification();
          },
        ),
        verticalSpace(36.h),
        BlocSelector<ForgotPasswordCubit, ForgotPasswordState, bool>(
          selector: (state) => state is ResetCodeVerifyLoading,
          builder: (context, isLoading) {
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.greenPrimary,
                ),
              );
            }
            return AuthPrimaryButton(
              label: context.tr('confirm'),
              isEnabled: cubit.emailVerificationButtonEnabled,
              onPressed: () {
                if (!cubit.emailVerificationButtonEnabled) return;
                cubit.verifyResetCode(
                    email, cubit.emailVerificationOtpCode);
              },
            );
          },
        ),
        verticalSpace(24.h),
      ],
    );
  }
}
