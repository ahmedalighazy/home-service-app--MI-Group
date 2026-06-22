import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class CardBrandBadge extends StatelessWidget {
  final String brand;

  const CardBrandBadge({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(brand, style: AppText.bold10Black.copyWith(fontSize: 9)),
    );
  }
}
