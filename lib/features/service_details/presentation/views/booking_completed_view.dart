import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../cubit/feature_cubit.dart';
import '../widgets/booking_tracking/booking_action_button.dart';
import '../widgets/booking_tracking/booking_flow_scaffold.dart';
import '../widgets/booking_tracking/booking_gradient_button.dart';
import '../widgets/booking_tracking/completed_work_summary.dart';
import '../widgets/booking_tracking/success_mark.dart';
import 'booking_rating_view.dart';

class BookingCompletedScreen extends StatelessWidget {
  const BookingCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BookingFlowScaffold(
      title: context.l10n.completedService,
      child: Column(
        children: [
          const SizedBox(height: 24),
          const SuccessMark(size: 58),
          const SizedBox(height: 20),
          Text(
            context.l10n.thankYouForChoosingUs,
            style: AppText.semiBold16Black.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.serviceExecutedSuccessfully,
            textAlign: TextAlign.center,
            style: AppText.regular12Grey.copyWith(height: 1.45),
          ),
          const SizedBox(height: 22),
          const CompletedWorkSummary(),
          const Spacer(),
          BookingGradientButton(
            label: context.l10n.rebookNow,
            onPressed: () {
              context.read<FeatureCubit>().resetFeature();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          const SizedBox(height: 12),
          BookingActionButton(
            label: context.l10n.rateExperience,
            isPrimary: false,
            onPressed: () {
              final featureCubit = context.read<FeatureCubit>();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: featureCubit,
                    child: const BookingRatingScreen(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
