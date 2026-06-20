import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
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
                context.l10n.setNewPassword,
                style: AppText.ibmHeading20(color: AppColors.primaryText),
              ),
              verticalSpace(8),
              Text(
                context.l10n.setNewPasswordDescription,
                style: AppText.ibmDescription14(color: AppColors.body),
              ),
              verticalSpace(32),
              PasswordTextField(
                label: context.l10n.passwordNow,
                hintText: context.l10n.enterPassword,
              ),
              const ForgetPasswordLink(),
              verticalSpace(16),
              PasswordTextField(
                label: context.l10n.newPassword,
                hintText: context.l10n.enterPassword,
              ),
              verticalSpace(16),
              PasswordTextField(
                label: context.l10n.confirmPasswordLabel,
                hintText: context.l10n.confirmPasswordPlaceholder,
              ),
              const Spacer(),
              CustomButtom(
                text: context.l10n.confirm,
                onTap: () {},
                startColor: AppColors.bgDisabled,
                endColor: AppColors.bgDisabled,
                textStyle: AppText.ibmButton16(color: AppColors.softWhite),
              ),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
