import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/features/profile/data/models/subscription_model.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';

import '../../../../core/utils/helpers/show_dialog.dart';
import '../widgets/subscription_action_list.dart';
import '../widgets/subscription_status_card.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  final SubscriptionModel subscription;

  const SubscriptionDetailScreen({super.key, required this.subscription});

  @override
  State<SubscriptionDetailScreen> createState() =>
      _SubscriptionDetailScreenState();
}

class _SubscriptionDetailScreenState extends State<SubscriptionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(
        title: context.tr(LocaleKeys.profileManageSubscription),
        onBack: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingM.r),
        child: Column(
          children: [
            SubscriptionStatusCard(subscription: widget.subscription),
            verticalSpace(24),
            SubscriptionActionList(
              onPauseTap: _showPauseConfirmation,
              onCancelTap: _showCancelConfirmation,
            ),
          ],
        ),
      ),
    );
  }

  void _showPauseConfirmation() {
    showCannotDeleteDialogred(
      context,
      context.tr(LocaleKeys.profilePausePopupTitle),
      context.tr(LocaleKeys.profilePausePopupDesc),
      context.tr(LocaleKeys.profileConfirmPauseBtn),
    );
  }

  void _showCancelConfirmation() {
    showCannotDeleteDialogred(
      context,
      context.tr(LocaleKeys.profileCancelPopupTitle),
      context.tr(LocaleKeys.profileCancelPopupDesc),
      context.tr(LocaleKeys.profileConfirmCancelBtn),
    );
  }
}
