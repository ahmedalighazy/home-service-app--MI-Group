import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class AddingButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddingButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 0.038;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: AppColors.white, size: 15),
            const SizedBox(width: 4),
            Text(
              context.l10n.add,
              style: AppText.semiBold14White.copyWith(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
