import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/promo_apply_button.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class PromoCodeWidget extends StatelessWidget {
  final String promoCode;
  final String discount;

  const PromoCodeWidget({
    super.key,
    required this.promoCode,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.012,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Apply button — leading edge in LTR becomes trailing in RTL context
          const PromoApplyButton(),

          // Discount info row
          Column(
            children: [
              Text('${AppStrings.codePrefix} $promoCode', style: AppText.semiBold14Black),
              SizedBox(width: size.width * 0.02),
              Row(
                children: [
                  const Icon(
                    Icons.local_offer_outlined,
                    color: AppColors.yellow,
                    size: 18,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text(discount, style: AppText.semiBold14Black),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


