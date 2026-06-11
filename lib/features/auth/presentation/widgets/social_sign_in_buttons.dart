import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class SocialSignInButtons extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;

  const SocialSignInButtons({
    super.key,
    required this.isLoading,
    required this.onGooglePressed,
    required this.onApplePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 32.h),
        Text(AuthStrings.orUsing),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _SocialButton(
              label: 'Google',
              onPressed: isLoading ? null : onGooglePressed,
            ),
            _SocialButton(
              label: 'Apple',
              onPressed: isLoading ? null : onApplePressed,
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _SocialButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
