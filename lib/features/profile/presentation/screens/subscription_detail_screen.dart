import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/features/profile/data/models/subscription_model.dart';

import '../widgets/subscription_action_list.dart';
import '../widgets/subscription_status_card.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  final SubscriptionModel subscription;

  const SubscriptionDetailScreen({super.key, required this.subscription});

  @override
  State<SubscriptionDetailScreen> createState() => _SubscriptionDetailScreenState();
}

class _SubscriptionDetailScreenState extends State<SubscriptionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: CustomAppBar(
        title: AppStrings.manageSubscription,
        onBack: () => Navigator.pop(context),
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
    _showActionDialog(
      title: AppStrings.pausePopupTitle,
      content: AppStrings.pausePopupDesc,
      confirmLabel: AppStrings.confirmPauseBtn,
      onConfirm: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.subscriptionPausedMsg)),
        );
      },
    );
  }

  void _showCancelConfirmation() {
    _showActionDialog(
      title: AppStrings.cancelPopupTitle,
      content: AppStrings.cancelPopupDesc,
      confirmLabel: AppStrings.confirmCancelBtn,
      onConfirm: () => Navigator.pop(context),
    );
  }

  void _showActionDialog({
    required String title,
    required String content,
    required String confirmLabel,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(title, textAlign: TextAlign.center, style: AppText.ibmHeading16(color: AppColors.black)),
        content: Text(content, textAlign: TextAlign.center, style: AppText.ibmDescription14(color: AppColors.textLightGrey)),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppStrings.backBtn, style: AppText.ibmButton16(color: AppColors.primaryText)),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redDanger,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44.r)),
                  ),
                  child: Text(confirmLabel, style: AppText.ibmButton16(color: AppColors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
