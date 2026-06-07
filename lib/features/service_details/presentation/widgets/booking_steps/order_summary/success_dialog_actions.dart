import 'package:flutter/material.dart';

import 'dialog_filled_button.dart';
import 'dialog_outlined_button.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';


class SuccessDialogActions extends StatelessWidget {
  final VoidCallback onBackToHome;
  final VoidCallback onTrackBooking;

  const SuccessDialogActions({
    super.key,
    required this.onBackToHome,
    required this.onTrackBooking,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DialogOutlinedButton(
            label: AppStrings.backToHome,
            onPressed: onBackToHome,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DialogFilledButton(
            label: AppStrings.trackingBooking,
            onPressed: onTrackBooking,
          ),
        ),
      ],
    );
  }
}

