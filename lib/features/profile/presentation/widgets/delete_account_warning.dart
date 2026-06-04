import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class DeleteAccountWarning extends StatelessWidget {
  const DeleteAccountWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: AppColors.redDangerBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44),
                ),
              ),
              child: const Icon(Icons.delete, color: AppColors.redDanger),
            ),
            horizontalSpace(12),
            Text(
              AppStrings.deleteWarningTitle,
              style: AppText.boldIbm(
                color: AppColors.primaryText,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 34),
          child: Text(
            AppStrings.deleteWarningDesc,
            style: AppText.regularIbm(
              color: AppColors.textDarkGrey,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
