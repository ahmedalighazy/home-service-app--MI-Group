import 'package:flutter/material.dart';

import '../../../../../../core/themes/text/app_text.dart';
import '../../../../data/models/summary_item.dart';
import '../counter_row.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class SummaryItemRow extends StatelessWidget {
  final SummaryItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const SummaryItemRow({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.012),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CounterRow(
            quantity: item.qty,
            onIncrement: onIncrease,
            onDecrement: onDecrease,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(item.title, style: AppText.semiBold14Black),
              Text(
                '${item.totalPrice.toStringAsFixed(0)} ${SdStrings.qar}',
                style: AppText.regular12Grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
