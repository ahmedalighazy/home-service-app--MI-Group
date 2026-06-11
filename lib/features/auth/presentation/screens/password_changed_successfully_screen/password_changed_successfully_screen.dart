import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

import '../../widgets/auth_primary_button.dart';

/// Password Changed Successfully Screen - Presentation Layer
class PasswordChangedSuccessfullyScreen extends StatelessWidget {
  const PasswordChangedSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80.h),
              _buildSuccessIcon(),
              SizedBox(height: 32.h),
              _buildSuccessTitle(context),
              SizedBox(height: 16.h),
              _buildSuccessMessage(context),
              SizedBox(height: 64.h),
              AuthPrimaryButton(
                label: AuthStrings.login,
                onPressed: () {
                  context.go('/sign_in');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Center(
      child: Container(
        width: 100.w,
        height: 100.w,
        decoration: BoxDecoration(
          color: AppColors.greenPrimary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_circle_outline,
          color: AppColors.greenPrimary,
          size: 60.w,
        ),
      ),
    );
  }

  Widget _buildSuccessTitle(BuildContext context) {
    return Center(
      child: Text(
        'تم تغيير كلمة المرور بنجاح',
        style: AppText.ibmHeading22(color: AppColors.dark).copyWith(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSuccessMessage(BuildContext context) {
    return Center(
      child: Text(
        AuthStrings.loginWithNewPassword,
        style: AppText.ibmDescription14(color: AppColors.secondaryText),
        textAlign: TextAlign.center,
      ),
    );
  }
}
