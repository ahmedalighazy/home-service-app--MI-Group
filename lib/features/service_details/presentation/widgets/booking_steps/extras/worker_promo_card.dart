import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class WorkerPromoCard extends StatelessWidget {
  const WorkerPromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width * 0.045),
      decoration: BoxDecoration(
        color: AppColors.body.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border(right: BorderSide(color: AppColors.primary)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Copy
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      context.l10n.notSureGetFreeInspection,
                      style: AppText.semiBold14Black,
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: size.height * 0.007),
                    Text(
                      context.l10n.inspectionDescription,
                      style: AppText.regular12Grey,
                      textAlign: TextAlign.end,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),

              SizedBox(width: size.width * 0.03),

              // Icon box
              Container(
                width: size.width * 0.13,
                height: size.width * 0.13,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person_search_outlined,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
            ],
          ),

          SizedBox(height: size.height * 0.016),

          // CTA button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: AppColors.primary, width: 1.5),
              ),
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.014,
                horizontal: size.width * 0.05,
              ),
            ),
            onPressed: () {},
            child: Text(
              context.l10n.requestInspection,
              style: AppText.semiBold14Black.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
