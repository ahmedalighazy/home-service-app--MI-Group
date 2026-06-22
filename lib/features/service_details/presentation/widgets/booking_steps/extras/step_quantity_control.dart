import 'package:flutter/material.dart';

import '../counter_row.dart';
import 'adding_button.dart';

class StepQuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const StepQuantityControl({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return quantity == 0
        ? AddingButton(onTap: onIncrement)
        : CounterRow(
            quantity: quantity,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          );
  }
}
