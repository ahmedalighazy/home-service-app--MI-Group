import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_item_counter_icon_button.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class ServiceItemQuantityCounter extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ServiceItemQuantityCounter({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ServiceItemCounterIconButton(icon: Icons.add, onTap: onIncrement),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('$quantity', style: AppText.semiBold14White),
          ),
          ServiceItemCounterIconButton(icon: Icons.remove, onTap: onDecrement),
        ],
      ),
    );
  }
}
