import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class HelpCenterContactInfo extends StatelessWidget {
  const HelpCenterContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.contactUs,
          style: AppText.ibmHeading16(color: AppColors.primaryText),
        ),
        SizedBox(height: 16.h),
        const _ContactRow(
          icon: Icons.phone_outlined,
          value: AppStrings.customerServiceNumber,
        ),
        SizedBox(height: 12.h),
        const _ContactRow(
          icon: Icons.email_outlined,
          value: AppStrings.supportEmailAddress,
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String value;

  const _ContactRow({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.greenPrimary, size: 20.r),
        SizedBox(width: 12.w),
        Text(
          value,
          style: AppText.ibmDescription14(color: AppColors.primaryText),
        ),
      ],
    );
  }
}
