import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class DeleteRuleItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const DeleteRuleItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.redDanger, size: 20.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppText.mediumIbm(color: AppColors.textDarkGrey, fontSize: 14),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: AppText.regularIbm(color: AppColors.textLightGrey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}