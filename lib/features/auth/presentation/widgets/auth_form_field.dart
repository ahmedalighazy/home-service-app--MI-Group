import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

/// A reusable labeled form field for auth screens that require validation.
/// Uses [TextFormField] with validator support — use this inside a [Form] widget.
///
/// For simple fields without validation, use [AuthTextField] instead.
///
/// Usage:
/// ```dart
/// AuthFormField(
///   label: AppStrings.nameLabel,
///   hint: AppStrings.namePlaceholder,
///   controller: _nameCtrl,
///   prefixIcon: Icons.person_outline_rounded,
///   validator: (v) => v!.isEmpty ? 'مطلوب' : null,
/// )
/// ```
class AuthFormField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData prefixIcon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AuthFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleObscure,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // ── Label ────────────────────────────────────────
        Text(
          widget.label,
          style: AppText.ibmFieldLabel14(color: AppColors.headingText),
        ),

        SizedBox(height: 8.h),

        // ── Input ────────────────────────────────────────
        Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? widget.obscureText : false,
            keyboardType: widget.keyboardType,
            textDirection: TextDirection.rtl,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: AppText.ibmDescription14(color: AppColors.primaryText),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppText.ibmPlaceholder14(),
              prefixIcon: Icon(
                widget.prefixIcon,
                size: 20.sp,
                color: _isFocused
                    ? AppColors.greenPrimary
                    : AppColors.gray,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        widget.obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                        color: AppColors.gray,
                      ),
                      onPressed: widget.onToggleObscure,
                    )
                  : null,
              filled: true,
              fillColor: AppColors.bgPrimary,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    const BorderSide(color: AppColors.borderInputs),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                    color: AppColors.greenPrimary, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    const BorderSide(color: AppColors.errorRed),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                    color: AppColors.errorRed, width: 1.5),
              ),
              errorStyle: AppText.ibmError12(),
            ),
          ),
        ),
      ],
    );
  }
}
