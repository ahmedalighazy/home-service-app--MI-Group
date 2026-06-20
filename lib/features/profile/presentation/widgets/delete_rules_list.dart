import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

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
            title: context.l10n.rule1Title,
            description: context.l10n.rule1Desc,
          ),
          DeleteRuleItem(
            icon: IconsPath.calendarRed,
            title: context.l10n.rule2Title,
            description: context.l10n.rule2Desc,
          ),
          DeleteRuleItem(
            icon: IconsPath.repeat,
            title: context.l10n.rule3Title,
            description: context.l10n.rule3Desc,
          ),
          DeleteRuleItem(
            icon: IconsPath.docs,
            title: context.l10n.rule4Title,
            description: context.l10n.rule4Desc,
          ),
        ],
      ),
    );
  }
}
