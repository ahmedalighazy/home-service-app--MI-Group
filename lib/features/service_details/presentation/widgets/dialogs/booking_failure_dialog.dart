import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../booking_steps/order_summary/failure_dialog_actions.dart';
import '../booking_steps/order_summary/failure_icon.dart';

class BookingFailureDialog extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onChangePaymentMethod;

  const BookingFailureDialog({
    super.key,
    required this.onRetry,
    required this.onChangePaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final dialogWidth = size.width.clamp(0, 330).toDouble();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: dialogWidth),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FailureIcon(),
                const SizedBox(height: 18),
                Text(
                  context.l10n.paymentFailed,
                  textAlign: TextAlign.center,
                  style: AppText.semiBold20Black.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  context.l10n.paymentFailedDescriptionAlt,
                  textAlign: TextAlign.center,
                  style: AppText.regular12Grey.copyWith(height: 1.45),
                ),
                const SizedBox(height: 22),
                FailureDialogActions(
                  onRetry: onRetry,
                  onChangePaymentMethod: onChangePaymentMethod,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
