import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';


class CorporateSubmitButton extends StatelessWidget {
  final VoidCallback onTap;

  const CorporateSubmitButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, Color(0xff075C69)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          AppStrings.requestInspection,
          style: AppText.semiBold16Black.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

