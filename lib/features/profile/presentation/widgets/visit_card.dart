import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/features/profile/data/models/visit_model.dart';

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
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: ShapeDecoration(
              color: const Color(0x00e9fbff) /* green-56% */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            child: SvgPicture.asset(
              IconsPath.calenderBlue,
              height: 20.h,
              width: 20,
            ),
          ),
          horizontalSpace(12),

          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    visit.date,
                    style: AppText.ibmHeading14(color: AppColors.primaryText),
                  ),
                  Text(
                    visit.time,
                    style: AppText.ibmDescription12(
                      color: AppColors.textLightGrey,
                    ),
                  ),
                ],
              ),
              // Icon(Iconsax.calendar_1, size: 32.r, color: AppColors.primary),
            ],
          ),
          const Spacer(),

          _VisitStatusBadge(status: visit.status),
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
    final (Color bg, Color text, String key) = switch (status) {
      VisitStatus.scheduled => (
        AppColors.primary,
        AppColors.white,
        LocaleKeys.profileVisitStatusScheduled,
      ),
      VisitStatus.inProgress => (
        const Color(0xFFFFFBEB),
        const Color(0xFFD97706),
        LocaleKeys.profileVisitStatusInProgress,
      ),
      VisitStatus.completed => (
        const Color(0xFFECFDF5),
        const Color(0xFF059669),
        LocaleKeys.profileVisitStatusCompleted,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(44.r),
      ),
      child: Text(
        context.tr(key),
        style: AppText.ibmDescription12(
          color: text,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
