import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

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
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              onPressed != null ? AppColors.dark : AppColors.dark300,
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
                  color: onPressed != null
                      ? AppColors.white
                      : AppColors.bgDisabled,
                ),
              ),
      ),
    );
  }
}
