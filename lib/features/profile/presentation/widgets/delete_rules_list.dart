import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

import 'delete_rule_item.dart';

class DeleteRulesList extends StatelessWidget {
  const DeleteRulesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: ShapeDecoration(
        color: AppColors.errorRed2.withValues(alpha: 0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        children: [
          DeleteRuleItem(
            icon: IconsPath.warning,
            title: AppStrings.rule1Title,
            description: AppStrings.rule1Desc,
          ),
          DeleteRuleItem(
            icon: IconsPath.calendarRed,
            title: AppStrings.rule2Title,
            description: AppStrings.rule2Desc,
          ),
          DeleteRuleItem(
            icon: IconsPath.repeat,
            title: AppStrings.rule3Title,
            description: AppStrings.rule3Desc,
          ),
          DeleteRuleItem(
            icon: IconsPath.docs,
            title: AppStrings.rule4Title,
            description: AppStrings.rule4Desc,
          ),
        ],
      ),
    );
  }
}
