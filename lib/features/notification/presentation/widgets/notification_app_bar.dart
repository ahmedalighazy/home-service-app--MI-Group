import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/search/presentation/widgets/back_arrow.dart';

class NotificationAppBar extends StatelessWidget {
  const NotificationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Row(
        children: [
          BackArrow(),

          Expanded(
            child: Center(
              child: Text(
                AppStrings.notifications,
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
