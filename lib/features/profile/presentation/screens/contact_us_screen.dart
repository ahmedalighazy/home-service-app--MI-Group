import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../widgets/contact_card.dart';
import '../widgets/contact_us_footer_note.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: AppStrings.helpCenter),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.contactInfoLabel,
              style: AppText.ibmHeading16(color: AppColors.black),
            ),
            SizedBox(height: 4.h),
            Container(width: 60.w, height: 2.h, color: AppColors.primary),
            SizedBox(height: 24.h),
            ContactCard(
              title: AppStrings.customerServiceNumberLabel,
              value: AppStrings.customerServiceNumber,
              icon: IconsPath.phone,
              onCopy: () {},
            ),
            SizedBox(height: 16.h),
            ContactCard(
              title: AppStrings.emailAddressLabel,
              value: AppStrings.supportEmailAddress,
              icon: IconsPath.email,
              onCopy: () {},
            ),
            const Spacer(),
            const ContactUsFooterNote(),
          ],
        ),
      ),
    );
  }
}
