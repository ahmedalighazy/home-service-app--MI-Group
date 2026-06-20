import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import 'dialog_filled_button.dart';
import 'dialog_outlined_button.dart';

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
            label: context.l10n.changeMethodPayment,
            onPressed: onChangePaymentMethod,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DialogFilledButton(
            label: context.l10n.retry,
            onPressed: onRetry,
            hasShadow: true,
          ),
        ),
      ],
    );
  }
}
