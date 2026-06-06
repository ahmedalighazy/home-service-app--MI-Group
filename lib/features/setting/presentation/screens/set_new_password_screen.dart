import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';

import '../widgets/forget_password_link.dart';
import '../widgets/password_text_field.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: ''),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(24),
              Text(
                AppStrings.setNewPassword,
                style: AppText.ibmHeading20(color: AppColors.primaryText),
              ),
              verticalSpace(8),
              Text(
                AppStrings.editNewPassDescription,
                style: AppText.ibmDescription14(color: AppColors.body),
              ),
              verticalSpace(32),
              const PasswordTextField(
                label: AppStrings.passwordNow,
                hintText: AppStrings.enterPassword,
              ),
              const ForgetPasswordLink(),
              verticalSpace(16),
              const PasswordTextField(
                label: AppStrings.newPassword,
                hintText: AppStrings.enterPassword,
              ),
              verticalSpace(16),
              const PasswordTextField(
                label: AppStrings.confirmPassword,
                hintText: AppStrings.reEnterPassword,
              ),
              const Spacer(),
              CustomButtom(
                text: AppStrings.confirm,
                onTap: () {},
                startColor: AppColors.bgDisabled,
                endColor: AppColors.bgDisabled,
                textStyle: AppText.ibmButton16(color: AppColors.secondaryGrey),
              ),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
