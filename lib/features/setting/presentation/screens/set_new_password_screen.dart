import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_text_field.dart';

class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CustomTextField(
                label: AppStrings.passwordNow,
                hintText: AppStrings.enterPassword,
                // fillColor: AppColors.inputBg,
                textStyle: AppText.regularIbm(
                  color: AppColors.placeholder,
                  fontSize: 15,
                ),
                borderColor: AppColors.placeholder,
                // AppColors.borderInputs
              ),
              const ForgetPasswordText(),
              verticalSpace(16),
              CustomTextField(
                textStyle: AppText.regularIbm(
                  color: AppColors.placeholder,
                  fontSize: 15,
                ),
                label: AppStrings.newPassword,
                hintText: AppStrings.enterPassword,
                borderColor: AppColors.placeholder,
              ),
              verticalSpace(16),
              CustomTextField(
                textStyle: AppText.regularIbm(
                  color: AppColors.placeholder,
                  fontSize: 15,
                ),
                label: AppStrings.confirmPassword,
                hintText: AppStrings.reEnterPassword,
                borderColor: AppColors.placeholder,
              ),
              const Spacer(),
              CustomButtom(
                text: AppStrings.confirm,
                onTap: () {
                  // TODO: Implement password reset logic
                },
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

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 2,
          children: [
            Text(
              'نسيت كلمة المرورو؟',
              textAlign: TextAlign.center,
              style: AppText.regularIbm(
                fontSize: 14,

                color: const Color(0xFF189AB4) /* primary */,
              ),
            ),

            Container(
              width: width(context) / 4,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFF189AB4) /* primary */,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
