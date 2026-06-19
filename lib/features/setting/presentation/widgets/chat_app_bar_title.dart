import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

import 'chat_status_badge.dart';

class ChatAppBarTitle extends StatelessWidget {
  const ChatAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            context.tr(LocaleKeys.helpCenterTicketTitle1),
            style: AppText.semiBoldText(
              color: AppColors.headingText,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const ChatStatusBadge(),
        horizontalSpace(8),
        Text(
          '${context.tr(LocaleKeys.helpCenterTicketPrefix)}1001',
          style: AppText.regularText(
            color: AppColors.secondaryText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
