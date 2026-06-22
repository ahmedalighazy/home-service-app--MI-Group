import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/constants/icons_path.dart';
import '../widgets/language_trailing_text.dart';
import '../widgets/setting_list_item.dart';
import '../widgets/settings_divider.dart';
import '../widgets/settings_toggle_item.dart';
import 'settings_logic.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SettingsLogic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: AppStrings.settings),
      body: Column(
        children: [
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: IconsPath.vectorPassword,
            title: AppStrings.changePassword,
            onTap: () => onChangePasswordTap(context),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,
            icon: IconsPath.iconLang,
            title: context.tr(LocaleKeys.settingsLanguage),
            trailing: const LanguageTrailingText(),
            onTap: () => onLanguageTap(context),
          ),
          const SettingsDivider(),
          SettingsToggleItem(
            icon: Icons.notifications_none_outlined,
            title: AppStrings.bookingNotifications,
            value: notificationsEnabled,
            onChanged: onNotificationsToggled,
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: IconsPath.vectorWhat,
            title: AppStrings.helpCenter,
            onTap: () => onHelpCenterTap(context),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: IconsPath.group2,
            title: AppStrings.policiesAndRules,
            onTap: () => onLegalAndPoliciesTap(context),
          ),
          const SettingsDivider(),
          SettingListItem(
            icon: IconsPath.iconLogout,
            title: context.tr(LocaleKeys.settingsLogout),
            logout: true,
            seetingScreen: true,
            settingColorIcon: AppColors.red,
            titleColor: AppColors.red,
            onTap: () => onLogoutTap(context),
          ),
        ],
      ),
    );
  }
}
