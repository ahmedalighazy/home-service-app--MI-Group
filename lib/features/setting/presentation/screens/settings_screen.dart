import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
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
      appBar: CustomAppBar(title: context.l10n.settings),
      body: Column(
        children: [
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: IconsPath.vectorPassword,
            title: context.l10n.changePassword,
            onTap: () => context.pushNamed(AppRouter.updatePassword),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,

            icon: IconsPath.iconLang,
            title: context.l10n.language,
            trailing: const LanguageTrailingText(),
            onTap: () {},
          ),
          const SettingsDivider(),
          SettingsToggleItem(
            icon: Icons.notifications_none_outlined,
            title: context.l10n.bookingNotifications,
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: IconsPath.vectorWhat,
            title: context.l10n.helpCenter,
            onTap: () => context.pushNamed(AppRouter.helpCenter),
          ),
          const SettingsDivider(),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.greyDarker,
            icon: IconsPath.group2,
            title: context.l10n.policiesAndRules,
            onTap: () => context.pushNamed(AppRouter.legalAndPolicies),
          ),
          const SettingsDivider(),
          SettingListItem(
            icon: IconsPath.iconLogout,
            title: context.l10n.logout,
            logout: true,
            seetingScreen: true,
            settingColorIcon: AppColors.red,
            titleColor: AppColors.red,
            onTap: () {
              showCannotDeleteDialogred(
                context,
                context.l10n.logout,
                context.l10n.logoutContent,
                context.l10n.logout,
                true,
              );
            },
          ),
        ],
      ),
    );
  }
}
