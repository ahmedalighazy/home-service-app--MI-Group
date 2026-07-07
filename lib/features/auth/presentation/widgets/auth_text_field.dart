import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

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
  final bool optional;
  final int maxLines;

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
    this.optional = false,
    this.maxLines = 1,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final showObscure = widget.isPassword;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final borderColor = widget.hasError
        ? AppColors.errorRed
        : _isFocused
        ? AppColors.greenPrimary
        : AppColors.borderInputs;

    return Column(
      crossAxisAlignment: isArabic
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        _TextFieldLabel(
          label: widget.label,
          optional: widget.optional,
          hasError: widget.hasError,
        ),
        SizedBox(height: 8.h),
        Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: borderColor,
                width: _isFocused ? 1.5 : 1.0,
              ),
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
            child: _TextFieldInput(
              controller: widget.controller,
              hint: widget.hint,
              obscureText: showObscure && _obscure,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              onChanged: widget.onChanged,
              prefixIcon: widget.prefixIcon,
              isFocused: _isFocused,
              showObscure: showObscure,
              obscure: _obscure,
              onToggleObscure: () => setState(() => _obscure = !_obscure),
              isArabic: isArabic,
            ),
          ),
        ),
        if (widget.hasError && widget.errorMessage != null)
          _TextFieldError(message: widget.errorMessage!, isArabic: isArabic),
      ],
    );
  }
}

class _TextFieldLabel extends StatelessWidget {
  final String label;
  final bool optional;
  final bool hasError;

  const _TextFieldLabel({
    required this.label,
    required this.optional,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: AppText.ibmFieldLabel14(
            color: hasError ? AppColors.errorRed : AppColors.dark,
          ),
        ),
        if (optional)
          Text(
            ' (${optional ? 'اختياري' : 'Optional'})',
            style: AppText.ibmCaption11(color: AppColors.secondaryText),
          ),
      ],
    );
  }
}

class _TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final IconData prefixIcon;
  final bool isFocused;
  final bool showObscure;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final bool isArabic;

  const _TextFieldInput({
    required this.controller,
    required this.hint,
    required this.obscureText,
    required this.keyboardType,
    required this.maxLines,
    required this.onChanged,
    required this.prefixIcon,
    required this.isFocused,
    required this.showObscure,
    required this.obscure,
    required this.onToggleObscure,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        maxLines: maxLines,
        onChanged: onChanged,
        style: AppText.ibmDescription14(color: AppColors.primaryText),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppText.ibmPlaceholder14(),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          prefixIcon: maxLines > 1
              ? null
              : Icon(
                  prefixIcon,
                  size: 20.sp,
                  color: isFocused
                      ? AppColors.greenPrimary
                      : AppColors.placeholder,
                ),
          suffixIcon: showObscure
              ? IconButton(
                  icon: Icon(
                    obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20.sp,
                    color: AppColors.placeholder,
                  ),
                  onPressed: onToggleObscure,
                )
              : null,
        ),
      ),
    );
  }
}

class _TextFieldError extends StatelessWidget {
  final String message;
  final bool isArabic;

  const _TextFieldError({required this.message, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Align(
        alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(message, style: AppText.ibmError12()),
      ),
    );
  }
}
