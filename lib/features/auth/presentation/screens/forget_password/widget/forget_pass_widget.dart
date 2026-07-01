import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';

class ForgetHeader extends StatelessWidget {
  const ForgetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 32.h),
        Center(
          child: Image.asset(
            AppAssets.forgot,
            width: 200.w,
            height: 200.w,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 32.h),
        Text(
          context.tr('resetPassword'),
          textAlign: TextAlign.center,
          style: AppText.ibmHeading22(color: AppColors.dark),
        ),
        SizedBox(height: 10.h),
        Text(
          context.tr('resetPasswordDescription'),
          textAlign: TextAlign.center,
          style: AppText.ibmDescription14(color: AppColors.secondaryText),
        ),
      ],
    );
  }
}

class ForgetEmailField extends StatelessWidget {
  final TextEditingController controller;

  const ForgetEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      label: context.tr('emailLabel'),
      hint: context.tr('emailLabel'),
      controller: controller,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class ForgetSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ForgetSubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        final isLoading = state is ResetCodeSendLoading;
        return AuthPrimaryButton(
          label: context.tr('sendCode'),
          isLoading: isLoading,
          isEnabled: !isLoading,
          onPressed: onPressed,
        );
      },
    );
  }
}
