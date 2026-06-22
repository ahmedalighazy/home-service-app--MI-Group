import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/spacing.dart';
import '../widgets/booking_status_badge.dart';

class BookingDetailsHeader extends StatelessWidget {
  final String serviceName;
  final String status;
  final String? imageUrl;

  const BookingDetailsHeader({
    super.key,
    required this.serviceName,
    required this.status,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(serviceName, style: AppText.ibmHeading16()),
              if (imageUrl != null) ...[
                verticalSpace(8),
                _Image(imageUrl: imageUrl!),
              ],
            ],
          ),
          const Spacer(),

          BookingStatusBadge(status: status),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String imageUrl;
  const _Image({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(8.r),
        image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  }
}
