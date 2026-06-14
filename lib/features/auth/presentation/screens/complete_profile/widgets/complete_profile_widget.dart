import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../../../../core/utils/l10n/app_strings.dart';


class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.light,
              border: Border.all(
                color: AppColors.borderInputs,
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.person_outline_rounded,
              size: 48.sp,
              color: AppColors.gray,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.borderInputs,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(
                Icons.edit_outlined,
                size: 14.sp,
                color: AppColors.greenPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompleteProfileHeader extends StatelessWidget {
  const CompleteProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.completeProfile,
          textAlign: TextAlign.center,
          style: AppText.ibmHeading22(
            color: AppColors.dark,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          AppStrings.completeProfileSubtitle,
          textAlign: TextAlign.center,
          style: AppText.ibmDescription14(
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}