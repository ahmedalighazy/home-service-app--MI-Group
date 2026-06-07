import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class RecentSearchItem extends StatelessWidget {
  const RecentSearchItem({
    super.key,
    required this.title,
    this.onDelete,
    this.onTap,
  });

  final String title;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spacingSmall),
        child: Row(
          children: [
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.restore, color: AppColors.placeholder),
            ),

            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: AppText.ibmDescription14(color: AppColors.primaryText),
              ),
            ),

            const Icon(Icons.close, color: AppColors.placeholder),
          ],
        ),
      ),
    );
  }
}
