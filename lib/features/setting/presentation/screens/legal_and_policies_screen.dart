import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/extensions/extention_navigator.dart';
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
            icon: Icons.privacy_tip_outlined,
            title: AppStrings.privacyPolicyLabel,
            onTap: () {
              context.pushName(AppRoutes.privacyPolicy);
            },
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.dividerGrey),
          SettingListItem(
            icon: Icons.description_outlined,
            title: AppStrings.termsAndConditionsLabel,
            onTap: () {
              context.pushName(AppRoutes.termsAndConditions);
            },
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.dividerGrey),
        ],
      ),
    );
  }
}
