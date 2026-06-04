import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/profile/data/models/visit_model.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class VisitCard extends StatelessWidget {
  final VisitModel visit;

  const VisitCard({super.key, required this.visit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _VisitStatusBadge(status: visit.status),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(visit.date, style: AppText.ibmHeading14(color: AppColors.primaryText)),
                  Text(visit.time, style: AppText.ibmDescription12(color: AppColors.textLightGrey)),
                ],
              ),
              SizedBox(width: 12.w),
              Icon(Iconsax.calendar_1, size: 32.r, color: AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }
}

class _VisitStatusBadge extends StatelessWidget {
  final VisitStatus status;

  const _VisitStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color text, String label) = switch (status) {
      VisitStatus.scheduled => (AppColors.primary, AppColors.white, AppStrings.scheduledStatus),
      VisitStatus.inProgress => (const Color(0xFFFFFBEB), const Color(0xFFD97706), AppStrings.inProgressStatus),
      VisitStatus.completed => (const Color(0xFFECFDF5), const Color(0xFF059669), AppStrings.resolved),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(44.r),
      ),
      child: Text(
        label,
        style: AppText.ibmDescription12(color: text).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
