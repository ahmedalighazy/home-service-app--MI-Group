import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.tr('welcomeBackAlt'),
      textAlign: TextAlign.start,
      style: AppText.ibmHeading22(color: AppColors.dark),
    );
  }
}
