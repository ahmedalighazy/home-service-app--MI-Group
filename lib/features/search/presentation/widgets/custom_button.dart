import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.textColor,
    required this.backGroundColor,
    required this.text,
  });

  final VoidCallback? onPressed;
  final Color textColor;
  final List<Color> backGroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),

        color: backGroundColor.length == 1 ? backGroundColor.first : null,

        gradient: backGroundColor.length > 1
            ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: backGroundColor,
              )
            : null,
      ),

      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
          ),
        ),
        child: Text(
          text,
          style: AppText.ibmPlexSansArabic16SemiBold.copyWith(color: textColor),
        ),
      ),
    );
  }
}
