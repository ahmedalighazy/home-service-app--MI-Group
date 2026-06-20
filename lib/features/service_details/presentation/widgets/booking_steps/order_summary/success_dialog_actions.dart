import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import 'dialog_filled_button.dart';
import 'dialog_outlined_button.dart';

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
            label: context.l10n.backToHome,
            onPressed: onBackToHome,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DialogFilledButton(
            label: context.l10n.trackBooking,
            onPressed: onTrackBooking,
          ),
        ),
      ],
    );
  }
}
