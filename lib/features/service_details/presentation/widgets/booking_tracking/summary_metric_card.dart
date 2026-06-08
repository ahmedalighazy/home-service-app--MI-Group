import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class SummaryMetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const SummaryMetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(height: 6),
          Text(label, style: AppText.regular10Grey),
          const SizedBox(height: 4),
          Text(value, style: AppText.semiBold12Black),
        ],
      ),
    );
  }
}

