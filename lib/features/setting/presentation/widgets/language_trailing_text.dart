import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class LanguageTrailingText extends StatelessWidget {
  const LanguageTrailingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.arabic,
          style: AppText.ibmDescription14().copyWith(
            color: AppColors.textLightGrey,
            fontSize: 15,
          ),
        ),
        const Icon(Icons.chevron_right),
      ],
    );
  }
}
