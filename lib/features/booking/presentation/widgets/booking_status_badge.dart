import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class BookingStatusBadge extends StatelessWidget {
  final String status;

  const BookingStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: _getBgColor(),
        borderRadius: BorderRadius.circular(44.r),
      ),
      child: Text(
        status,
        style: AppText.ibmDescription12(color: _getTextColor()),
      ),
    );
  }

  Color _getBgColor() {
    switch (status) {
      case 'مجدولة':
        return AppColors.light;
      case 'قيد التنفيذ':
        return AppColors.bgWarning;
      case 'مكتمله':
        return const Color(0xFFECFDF5);
      case 'ملغاة':
        return AppColors.bgError;
      default:
        return AppColors.inputBg;
    }
  }

  Color _getTextColor() {
    switch (status) {
      case 'مجدولة':
        return AppColors.primary;
      case 'قيد التنفيذ':
        return AppColors.warningText;
      case 'مكتمله':
        return const Color(0xFF10B981);
      case 'ملغاة':
        return AppColors.errorRed;
      default:
        return AppColors.textDarkGrey;
    }
  }
}
