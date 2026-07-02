import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_btn_data.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_confirm_button.dart';
import 'verify_reset_code_scaffold.dart';

class ResetCodeConfirmButton extends StatelessWidget {
  final String email;

  const ResetCodeConfirmButton({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final btnData = context.select<ForgotPasswordCubit, OtpBtnData>((c) {
      final s = c.state;
      final isError = s is ResetCodeVerifyFailure;
      return OtpBtnData(
        isLoading: s is ResetCodeVerifyLoading,
        isSuccess: s is ResetCodeVerifySuccess,
        isError: isError,
      );
    });
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: cubit.resetCodeCtrl,
        builder: (context, value, _) {
          final digitsLen = value.text.length;
          return OtpConfirmButton(
            label: context.tr('confirm'),
            isLoading: btnData.isLoading,
            isSuccess: btnData.isSuccess,
            isEnabled:
                digitsLen == VerifyResetCodeScaffold.length && !btnData.isError,
            onPressed: digitsLen == VerifyResetCodeScaffold.length
                ? () {
                    cubit.resetFocusNode.unfocus();
                    cubit.passwordVerifyOtp(email, value.text);
                  }
                : () {},
          );
        },
      ),
    );
  }
}
