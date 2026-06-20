import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class PolicyBanner extends StatelessWidget {
  const PolicyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Icon + policy text
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.003),
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.body,
                  size: 18,
                ),
              ),
              SizedBox(width: size.width * 0.025),
              Expanded(
                child: Text(
                  context.l10n.cancellationPolicy,
                  style: AppText.regular12Grey,
                  textAlign: TextAlign.end,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),

          SizedBox(height: size.height * 0.01),

          // context.l10n.showDetails link
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                context.l10n.viewDetails,
                style: AppText.semiBold12Black.copyWith(
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
