import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/spacing.dart';

class HelpCenterItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const HelpCenterItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              IconsPath.container, // Arrow forward
              width: 7.4.w,
              height: 12.h,
            ),
            const Spacer(),
            Text(
              title,
              style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 16),
            ),
            horizontalSpace(12),
            SvgPicture.asset(
              icon,
              width: 24.w,
              height: 24.h,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.help_outline, color: AppColors.primaryText, size: 24.r),
            ),
          ],
        ),
      ),
    );
  }
}
