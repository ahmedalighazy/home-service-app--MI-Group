import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/feature_cubit.dart';
import '../widgets/booking_tracking/arrival_card.dart';
import '../widgets/booking_tracking/booking_flow_scaffold.dart';
import '../widgets/booking_tracking/tracking_status_card.dart';
import '../widgets/booking_tracking/worker_card.dart';
import 'booking_completed_view.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class BookingTrackingScreen extends StatelessWidget {
  const BookingTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BookingFlowScaffold(
      title: SdStrings.trackingOrder,
      child: ListView(
        children: [
          const ArrivalCard(),
          const SizedBox(height: 12),
          TrackingStatusCard(
            onCompletedTap: () {
              final featureCubit = context.read<FeatureCubit>();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: featureCubit,
                    child: const BookingCompletedScreen(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          const WorkerCard(),
        ],
      ),
    );
  }
}
