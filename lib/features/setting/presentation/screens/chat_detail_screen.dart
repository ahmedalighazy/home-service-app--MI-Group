import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_status_badge.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  // TODO: This should come from route arguments / state
  static const bool _isResolved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: AppStrings.ticketTitle1,
        widget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const ChatStatusBadge(),
              SizedBox(width: 8.w),
              Text(
                'TKT.1001',
                style: AppText.regularIbm(color: AppColors.secondaryText, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.r),
              children: const [
                SupportMessageBubble(text: AppStrings.supportMsg1, time: '10:00 AM'),
                UserMessageBubble(text: AppStrings.userMsg1, time: '10:05 AM'),
              ],
            ),
          ),
          if (!_isResolved) const ChatInputBar(),
        ],
      ),
    );
  }
}
