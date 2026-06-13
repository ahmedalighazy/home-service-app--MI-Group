import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/utils/helpers/spacing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/booking_model.dart';
import 'booking_status_badge.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback onViewDetails;

  const BookingCard({
    super.key,
    required this.booking,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        children: [
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     _BookingImage(imageUrl: booking.imageUrl),
          //     horizontalSpace(8),
          //     _BookingInfo(booking: booking),
          //     const Spacer(),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,

          //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         BookingStatusBadge(status: booking.status),
          //         verticalSpace(40),

          //         _BookingActions(onViewDetails: onViewDetails),
          //       ],
          //     ),
          //   ],
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BookingImage(imageUrl: booking.imageUrl),
              horizontalSpace(8),

              Expanded(child: _BookingInfo(booking: booking)),

              horizontalSpace(8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BookingStatusBadge(status: booking.status),
                  verticalSpace(40),
                  _BookingActions(onViewDetails: onViewDetails),
                ],
              ),
            ],
          ),
          verticalSpace(16),
        ],
      ),
    );
  }
}

class _BookingImage extends StatelessWidget {
  final String? imageUrl;
  const _BookingImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73.w,
      height: 100.h,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl ?? ''),
          fit: BoxFit.cover,
        ),
        color: AppColors.inputBg,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _BookingInfo extends StatelessWidget {
  final BookingModel booking;
  const _BookingInfo({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(booking.serviceName, style: AppText.ibmHeading16()),
        verticalSpace(4),
        _InfoRow(icon: IconsPath.location, text: booking.address),
        verticalSpace(4),
        _InfoRow(icon: IconsPath.calendar, text: booking.date),
        verticalSpace(4),
        _InfoRow(icon: IconsPath.time, text: booking.time),
      ],
    );
  }
}

// class _InfoRow extends StatelessWidget {
//   final String icon;
//   final String text;
//   const _InfoRow({required this.icon, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SvgPicture.asset(icon, width: 14.w, color: AppColors.textLightGrey),
//         horizontalSpace(6),
//         Text(text, style: AppText.ibmDescription12()),
//       ],
//     );
//   }
// }
class _InfoRow extends StatelessWidget {
  final String icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 14.w, color: AppColors.textLightGrey),
        horizontalSpace(6),

        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.ibmDescription12(),
          ),
        ),
      ],
    );
  }
}

class _BookingActions extends StatelessWidget {
  final VoidCallback onViewDetails;
  const _BookingActions({required this.onViewDetails});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: onViewDetails,
        child: Container(
          height: 33.h,
          padding: EdgeInsets.only(left: 8.r, right: 8.r),
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, 0.50),
              end: Alignment(1.00, 0.50),
              colors: [const Color(0xFF189AB4), const Color(0xFF0A424E)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(44),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 10,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                AppStrings.viewDetails,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontWeight: FontWeight.w600,
                  height: 1.40,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
