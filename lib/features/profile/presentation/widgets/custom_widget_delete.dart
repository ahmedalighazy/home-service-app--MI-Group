import 'package:flutter/material.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/l10n/app_strings.dart';

class CustomWidgetDelete extends StatelessWidget {
  const CustomWidgetDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.confirmDeleteHint,
      style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}