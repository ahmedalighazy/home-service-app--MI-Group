import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class SecurityBanner extends StatelessWidget {
  const SecurityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.013,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.verified_user_outlined,
            color: AppColors.primary,
            size: 20,
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Text(
              context.l10n.securePaymentNote,
              style: AppText.regular12Grey,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
