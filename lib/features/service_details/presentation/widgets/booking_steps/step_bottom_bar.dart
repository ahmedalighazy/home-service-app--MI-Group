import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_steps/step_total_display.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class StepBottomBar extends StatelessWidget {
  final double total;
  final VoidCallback onNext;
  final String? nextLabel;

  StepBottomBar({
    super.key,
    required this.total,
    required this.onNext,
    String? nextLabel,
  }) : nextLabel = nextLabel ?? SdStrings.next;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.016,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.38,
            child: CustomButtom(
              onTap: onNext,
              text: nextLabel ?? context.tr(LocaleKeys.next),
              textStyle: AppText.semiBold16Black.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
              startColor: const Color(0xff0D7A8A),
              endColor: AppColors.primary,
            ),
          ),
          StepTotalDisplay(total: total),
        ],
      ),
    );
  }
}
