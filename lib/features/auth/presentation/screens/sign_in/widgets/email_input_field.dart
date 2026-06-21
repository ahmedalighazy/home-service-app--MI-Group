import 'package:flutter/material.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const EmailInputField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      label: context.tr('emailLabel'),
      hint: context.tr('emailPlaceholder'),
      controller: controller,
      prefixIcon: Icons.mail_outline_rounded,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
    );
  }
}