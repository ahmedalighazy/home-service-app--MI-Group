import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_steps/date_time/time_slot_chip.dart';
import '../../../../data/models/time_slot_model.dart';

class TimeSlotGrid extends StatelessWidget {
  final List<TimeSlot> slots;
  final int selectedIndex;
  final ValueChanged<int> onSlotSelected;

  const TimeSlotGrid({
    super.key,
    required this.slots,
    required this.selectedIndex,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: size.width * 0.03,
        mainAxisSpacing: size.height * 0.014,
        childAspectRatio: 1.15,
      ),
      itemCount: slots.length,
      itemBuilder: (_, i) => TimeSlotChip(
        slot: slots[i],
        isSelected: i == selectedIndex,
        onTap: () => onSlotSelected(i),
      ),
    );
  }
}

