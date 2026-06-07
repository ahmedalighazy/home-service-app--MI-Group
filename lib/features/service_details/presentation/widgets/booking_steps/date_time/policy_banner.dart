import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';


class PolicyBanner extends StatelessWidget {
  const PolicyBanner({super.key});

  static const String _policyText =
      AppStrings.cancelBookingOrModifyBeforeNumber5 +
      AppStrings.caseBeforeLessFromNumber5HourWillBe;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Icon + policy text
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.003),
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.body,
                  size: 18,
                ),
              ),
              SizedBox(width: size.width * 0.025),
              Expanded(
                child: Text(
                  _policyText,
                  style: AppText.regular12Grey,
                  textAlign: TextAlign.end,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),

          SizedBox(height: size.height * 0.01),

          // AppStrings.showDetails link
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                AppStrings.showDetails,
                style: AppText.semiBold12Black.copyWith(
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

