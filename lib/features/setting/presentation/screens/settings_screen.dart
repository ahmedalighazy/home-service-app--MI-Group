import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/extention_navigator.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/constants/icons_path.dart';
import '../../../../core/utils/helpers/show_dialog.dart';
import '../widgets/language_trailing_text.dart';
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
            icon: IconsPath.vectorPassword,
            title: AppStrings.changePassword,
            onTap: () => context.pushName(AppRouter.updatePassword),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,

            icon: IconsPath.iconLang,
            title: AppStrings.language,
            trailing: const LanguageTrailingText(),
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
            icon: IconsPath.vectorWhat,
            title: AppStrings.helpCenter,
            onTap: () => context.pushName(AppRouter.helpCenter),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: IconsPath.group2,
            title: AppStrings.policiesAndRules,
            onTap: () => context.pushName(AppRouter.legalAndPolicies),
          ),
          const SettingsDivider(),
          SettingListItem(
            icon: IconsPath.iconLogout,
            title: AppStrings.logout,
            logout: true,
            seetingScreen: true,
            settingColorIcon: AppColors.red,
            titleColor: AppColors.red,
            onTap: () {
              showCannotDeleteDialogred(
                context,
                AppStrings.logout,
                AppStrings.logoutContent,
                AppStrings.logout,
              );
            },
          ),
        ],
      ),
    );
  }
}
