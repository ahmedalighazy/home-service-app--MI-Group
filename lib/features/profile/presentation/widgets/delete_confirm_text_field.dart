import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/widgets/custom_text_field.dart';

import '../../../../core/themes/text/app_text.dart';

class DeleteConfirmTextField extends StatelessWidget {
  final TextEditingController controller;

  const DeleteConfirmTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isCorrect = controller.text.trim() == context.l10n.deleteConfirmWord;
    final hasError = controller.text.isNotEmpty && !isCorrect;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          centerText: true,
          controller: controller,
          hintText: context.l10n.confirmDeleteHint,
          fillColor: AppColors.white,
          borderColor: hasError ? AppColors.redBorder : AppColors.borderGrey,
        ),
        if (hasError) ...[
          SizedBox(height: 4.h),

          Text(
            context.l10n.confirmFieldHint,
            style: AppText.regularIbm(color: AppColors.redDanger, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
