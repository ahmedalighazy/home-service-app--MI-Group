import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
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
                context.l10n.notifications,
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
