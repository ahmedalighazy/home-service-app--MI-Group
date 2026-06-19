import 'package:flutter/material.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
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
      appBar: CustomAppBar(title: context.tr(LocaleKeys.settingsTitle)),
      body: Column(
        children: [
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: IconsPath.vectorPassword,
            title: context.tr(LocaleKeys.settingsChangePassword),
            onTap: () => context.pushNamed(AppRouter.updatePassword),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,

            icon: IconsPath.iconLang,
            title: context.tr(LocaleKeys.settingsLanguage),
            trailing: const LanguageTrailingText(),
            onTap: () {},
          ),
          const SettingsDivider(),
          SettingsToggleItem(
            icon: Icons.notifications_none_outlined,
            title: context.tr(LocaleKeys.settingsNotifications),
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: IconsPath.vectorWhat,
            title: context.tr(LocaleKeys.profileHelpCenter),
            onTap: () => context.pushNamed(AppRouter.helpCenter),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: IconsPath.group2,
            title: context.tr(LocaleKeys.settingsPolicies),
            onTap: () => context.pushNamed(AppRouter.legalAndPolicies),
          ),
          const SettingsDivider(),
          SettingListItem(
            icon: IconsPath.iconLogout,
            title: context.tr(LocaleKeys.settingsLogout),
            logout: true,
            seetingScreen: true,
            settingColorIcon: AppColors.red,
            titleColor: AppColors.red,
            onTap: () {
              showCannotDeleteDialogred(
                context,
                context.tr(LocaleKeys.settingsLogout),
                context.tr(LocaleKeys.settingsLogoutConfirm),
                context.tr(LocaleKeys.settingsLogout),
                true,
              );
            },
          ),
        ],
      ),
    );
  }
}
