import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class ChatStatusBadge extends StatelessWidget {
  const ChatStatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: ShapeDecoration(
        color: AppColors.greenPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)),
        shadows: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        AppStrings.open,
        style: AppText.semiBoldIbm(color: AppColors.white, fontSize: 12),
      ),
    );
  }
}
