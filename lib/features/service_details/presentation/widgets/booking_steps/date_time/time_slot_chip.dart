import 'package:home_service_app/features/service_details/service_details_strings.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../../data/models/time_slot_model.dart';

class TimeSlotChip extends StatelessWidget {
  final TimeSlot slot;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotChip({
    super.key,
    required this.slot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.black;
    final borderColor = isSelected ? AppColors.primary : AppColors.border;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${slot.startTime} ${AppStrings.morning}',
              style: AppText.semiBold12Black.copyWith(
                color: color,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '${slot.endTime}- ${AppStrings.morning}',
              style: AppText.regular12Grey.copyWith(
                color: color,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


