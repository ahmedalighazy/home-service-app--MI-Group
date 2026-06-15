import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../booking_steps/order_summary/booking_reference_card.dart';
import '../booking_steps/order_summary/success_dialog_actions.dart';
import '../booking_steps/order_summary/success_icon.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class BookingSuccessDialog extends StatelessWidget {
  final String bookingReference;
  final VoidCallback onBackToHome;
  final VoidCallback onTrackBooking;

  const BookingSuccessDialog({
    super.key,
    required this.bookingReference,
    required this.onBackToHome,
    required this.onTrackBooking,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final dialogWidth = size.width.clamp(0, 330).toDouble();

    return Directionality(
      textDirection: AppStrings.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: dialogWidth),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SuccessIcon(),
                const SizedBox(height: 14),
                Text(
                  SdStrings.doneConfirmYourBookingSuccessfully,
                  textAlign: TextAlign.center,
                  style: AppText.semiBold18Black.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  SdStrings.doneConfirmYourBookingWeWillRemindYouBeforeAppointmentVisit,
                  textAlign: TextAlign.center,
                  style: AppText.regular12Grey.copyWith(height: 1.35),
                ),
                const SizedBox(height: 18),
                BookingReferenceCard(bookingReference: bookingReference),
                const SizedBox(height: 18),
                SuccessDialogActions(
                  onBackToHome: onBackToHome,
                  onTrackBooking: onTrackBooking,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
