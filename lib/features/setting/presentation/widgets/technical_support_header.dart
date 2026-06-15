import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

import 'new_issue_bottom_sheet.dart';

class TechnicalSupportHeader extends StatelessWidget {
  const TechnicalSupportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.technicalSupport,
          style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 16),
        ),
        ElevatedButton(
          onPressed: () => _showNewIssueSheet(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(44.r),
            ),
            shadowColor: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            minimumSize: Size(118.w, 36.h),
          ),
          child: Text(
            AppStrings.newIssue,
            style: AppText.ibmButton16(
              color: AppColors.greenPrimary,
            ).copyWith(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  void _showNewIssueSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NewIssueBottomSheet(),
    );
  }
}
