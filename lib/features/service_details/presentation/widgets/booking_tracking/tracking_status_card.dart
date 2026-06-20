import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_tracking/timeline_step.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_tracking/timeline_step_state.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class TrackingStatusCard extends StatelessWidget {
  final VoidCallback onCompletedTap;

  const TrackingStatusCard({super.key, required this.onCompletedTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(context.l10n.serviceStatus, style: AppText.semiBold12Black),
          const SizedBox(height: 12),
          TimelineStep(
            title: context.l10n.doneConfirmBooking,
            time: context.l10n.tenTwentyEightAm,
            state: TimelineStepState.done,
          ),
          TimelineStep(
            title: context.l10n.teamOnTheWay,
            state: TimelineStepState.active,
          ),
          TimelineStep(
            title: context.l10n.serviceInProgress,
            state: TimelineStepState.pending,
          ),
          InkWell(
            onTap: onCompletedTap,
            borderRadius: BorderRadius.circular(8),
            child: TimelineStep(
              title: context.l10n.serviceCompletedStatus,
              state: TimelineStepState.pending,
              isLast: true,
            ),
          ),
        ],
      ),
    );
  }
}
