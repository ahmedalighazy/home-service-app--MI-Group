import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class SignInPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const SignInPasswordField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<SignInPasswordField> createState() => _SignInPasswordFieldState();
}

class _SignInPasswordFieldState extends State<SignInPasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: AuthStrings.passwordLabel,
        hintText: AuthStrings.passwordPlaceholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
        ),
      ),
      onChanged: (_) => widget.onChanged(),
    );
  }
}
