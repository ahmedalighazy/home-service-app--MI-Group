import 'package:flutter/material.dart';

import 'dialog_filled_button.dart';
import 'dialog_outlined_button.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class FailureDialogActions extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onChangePaymentMethod;

  const FailureDialogActions({
    super.key,
    required this.onRetry,
    required this.onChangePaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DialogOutlinedButton(
            label: SdStrings.changeMethodPayment,
            onPressed: onChangePaymentMethod,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DialogFilledButton(
            label: SdStrings.rebookRetry,
            onPressed: onRetry,
            hasShadow: true,
          ),
        ),
      ],
    );
  }
}
