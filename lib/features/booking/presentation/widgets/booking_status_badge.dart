import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class BookingStatusBadge extends StatelessWidget {
  final String status;

  const BookingStatusBadge({super.key, required this.status});

  static const Map<String, String> _statusToKey = {
    'مجدولة': LocaleKeys.bookingStatusScheduled,
    'Scheduled': LocaleKeys.bookingStatusScheduled,
    'قيد التنفيذ': LocaleKeys.bookingStatusInProgress,
    'In Progress': LocaleKeys.bookingStatusInProgress,
    'مكتمله': LocaleKeys.bookingStatusCompleted,
    'Completed': LocaleKeys.bookingStatusCompleted,
    'ملغاة': LocaleKeys.bookingStatusCancelled,
    'Cancelled': LocaleKeys.bookingStatusCancelled,
  };

  @override
  Widget build(BuildContext context) {
    final String statusKey = _statusToKey[status] ?? status;
    final String localizedStatus = context.tr(statusKey);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: _getBgColor(statusKey),
        borderRadius: BorderRadius.circular(44.r),
      ),
      child: Text(
        localizedStatus,
        style: AppText.ibmDescription12(color: _getTextColor(statusKey)),
      ),
    );
  }

  Color _getBgColor(String statusKey) {
    switch (statusKey) {
      case LocaleKeys.bookingStatusScheduled:
        return AppColors.light;
      case LocaleKeys.bookingStatusInProgress:
        return AppColors.bgWarning;
      case LocaleKeys.bookingStatusCompleted:
        return const Color(0xFFECFDF5);
      case LocaleKeys.bookingStatusCancelled:
        return AppColors.bgError;
      default:
        return AppColors.inputBg;
    }
  }

  Color _getTextColor(String statusKey) {
    switch (statusKey) {
      case LocaleKeys.bookingStatusScheduled:
        return AppColors.primary;
      case LocaleKeys.bookingStatusInProgress:
        return AppColors.warningText;
      case LocaleKeys.bookingStatusCompleted:
        return const Color(0xFF10B981);
      case LocaleKeys.bookingStatusCancelled:
        return AppColors.errorRed;
      default:
        return AppColors.textDarkGrey;
    }
  }
}
