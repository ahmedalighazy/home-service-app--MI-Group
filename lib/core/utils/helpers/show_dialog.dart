import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../features/profile/presentation/widgets/custom_buttom.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/text/app_text.dart';
import '../l10n/app_strings.dart';

void showCannotDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          contentPadding: EdgeInsets.all(20.w),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.cannotDeleteTitle,
                style: AppText.boldIbm(color: AppColors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                AppStrings.cannotDeleteDesc,
                style: AppText.regularIbm(color: AppColors.textLightGrey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              CustomButton(
                text: AppStrings.okBtn,
                backgroundColor: AppColors.tealPrimary,
                textColor: AppColors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    },
  );
}
