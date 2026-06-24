import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_steps/order_summary/reference_action_button.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class BookingReferenceCard extends StatelessWidget {
  final String bookingReference;

  const BookingReferenceCard({super.key, required this.bookingReference});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Text(
                    SdStrings.numberBooking,
                    style: AppText.regular10Grey.copyWith(fontSize: 9),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bookingReference,
                    textDirection: TextDirection.ltr,
                    style: AppText.bold12Black.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.border, height: 1),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: ReferenceActionButton(
                      label: SdStrings.copy,
                      icon: Icons.copy_outlined,
                      onPressed: () => _copyReference(context),
                    ),
                  ),
                  const VerticalDivider(color: AppColors.border, width: 1),
                  Expanded(
                    child: ReferenceActionButton(
                      label: SdStrings.share,
                      icon: Icons.reply_rounded,
                      onPressed: () => _showUnavailableMessage(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyReference(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: bookingReference));

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          SdStrings.doneCopyNumberBooking,
          textAlign: TextAlign.center,
          style: AppText.semiBold14White,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showUnavailableMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          SdStrings.sharingUnavailable,
          textAlign: TextAlign.center,
          style: AppText.semiBold14White,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
