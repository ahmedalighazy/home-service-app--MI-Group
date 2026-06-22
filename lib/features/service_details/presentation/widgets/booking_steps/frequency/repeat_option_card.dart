import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_steps/frequency/recommended_badge.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_steps/frequency/repeat_option.dart';

import 'custom_radio.dart';
import 'discount_badge.dart';

class RepeatOptionCard extends StatelessWidget {
  final RepeatOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const RepeatOptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff00A6C8);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(9),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xffEEF9FC) : Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: isSelected ? primaryColor : const Color(0xffE3E7EC),
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                CustomRadio(isSelected: isSelected),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      option.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff222222),
                      ),
                    ),
                    if (option.discount != null) ...[
                      const SizedBox(height: 4),
                      DiscountBadge(text: option.discount!),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),

        if (option.recommended)
          const Positioned(left: 8, top: -8, child: RecommendedBadge()),
      ],
    );
  }
}
