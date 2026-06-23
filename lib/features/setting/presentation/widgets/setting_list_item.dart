import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingListItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? settingColorIcon;

  final Widget? trailing;
  final bool? logout;
  final bool? seetingScreen;

  const SettingListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.seetingScreen = false,
    this.settingColorIcon,
    this.titleColor,
    this.logout = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: AppColors.white,
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      trailing:
          trailing ??
          Icon(
            Icons.chevron_right,
            color: settingColorIcon ?? AppColors.greenPrimary,
            size: 24.sp,
          ),
      title: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          title,
          style: AppText.mediumIbm(
            color: titleColor ?? AppColors.primaryText,
            fontSize: 16,
          ),
        ),
      ),
      leading: SvgPicture.asset(
        icon,
        width: 20.w,
        height: 20.h,
        colorFilter: ColorFilter.mode(
          logout == true ? AppColors.redDanger : AppColors.primary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
