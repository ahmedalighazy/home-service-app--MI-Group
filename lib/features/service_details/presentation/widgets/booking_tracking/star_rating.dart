import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class StarRating extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const StarRating({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: List.generate(5, (index) {
        final starValue = index + 1;

        return IconButton(
          onPressed: () => onChanged(starValue),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 30, height: 30),
          icon: Icon(
            starValue <= value ? Icons.star_rounded : Icons.star_border_rounded,
            color: starValue <= value ? AppColors.primary : AppColors.lightGrey,
            size: 28,
          ),
        );
      }),
    );
  }
}
