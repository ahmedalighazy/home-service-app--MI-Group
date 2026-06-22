import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';

import '../widgets/setting_list_item.dart';

class LegalAndPoliciesScreen extends StatelessWidget {
  const LegalAndPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: AppStrings.policiesAndRules),
      body: Column(
        children: [
          SettingListItem(
            icon: IconsPath.group1,
            settingColorIcon: AppColors.body,
            seetingScreen: true,

            title: context.tr(LocaleKeys.legalPrivacyPolicy),
            onTap: () {
              context.pushNamed(AppRouter.privacyPolicy);
            },
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.dividerGrey),
          SettingListItem(
            seetingScreen: true,
            settingColorIcon: AppColors.body,
            icon: IconsPath.ell,
            title: context.tr(LocaleKeys.legalTermsAndConditions),
            onTap: () {
              context.pushNamed(AppRouter.termsAndConditions);
            },
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.dividerGrey),
        ],
      ),
    );
  }
}
