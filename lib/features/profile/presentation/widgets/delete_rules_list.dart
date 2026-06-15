import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

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
            title: context.tr(LocaleKeys.profileDeleteRule1Title),
            description: context.tr(LocaleKeys.profileDeleteRule1Desc),
          ),
          DeleteRuleItem(
            icon: IconsPath.calendarRed,
            title: context.tr(LocaleKeys.profileDeleteRule2Title),
            description: context.tr(LocaleKeys.profileDeleteRule2Desc),
          ),
          DeleteRuleItem(
            icon: IconsPath.repeat,
            title: context.tr(LocaleKeys.profileDeleteRule3Title),
            description: context.tr(LocaleKeys.profileDeleteRule3Desc),
          ),
          DeleteRuleItem(
            icon: IconsPath.docs,
            title: context.tr(LocaleKeys.profileDeleteRule4Title),
            description: context.tr(LocaleKeys.profileDeleteRule4Desc),
          ),
        ],
      ),
    );
  }
}
