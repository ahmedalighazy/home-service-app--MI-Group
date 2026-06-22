import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../booking_tracking/booking_gradient_button.dart';
import '../booking_tracking/success_mark.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class RatingSuccessDialog extends StatelessWidget {
  final VoidCallback onBackToHome;

  const RatingSuccessDialog({super.key, required this.onBackToHome});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final dialogWidth = size.width.clamp(0, 330).toDouble();

    return Directionality(
      textDirection: AppStrings.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: dialogWidth),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 26, 14, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SuccessMark(size: 56),
                const SizedBox(height: 24),
                Text(
                  SdStrings.forRating,
                  style: AppText.semiBold16Black.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  SdStrings.yourOpinionHelpsUsOnImproveService,
                  style: AppText.regular12Grey,
                ),
                const SizedBox(height: 22),
                BookingGradientButton(
                  label: SdStrings.backToHome,
                  onPressed: onBackToHome,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
