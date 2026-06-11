import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class ProfileAddressField extends StatelessWidget {
  final TextEditingController controller;

  const ProfileAddressField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.streetAddress,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: AuthStrings.addressLabel,
        hintText: 'أدخل عنوانك',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
