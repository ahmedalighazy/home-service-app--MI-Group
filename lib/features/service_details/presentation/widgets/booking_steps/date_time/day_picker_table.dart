import 'package:flutter/material.dart';

import '../../../../../../core/themes/text/app_text.dart';
import '../../../../../../core/utils/helpers/booking_date_utils.dart';
import 'day_chip.dart';

class DayPickerTable extends StatelessWidget {
  final List<DateTime> days;
  final int selectedIndex;
  final ValueChanged<int> onDaySelected;

  const DayPickerTable({
    super.key,
    required this.days,
    required this.selectedIndex,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Reverse: index-0 (Sat) ends up at the right side of the Row
    final displayOrder = days.reversed.toList();

    return Column(
      children: [
        // Row 1 — day name labels
        Row(
          children: displayOrder.map((date) {
            return Expanded(
              child: Text(
                kArabicDayNames[date.weekday]!,
                style: AppText.semiBold12Black,
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        ),

        SizedBox(height: size.height * 0.016),

        // Row 2 — circle chips
        Row(
          children: displayOrder.asMap().entries.map((entry) {
            // Map display position back to the original sorted index
            final originalIndex = days.length - 1 - entry.key;
            final slotNumber = originalIndex + 1; // Sat=1, …, Fri=7
            final isSelected = originalIndex == selectedIndex;

            return Expanded(
              child: DayChip(
                slotNumber: slotNumber,
                isSelected: isSelected,
                onTap: () => onDaySelected(originalIndex),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

