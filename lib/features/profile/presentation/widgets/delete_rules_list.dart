import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

import 'delete_rule_item.dart';

class DeleteRulesList extends StatelessWidget {
  const DeleteRulesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.bgDisabled.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Column(
        children: [
          DeleteRuleItem(
            icon: Icons.warning_amber_rounded,
            title: AppStrings.rule1Title,
            description: AppStrings.rule1Desc,
          ),
          DeleteRuleItem(
            icon: Icons.calendar_today_outlined,
            title: AppStrings.rule2Title,
            description: AppStrings.rule2Desc,
          ),
          DeleteRuleItem(
            icon: Icons.autorenew_rounded,
            title: AppStrings.rule3Title,
            description: AppStrings.rule3Desc,
          ),
          DeleteRuleItem(
            icon: Icons.gavel_rounded,
            title: AppStrings.rule4Title,
            description: AppStrings.rule4Desc,
          ),
        ],
      ),
    );
  }
}
