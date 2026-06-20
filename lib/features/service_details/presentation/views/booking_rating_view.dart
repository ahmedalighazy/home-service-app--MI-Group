import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import '../cubit/feature_cubit.dart';
import '../cubit/feature_state.dart';
import '../widgets/booking_tracking/booking_flow_scaffold.dart';
import '../widgets/booking_tracking/booking_gradient_button.dart';
import '../widgets/booking_tracking/rating_input_card.dart';
import '../widgets/dialogs/rating_success_dialog.dart';

class BookingRatingScreen extends StatefulWidget {
  const BookingRatingScreen({super.key});

  @override
  State<BookingRatingScreen> createState() => _BookingRatingScreenState();
}

class _BookingRatingScreenState extends State<BookingRatingScreen> {
  final TextEditingController _teamCommentController = TextEditingController();
  final TextEditingController _serviceCommentController =
      TextEditingController();

  @override
  void dispose() {
    _teamCommentController.dispose();
    _serviceCommentController.dispose();
    super.dispose();
  }

  void _submitRating() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => RatingSuccessDialog(
        onBackToHome: () {
          context.read<FeatureCubit>().resetFeature();
          Navigator.of(context).pop();
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureCubit, FeatureState>(
      buildWhen: (previous, current) =>
          previous is! FeatureLoaded ||
          current is! FeatureLoaded ||
          previous.teamRating != current.teamRating ||
          previous.serviceRating != current.serviceRating,
      builder: (context, state) {
        final loaded = state is FeatureLoaded ? state : const FeatureLoaded();
        final cubit = context.read<FeatureCubit>();

        return BookingFlowScaffold(
          title: context.l10n.serviceRating,
          bottomButton: BookingGradientButton(
            label: context.l10n.submitRating,
            onPressed: _submitRating,
          ),
          child: ListView(
            children: [
              RatingInputCard(
                title: context.l10n.teamRating,
                question: context.l10n.teamRatingQuestion,
                rating: loaded.teamRating,
                controller: _teamCommentController,
                onRatingChanged: cubit.updateTeamRating,
                onCommentChanged: cubit.updateTeamComment,
              ),
              const SizedBox(height: 20),
              RatingInputCard(
                title: context.l10n.serviceRating,
                question: context.l10n.levelOfServiceRatingQuestion,
                rating: loaded.serviceRating,
                controller: _serviceCommentController,
                onRatingChanged: cubit.updateServiceRating,
                onCommentChanged: cubit.updateServiceComment,
              ),
            ],
          ),
        );
      },
    );
  }
}
