import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';

class ResetCodeErrorText extends StatelessWidget {
  const ResetCodeErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    final isError = context.select<ForgotPasswordCubit, bool>(
      (c) => c.state is ResetCodeVerifyFailure,
    );
    if (!isError) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        context.tr('otpCodeError'),
        textAlign: TextAlign.center,
        style: AppText.ibmError12(),
      ),
    );
  }
}
