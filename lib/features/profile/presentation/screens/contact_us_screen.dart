import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../widgets/contact_card.dart';
import '../widgets/contact_us_footer_note.dart';
import '../../../../core/constants/icons_path.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: AppStrings.helpCenter),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr(LocaleKeys.profileContactInfoLabel),
              style: AppText.ibmHeading16(color: AppColors.black),
            ),
            verticalSpace(4),
            Container(width: 60.w, height: 2.h, color: AppColors.primary),
            verticalSpace(24),
            ContactCard(
              title: context.tr(LocaleKeys.profileCustomerServiceNumberLabel),
              value: context.tr(LocaleKeys.profileCustomerServiceNumber),
              icon: IconsPath.phone,
              onCopy: () {},
            ),
            verticalSpace(16),
            ContactCard(
              title: context.tr(LocaleKeys.profileEmailAddressLabel),
              value: context.tr(LocaleKeys.profileSupportEmailAddress),
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
