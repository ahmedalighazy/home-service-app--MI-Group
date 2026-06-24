import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

import '../../../../data/models/extra_item_model.dart';

class ExtraSummaryRow extends StatelessWidget {
  final ExtraItem extra;

  const ExtraSummaryRow({super.key, required this.extra});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.008),
      child: Row(
        children: [
          Text(
            '${extra.subtotal.toStringAsFixed(0)} ${SdStrings.qar}',
            style: AppText.regular12Grey,
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(extra.title, style: AppText.semiBold14Black),
              Text(
                '${extra.quantity} × ${extra.price.toStringAsFixed(0)} ${SdStrings.qar}',
                style: AppText.regular12Grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
