import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class SignUpLink extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpLink({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: AuthStrings.dontHaveAccount,
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: AuthStrings.createAccount,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
              recognizer: TapGestureRecognizer()..onTap = onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
