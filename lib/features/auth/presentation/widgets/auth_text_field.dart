import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

/// A reusable labeled text field for auth screens.
///
/// Usage example:
/// ```dart
/// AuthTextField(
///   label: AppStrings.emailLabel,
///   hint: AppStrings.emailPlaceholder,
///   controller: _emailController,
///   prefixIcon: Icons.mail_outline,
///   keyboardType: TextInputType.emailAddress,
/// )
/// ```
class AuthTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool hasError;
  final String? errorMessage;
  final ValueChanged<String>? onChanged;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.hasError = false,
    this.errorMessage,
    this.onChanged,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final bool showObscure = widget.isPassword;
    final borderColor = widget.hasError
        ? AppColors.errorRed
        : _isFocused
            ? AppColors.greenPrimary
            : AppColors.borderInputs;
    final double borderWidth = _isFocused ? 1.5 : 1.0;

    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Column(
      crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // ── Label ──────────────────────────────────────────
        Text(
          widget.label,
          style: AppText.ibmFieldLabel14(
            color: widget.hasError ? AppColors.errorRed : AppColors.dark,
          ),
        ),
        SizedBox(height: 8.h),

        // ── Input ──────────────────────────────────────────
        Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 56.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: borderColor, width: borderWidth),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: AppColors.greenPrimary.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: TextField(
                controller: widget.controller,
                obscureText: showObscure && _obscure,
                keyboardType: widget.keyboardType,
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                onChanged: widget.onChanged,
                style: AppText.ibmDescription14(color: AppColors.primaryText),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: AppText.ibmPlaceholder14(),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  prefixIcon: Icon(
                    widget.prefixIcon,
                    size: 20.sp,
                    color: _isFocused ? AppColors.greenPrimary : AppColors.placeholder,
                  ),
                  suffixIcon: showObscure
                      ? IconButton(
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20.sp,
                            color: AppColors.placeholder,
                          ),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),

        // ── Error message ──────────────────────────────────
        if (widget.hasError && widget.errorMessage != null) ...[
          SizedBox(height: 6.h),
          Align(
            alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              widget.errorMessage!,
              style: AppText.ibmError12(),
            ),
          ),
        ],
      ],
    );
  }
}
