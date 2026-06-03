import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/extention_navigator.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../widgets/setting_list_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: AppStrings.settings),
      body: Column(
        children: [
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: Icons.lock_outline,
            title: AppStrings.changePassword,
            onTap: () {
              context.pushName(AppRoutes.setNewPassword);
              // TODO: Navigate to change password
            },
          ),
          _buildDivider(),
          SettingListItem(
            icon: Icons.language_outlined,
            title: AppStrings.language,
            trailing: Text(
              AppStrings.arabic,
              style: AppText.regularIbm(
                color: AppColors.textLightGrey,
                fontSize: 14,
              ),
            ),
            onTap: () {
              // TODO: Open language selection
            },
          ),
          _buildDivider(),
          _buildToggleItem(
            icon: Icons.notifications_none_outlined,
            title: AppStrings.bookingNotifications,
            value: _notificationsEnabled,
            onChanged: (val) {
              setState(() {
                _notificationsEnabled = val;
              });
            },
          ),
          _buildDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: Icons.help_outline,
            title: AppStrings.helpCenter,
            onTap: () {
              context.pushName(AppRoutes.helpCenter);
            },
          ),
          _buildDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: Icons.gavel_outlined, // Using legal icon
            title: AppStrings.policiesAndRules,
            onTap: () {
              context.pushName(AppRoutes.legalAndPolicies);
            },
          ),
          _buildDivider(),
          SettingListItem(
            icon: Icons.logout,
            title: AppStrings.logout,
            logout: true,
            seetingScreen: true,
            settingColorIcon: AppColors.red,
            titleColor: AppColors.red,
            onTap: () {
              // TODO: Handle logout
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: AppColors.whitecancel);
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(icon, color: AppColors.greenPrimary, size: 24.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: AppText.mediumIbm(
                color: AppColors.primaryText,
                fontSize: 16,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.greenPrimary,
            inactiveTrackColor: AppColors.dividerGrey,
          ),
        ],
      ),
    );
  }
}
