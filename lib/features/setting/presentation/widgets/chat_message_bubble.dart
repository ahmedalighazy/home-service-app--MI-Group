import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../data/models/message_model.dart';
import '../../domain/entities/message_entity.dart';

class ChatMessageBubble extends StatelessWidget {
  final MessageModel message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isUser = message.sender == MessageSender.user;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isUser ? AppColors.greenPrimary : AppColors.darkHover2,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
                topLeft: isUser ? Radius.circular(12.r) : Radius.zero,
                topRight: isUser ? Radius.zero : Radius.circular(12.r),
              ),
            ),
            child: Text(
              message.content,
              style: AppText.regularText(
                color: isUser ? AppColors.bgPrimary : AppColors.primaryText,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
            style: AppText.regularText(
              color: AppColors.secondaryText,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
