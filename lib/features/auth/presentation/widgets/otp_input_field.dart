import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 6,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall,
      decoration: InputDecoration(
        labelText: AuthStrings.otpCodeHint,
        hintText: '000000',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        counterText: '',
      ),
      onChanged: (_) => onChanged(),
    );
  }
}
