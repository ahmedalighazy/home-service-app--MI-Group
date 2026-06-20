import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_text_field.dart';

import '../../../../core/themes/text/app_text.dart';

class DeleteConfirmTextField extends StatelessWidget {
  final TextEditingController controller;

  const DeleteConfirmTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isCorrect =
        controller.text.trim().toLowerCase() ==
        context.tr(LocaleKeys.profileDeleteConfirmWord).toLowerCase();
    final hasError = controller.text.isNotEmpty && !isCorrect;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          centerText: true,
          controller: controller,
          hintText: context.tr(LocaleKeys.profileDeleteConfirmHint),
          fillColor: AppColors.white,
          borderColor: hasError ? AppColors.redBorder : AppColors.borderGrey,
        ),
        if (hasError) ...[
          verticalSpace(4),

          Text(
            context.tr(LocaleKeys.profileDeleteConfirmFieldHint),
            style: AppText.regularIbm(color: AppColors.redDanger, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
