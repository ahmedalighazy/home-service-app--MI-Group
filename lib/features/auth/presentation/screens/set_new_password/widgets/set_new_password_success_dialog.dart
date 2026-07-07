import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/language/language_cubit.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

import '../../../../../../core/utils/l10n/localization_extension.dart';

class SetNewPasswordSuccessDialog extends StatelessWidget {
  final BuildContext parentContext;

  const SetNewPasswordSuccessDialog({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          context.select<LanguageCubit, bool>((c) => c.state.isArabic)
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpace(10.h),
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: AppColors.successBackground,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      color: AppColors.successPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ),
              ),
              verticalSpace(28.h),
              Text(
                context.tr('successPasswordReset'),
                style: AppText.ibmHeading22(color: AppColors.black),
              ),
              verticalSpace(10.h),
              Text(
                context.tr('loginWithNewPassword'),
                textAlign: TextAlign.center,
                style: AppText.ibmDescription14(color: AppColors.grayDark),
              ),
              verticalSpace(28.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    GoRouter.of(parentContext).pop();
                    GoRouter.of(parentContext).go(AppRouter.signIn);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: Text(
                    context.tr('backToSignIn'),
                    style: AppText.ibmButton16(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
