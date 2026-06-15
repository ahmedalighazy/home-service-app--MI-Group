import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'logic/pass_logic.dart';
import 'widget/pass_widgets.dart';

class PasswordChangedSuccessfullyScreen extends StatelessWidget {
  const PasswordChangedSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = PasswordChangedLogic();

    return Scaffold(
      backgroundColor: AppColors.primaryGrey,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.tr('passwordChangedTitle'),
                style: AppText.ibmDescription14(
                  color: AppColors.white.withValues(alpha: 0.4),
                ),
              ),
              verticalSpace(20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 36.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SuccessIcon(),
                    verticalSpace(24),
                    const SuccessTextSection(),
                    verticalSpace(32),
                    SuccessGradientButton(
                      onPressed: () => logic.onSignInPressed(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
