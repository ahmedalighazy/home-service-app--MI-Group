import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class BookingTabsHeader extends StatelessWidget {
  const BookingTabsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      child: Row(
        children: [
          Text(
            AppStrings.navBookings,
            style: AppText.boldIbm(
              color: AppColors.black,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            IconsPath.notificationNew,
            width: 23.w,
            height: 23.h,
          ),
        ],
      ),
    );
  }
}
