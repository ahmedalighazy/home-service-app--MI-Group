import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

import '../../../../core/themes/text/app_text.dart';

class LanguageTrailingText extends StatelessWidget {
  const LanguageTrailingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.tr(LocaleKeys.settingsArabic),
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
