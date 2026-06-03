import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class SettingListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      trailing:  const Icon(
        Icons.chevron_left,
        color: AppColors.greenPrimary,
        size: 30,
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 16),
        ),
      ),
    
    leading
      : Icon(
        icon,
        color: AppColors.greenPrimary,
        size: 28,
      ),
    );
  }
}