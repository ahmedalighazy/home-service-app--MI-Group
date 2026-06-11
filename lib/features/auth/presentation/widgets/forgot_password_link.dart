import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class ForgotPasswordLink extends StatelessWidget {
  final VoidCallback onPressed;

  const ForgotPasswordLink({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          AuthStrings.forgotPassword,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.blue,
              ),
        ),
      ),
    );
  }
}
