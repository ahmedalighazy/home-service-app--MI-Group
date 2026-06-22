import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_steps/order_summary/payment_summary_tile.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_steps/order_summary/total_row.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../../data/models/extra_item_model.dart';
import '../../../cubit/feature_cubit.dart';
import '../../../cubit/feature_state.dart';
import '../../../views/booking_tracking_view.dart';
import '../../dialogs/booking_failure_dialog.dart';
import '../../dialogs/booking_success_dialog.dart';
import 'confirm_button.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class SummaryBottomSheet extends StatefulWidget {
  static const String bookingReference = 'LMS-125846';

  final double total;
  final List<ExtraItem> selectedExtras;

  const SummaryBottomSheet({
    super.key,
    required this.total,
    this.selectedExtras = const [],
  });

  @override
  State<SummaryBottomSheet> createState() => _SummaryBottomSheetState();
}

class _SummaryBottomSheetState extends State<SummaryBottomSheet> {
  void _confirmBooking() {
    final rootNavigator = Navigator.of(context, rootNavigator: true);
    final featureCubit = context.read<FeatureCubit>();
    final featureState = featureCubit.state;
    final isBookingSuccessful = featureState is FeatureLoaded
        ? featureState.isBookingSuccessful
        : true;

    Navigator.of(context).pop();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<void>(
        context: rootNavigator.context,
        barrierDismissible: false,
        builder: (_) => isBookingSuccessful
            ? BookingSuccessDialog(
                bookingReference: SummaryBottomSheet.bookingReference,
                onBackToHome: () {
                  featureCubit.resetFeature();
                  rootNavigator.pop();
                  rootNavigator.popUntil((route) => route.isFirst);
                },
                onTrackBooking: () {
                  rootNavigator.pop();
                  rootNavigator.push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: featureCubit,
                        child: const BookingTrackingScreen(),
                      ),
                    ),
                  );
                },
              )
            : BookingFailureDialog(
                onRetry: rootNavigator.pop,
                onChangePaymentMethod: rootNavigator.pop,
              ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.05,
        size.height * 0.008,
        size.width * 0.05,
        size.height * 0.03,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: size.height * 0.016),

          Text(SdStrings.summaryBooking, style: AppText.semiBold18Black),

          SizedBox(height: size.height * 0.016),
          const Divider(color: AppColors.border, height: 1),
          SizedBox(height: size.height * 0.012),

          PaymentSummaryTile(selectedExtras: widget.selectedExtras),

          SizedBox(height: size.height * 0.018),

          ConfirmButton(onPressed: _confirmBooking),

          SizedBox(height: size.height * 0.012),

          TotalRow(total: widget.total),
        ],
      ),
    );
  }
}
