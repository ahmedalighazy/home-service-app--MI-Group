import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import 'booking_flow_app_bar.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class BookingFlowScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomButton;
  final VoidCallback? onBack;

  const BookingFlowScaffold({
    super.key,
    required this.title,
    required this.child,
    this.bottomButton,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppStrings.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: BookingFlowAppBar(
          title: title,
          onBack: onBack ?? () => Navigator.maybePop(context),
        ),
        body: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              10,
              12,
              10,
              bottomButton == null ? 18 : 100,
            ),
            child: child,
          ),
        ),
        bottomSheet: bottomButton == null
            ? null
            : Container(
                color: AppColors.white,
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 28),
                child: bottomButton,
              ),
      ),
    );
  }
}
