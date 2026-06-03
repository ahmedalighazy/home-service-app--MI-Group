import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              _buildBackButton(context),
              verticalSpace(24),
              Text(
                AppStrings.setNewPassword,
                style: AppText.ibmHeading20(color: AppColors.primaryText),
              ),
              verticalSpace(8),
              Text(
                AppStrings.createNewPassDescription,
                style: AppText.ibmDescription14(color: AppColors.body),
              ),
              verticalSpace(32),
              CustomTextField(
                label: AppStrings.password,
                hintText: AppStrings.enterPassword,
                fillColor: AppColors.inputBg,
              ),
              verticalSpace(16),
              CustomTextField(
                label: AppStrings.confirmPassword,
                hintText: AppStrings.reEnterPassword,
                fillColor: AppColors.inputBg,
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

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SvgPicture.asset(
          IconsPath.backButton,
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }
}
