import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class StepProgressStrip extends StatelessWidget {
  final int current;
  final int total;

  const StepProgressStrip({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final isActive = index < current;

        return Expanded(
          child: Container(
            height: 3,
            margin: EdgeInsets.only(right: index == total - 1 ? 0 : 7),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xffF5A623) : AppColors.lightGrey,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      }),
    );
  }
}
