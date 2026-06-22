import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

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

        decoration: ShapeDecoration(
          color: Colors.white ,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFFF1F5F9) ,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),

        child: Row(
          children: [
            SvgPicture.asset(
              IconsPath.vectorBook,
              width: 18.w,
              height: 18.h,
            ),
            horizontalSpace(12),

            Text(
              title,
              style: AppText.mediumIbm(
                color: AppColors.primaryText,
                fontSize: 17,
              ),
            ),
            const Spacer(),

            Icon(Icons.chevron_right, color: AppColors.primaryText, size: 24.r),

          ],
        ),
      ),
    );
  }
}
