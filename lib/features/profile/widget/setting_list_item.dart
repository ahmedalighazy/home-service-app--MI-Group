import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

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
      leading:  const Icon(
        Icons.chevron_left,
        color: AppColors.greenPrimary,
        size: 30,
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style:  TextStyle(
            color:AppColors.primaryText,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      trailing: Icon(
        icon,
        color: AppColors.greenPrimary,
        size: 28,
      ),
    );
  }
}