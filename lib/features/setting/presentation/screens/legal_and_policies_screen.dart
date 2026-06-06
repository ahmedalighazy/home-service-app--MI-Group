import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/extention_navigator.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../widgets/setting_list_item.dart';

class LegalAndPoliciesScreen extends StatelessWidget {
  const LegalAndPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: AppStrings.policiesAndRules),
      body: Column(
        children: [
          SettingListItem(
            icon: IconsPath.group1,
            settingColorIcon: AppColors.body,
            seetingScreen: true,

            title: AppStrings.privacyPolicyLabel,
            onTap: () {
              context.pushName(AppRouter.privacyPolicy);
            },
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.dividerGrey),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.body,
            icon: IconsPath.ell,
            title: AppStrings.termsAndConditionsLabel,
            onTap: () {
              context.pushName(AppRouter.termsAndConditions);
            },
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.dividerGrey),
        ],
      ),
    );
  }
}
