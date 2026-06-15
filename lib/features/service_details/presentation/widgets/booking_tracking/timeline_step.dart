import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_tracking/timeline_step_state.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class TimelineStep extends StatelessWidget {
  final String title;
  final String? time;
  final TimelineStepState state;
  final bool isLast;

  const TimelineStep({
    super.key,
    required this.title,
    required this.state,
    this.time,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = state == TimelineStepState.pending;
    final color = isPending ? AppColors.lightGrey : AppColors.primary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: AppText.regular12Grey.copyWith(
                    color: isPending ? AppColors.body : AppColors.black,
                    fontWeight: isPending ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
                if (time != null) ...[
                  const SizedBox(height: 2),
                  Text(time!, style: AppText.regular10Grey),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: state == TimelineStepState.active
                    ? AppColors.white
                    : color,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: Icon(
                state == TimelineStepState.done
                    ? Icons.check_rounded
                    : Icons.circle,
                color: state == TimelineStepState.active
                    ? AppColors.primary
                    : AppColors.white,
                size: state == TimelineStepState.done ? 16 : 8,
              ),
            ),
            if (!isLast) Container(width: 2, height: 42, color: color),
          ],
        ),
      ],
    );
  }
}

