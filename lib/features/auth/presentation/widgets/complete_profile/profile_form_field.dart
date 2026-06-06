import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class ProfileFormField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const ProfileFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.prefixIcon,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleObscure,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  State<ProfileFormField> createState() => _ProfileFormFieldState();
}

class _ProfileFormFieldState extends State<ProfileFormField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.ibmPlexSansArabic(
            color: AppColors.headingText,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Focus(
          onFocusChange: (v) => setState(() => _isFocused = v),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? widget.obscureText : false,
            keyboardType: widget.keyboardType,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            onChanged: widget.onChanged,
            style: GoogleFonts.ibmPlexSansArabic(
              color: AppColors.primaryText,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: GoogleFonts.ibmPlexSansArabic(
                color: AppColors.placeholder,
                fontSize: 13.sp,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      size: 20.sp,
                      color: _isFocused ? AppColors.greenPrimary : AppColors.gray,
                    )
                  : null,
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
              fillColor: AppColors.white,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: const BorderSide(color: AppColors.borderInputs),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: const BorderSide(
                  color: AppColors.greenPrimary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
