import 'package:flutter/material.dart' ;
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class DayChip extends StatelessWidget {
  final int slotNumber;
  final bool isSelected;
  final VoidCallback onTap;

  const DayChip({
    super.key,
    required this.slotNumber,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final chipSize = MediaQuery.of(context).size.width * 0.108;

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: chipSize,
          height: chipSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
          ),
          child: Text(
            '$slotNumber',
            style: AppText.semiBold18Black.copyWith(
              fontSize: 16,
              color: isSelected ? AppColors.white : AppColors.body,
            ),
          ),
        ),
      ),
    );
  }
}

