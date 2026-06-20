import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import 'chat_status_badge.dart';

class ChatAppBarTitle extends StatelessWidget {
  const ChatAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            context.l10n.ticketTitle1,
            style: AppText.semiBoldText(
              color: AppColors.headingText,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const ChatStatusBadge(),
        SizedBox(width: 8.w),
        Text(
          'TKT.1001',
          style: AppText.regularText(
            color: AppColors.secondaryText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
