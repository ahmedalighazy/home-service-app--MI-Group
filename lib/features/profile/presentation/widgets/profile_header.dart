import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/buttom_curve_clipper.dart';
import '../../../../core/utils/l10n/app_strings.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: BottomCurveClipper(),
          child: Container(
            height:
                height(context) * 0.28, // Takes up roughly 28% of the screen
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.greenPrimary, AppColors.white],
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.h, left: 20, right: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      AppStrings.navAccount,
                      textAlign: TextAlign.center,
                      style: AppText.semiBoldIbm(
                        color: AppColors.headingText,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD4E8ED) /* green-l-light */,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44),
                        ),
                      ),
                      child: SvgPicture.asset(
                        IconsPath.notificationNew,
                        width: 25.w,
                        height: 25.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
