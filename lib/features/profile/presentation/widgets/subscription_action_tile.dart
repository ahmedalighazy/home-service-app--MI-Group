import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class SubscriptionActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback onTap;
  final bool isDanger;

  const SubscriptionActionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color tileColor = isDanger ? AppColors.redDanger : AppColors.primary;
    final Color titleColor = isDanger
        ? AppColors.redDanger
        : AppColors.primaryText;

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.r,
        color: AppColors.textLightGrey,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(tileColor, BlendMode.srcIn),
            height: 19.w,
            width: 19.h,
          ),

          horizontalSpace(12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.ibmHeading14(color: titleColor)),
                Text(
                  subtitle,
                  style: AppText.ibmDescription12(
                    color: AppColors.textLightGrey,
                  ),
                  // textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
