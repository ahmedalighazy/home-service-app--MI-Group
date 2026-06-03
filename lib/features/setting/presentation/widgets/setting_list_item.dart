import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class SettingListItem extends StatelessWidget {
  final IconData icon;
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
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      trailing:
          trailing ??
          Icon(
            seetingScreen! ? Icons.chevron_right : Icons.chevron_left,
            color: settingColorIcon ?? AppColors.greenPrimary,
            size: 28,
          ),
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: AppText.mediumIbm(
            color: titleColor ?? AppColors.primaryText,
            fontSize: 16,
          ),
        ),
      ),
      leading: Icon(
        icon,
        color: logout! ? AppColors.red : AppColors.greenPrimary,
        size: 24,
      ),
    );
  }
}
