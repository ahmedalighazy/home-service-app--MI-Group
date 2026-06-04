import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

class AddAddressDashedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const AddAddressDashedButton({
    super.key,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.1),
            width: 1.5,
            style: BorderStyle.solid, // For real dashed border, CustomPainter or package like dotted_border is needed.
            // But since the design shows a light border, I'll use solid with low alpha or simulate dashes
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppColors.primary, size: 24.r),
            horizontalSpace(8),
            Text(
              label,
              style: AppText.ibmHeading16(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
