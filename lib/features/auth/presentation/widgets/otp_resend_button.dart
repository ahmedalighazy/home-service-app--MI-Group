import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class OtpResendButton extends StatelessWidget {
  final bool canResend;
  final VoidCallback onPressed;

  const OtpResendButton({
    super.key,
    required this.canResend,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: AuthStrings.resendCodePromptAlt,
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: AuthStrings.resendCodeLink,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: canResend ? Colors.blue : Colors.grey,
                  ),
              recognizer: canResend
                  ? (TapGestureRecognizer()..onTap = onPressed)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
