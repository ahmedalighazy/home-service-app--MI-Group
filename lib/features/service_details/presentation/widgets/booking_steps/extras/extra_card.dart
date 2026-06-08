import 'package:home_service_app/features/service_details/service_details_strings.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../../data/models/extra_item_model.dart';
import 'step_quantity_control.dart';

class ExtraCard extends StatelessWidget {
  final ExtraItem item;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ExtraCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Thumbnail — square aspect ratio
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(item.image, fit: BoxFit.cover),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(size.width * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Title
                Text(
                  item.title,
                  style: AppText.semiBold12Black,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: size.height * 0.004),

                // Price
                Text(
                  '${item.price.toStringAsFixed(0)} ${AppStrings.riyalQar}',
                  style: AppText.regular10Grey,
                  textAlign: TextAlign.end,
                ),

                SizedBox(height: size.height * 0.01),

                // Add / counter control
                StepQuantityControl(
                  quantity: quantity,
                  onIncrement: onIncrement,
                  onDecrement: onDecrement,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


