import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../../data/models/extra_item_model.dart';
import 'extra_summary_row.dart';

class PaymentSummaryTile extends StatelessWidget {
  final List<ExtraItem> selectedExtras;

  const PaymentSummaryTile({super.key, required this.selectedExtras});

  @override
  Widget build(BuildContext context) {
    if (selectedExtras.isEmpty) return const SizedBox.shrink();

    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.l10n.services,
            style: AppText.semiBold14Black,
            textAlign: TextAlign.end,
          ),
          SizedBox(height: size.height * 0.012),
          ...selectedExtras.map((extra) => ExtraSummaryRow(extra: extra)),
        ],
      ),
    );
  }
}
