import 'package:flutter/material.dart';

import 'choice_chip_item.dart';

class FilterSection<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T selectedItem;
  final String Function(T item) labelBuilder;
  final ValueChanged<T> onSelected;

  const FilterSection({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xff222222),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: items.map((item) {
            final isSelected = item == selectedItem;

            return ChoiceChipItem(
              text: labelBuilder(item),
              isSelected: isSelected,
              onTap: () => onSelected(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}

