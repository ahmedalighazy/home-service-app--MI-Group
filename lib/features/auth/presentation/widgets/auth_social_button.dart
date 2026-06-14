import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AuthSocialButton extends StatelessWidget {
  final IconData? icon;
  final String? iconPath;
  final String text;
  final VoidCallback onTap;

  const AuthSocialButton({
    super.key,
    this.icon,
    this.iconPath,
    required this.text,
    required this.onTap,
  }) : assert(icon != null || iconPath != null, 
         'Either icon or iconPath must be provided');

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade200),
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show either IconData or Image asset
          if (iconPath != null)
            Image.asset(
              iconPath!,
              width: 24.w,
              height: 24.w,
            )
          else if (icon != null)
            Icon(icon, size: 28.sp, color: Colors.black87),
          
          SizedBox(width: 8.w),
          
          Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
