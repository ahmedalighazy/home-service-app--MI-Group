import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class CorporateIntroCard extends StatelessWidget {
  final String title;
  final String description;

  const CorporateIntroCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffBCECF4)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.white,
              size: 23,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.end,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.body,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

