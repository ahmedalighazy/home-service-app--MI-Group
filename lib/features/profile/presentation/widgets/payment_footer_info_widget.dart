import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

class PaymentFooterInfoWidget extends StatelessWidget {
  const PaymentFooterInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.textLightGrey,
              size: 24.r,
            ),
            horizontalSpace(12),
            Expanded(
              child: Text(
                context.l10n.defaultPaymentNotice,
                style: AppText.regularText(
                  color: AppColors.textLightGrey,
                  fontSize: 14,
                ).copyWith(height: 1.5),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
