import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class ProfileNameField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const ProfileNameField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: AuthStrings.nameLabel,
        hintText: AuthStrings.namePlaceholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      onChanged: (_) => onChanged(),
    );
  }
}
