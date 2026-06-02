import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWidgetDelete extends StatelessWidget {
  const CustomWidgetDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return  Text.rich(
  TextSpan(
    children: [
      TextSpan(
        text: 'لتأكيد حذف الحساب يرجي كتابة كلمه',
        style: TextStyle(
          color: const Color(0xFF313131) /* primary-text */,
          fontSize: 14.sp,
          fontFamily: 'IBM Plex Sans Arabic',
          fontWeight: FontWeight.w500,
          height: 1.20,
        ),
      ),
       TextSpan(
        text: ' ',
        style: TextStyle(
          color: const Color(0xFFD2503C) /* warning-text-2 */,
          fontSize: 14.sp,
          fontFamily: 'IBM Plex Sans Arabic',
          fontWeight: FontWeight.w500,
          height: 1.20,
        ),
      ),
       TextSpan(
        text: '(',
        style: TextStyle(
          color: const Color(0xFF313131) /* primary-text */,
          fontSize: 14.sp,
          fontFamily: 'IBM Plex Sans Arabic',
          fontWeight: FontWeight.w500,
          height: 1.20,
        ),
      ),
       TextSpan(
        text: 'حذف',
        style: TextStyle(
          color: const Color(0xFFD2503C) /* warning-text-2 */,
          fontSize: 14.sp,
          fontFamily: 'IBM Plex Sans Arabic',
          fontWeight: FontWeight.w500,
          height: 1.20,
        ),
      ),
       TextSpan(
        text: ') ',
        style: TextStyle(
          color:  const Color(0xFF313131) /* primary-text */,
          fontSize: 14.sp,
          fontFamily: 'IBM Plex Sans Arabic',
          fontWeight: FontWeight.w500,
          height: 1.20,
        ),
      ),
    ],
  ),
  textAlign: TextAlign.center,
);
  }
}