import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_steps/payment/radio_dot.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../../data/models/saved_card_model.dart';
import 'card_brand_logo.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class SavedCardTile extends StatelessWidget {
  final SavedCard card;
  final bool isSelected;
  final VoidCallback onTap;

  const SavedCardTile({
    super.key,
    required this.card,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.014,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.04)
              : AppColors.white,
          border: const Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [

            const Icon(Icons.more_vert, color: AppColors.body, size: 20),

            const Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    if (card.isDefault) ...[
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.02),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          SdStrings.defaultCard,
                          style: AppText.regular10Grey.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                    Text(
                      '**** ${card.last4}',
                      style: AppText.semiBold14Black,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(card.holder, style: AppText.regular12Grey),
              ],
            ),

            SizedBox(width: size.width * 0.03),

            CardBrandLogo(brand: card.brand),

            SizedBox(width: size.width * 0.03),

            RadioDot(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}
