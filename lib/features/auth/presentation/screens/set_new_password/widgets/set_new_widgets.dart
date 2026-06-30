import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import '../../../../../../core/utils/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/language/language_cubit.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class PasswordInputField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Color borderColor;
  final VoidCallback onObscurePressed;

  const PasswordInputField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.borderColor,
    required this.onObscurePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            textAlign: context.watch<LanguageCubit>().state.isArabic
                ? TextAlign.right
                : TextAlign.left,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              prefixIcon: IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: onObscurePressed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SetNewPasswordErrorText extends StatelessWidget {
  const SetNewPasswordErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: context.watch<LanguageCubit>().state.isArabic
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Text(
          context.tr('passwordMismatch'),
          style: TextStyle(color: AppColors.errorRed, fontSize: 12),
        ),
      ),
    );
  }
}

class SetNewPasswordButton extends StatelessWidget {
  final bool isSuccess;
  final bool isLoading;
  final VoidCallback? onPressed;

  const SetNewPasswordButton({
    super.key,
    required this.isSuccess,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isSuccess && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSuccess ? AppColors.dark : AppColors.dark300,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                context.tr('confirm'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSuccess ? AppColors.white : AppColors.bgDisabled,
                ),
              ),
      ),
    );
  }
}

class SetNewPasswordSuccessDialog extends StatelessWidget {
  final BuildContext parentContext;

  const SetNewPasswordSuccessDialog({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.watch<LanguageCubit>().state.isArabic
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
