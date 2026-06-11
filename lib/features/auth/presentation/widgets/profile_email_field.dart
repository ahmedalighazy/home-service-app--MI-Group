import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class ProfileEmailField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const ProfileEmailField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: AuthStrings.emailLabel,
        hintText: AuthStrings.emailPlaceholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      onChanged: (_) => onChanged(),
    );
  }
}
