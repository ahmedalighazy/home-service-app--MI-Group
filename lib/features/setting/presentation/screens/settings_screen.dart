import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/extention_navigator.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../widgets/setting_list_item.dart';
import '../widgets/settings_divider.dart';
import '../widgets/settings_toggle_item.dart';

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
            onTap: () => context.pushName(AppRoutes.setNewPassword),
          ),
          const SettingsDivider(),
          SettingListItem(
            icon: Icons.language_outlined,
            title: AppStrings.language,
            trailing: _LanguageTrailingText(),
            onTap: () {},
          ),
          const SettingsDivider(),
          SettingsToggleItem(
            icon: Icons.notifications_none_outlined,
            title: AppStrings.bookingNotifications,
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: Icons.help_outline,
            title: AppStrings.helpCenter,
            onTap: () => context.pushName(AppRoutes.helpCenter),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: Icons.gavel_outlined,
            title: AppStrings.policiesAndRules,
            onTap: () => context.pushName(AppRoutes.legalAndPolicies),
          ),
          const SettingsDivider(),
          SettingListItem(
            icon: Icons.logout,
            title: AppStrings.logout,
            logout: true,
            seetingScreen: true,
            settingColorIcon: AppColors.red,
            titleColor: AppColors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _LanguageTrailingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.arabic,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppColors.textLightGrey,
        fontSize: 14,
      ),
    );
  }
}
