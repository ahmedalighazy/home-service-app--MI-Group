import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/language/language_cubit.dart';

class PasswordInputField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Color borderColor;
  final VoidCallback onObscurePressed;

  const PasswordInputField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.borderColor,
    required this.onObscurePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            textAlign:
                context.select<LanguageCubit, bool>((c) => c.state.isArabic)
                    ? TextAlign.right
                    : TextAlign.left,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              prefixIcon: IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: onObscurePressed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
