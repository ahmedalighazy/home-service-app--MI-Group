import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';

class NotificationAppBar extends StatelessWidget {
  const NotificationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Row(
        children: [
          CustomBackArrowButton(),

          Expanded(
            child: Center(
              child: Text(
                context.tr(LocaleKeys.notifications),
                style: AppText.ibmPlexSansArabic16SemiBold,
              ),
            ),
          ),

          SizedBox(width: AppSizes.iconSizeXLarge),
        ],
      ),
    );
  }
}
