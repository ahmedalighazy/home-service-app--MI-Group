import 'package:flutter/material.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AuthPrimaryButton(
      label: context.tr('login'),
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}