import 'package:flutter/material.dart';
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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Center(
                child: Text(
                  AppStrings.navAccount,
                  textAlign: TextAlign.center,
                  style: AppText.semiBoldIbm(
                    color: AppColors.headingText,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
