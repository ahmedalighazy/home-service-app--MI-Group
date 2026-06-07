import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';



class OrderSummaryNextButton extends StatelessWidget {
  final VoidCallback onTap;

  const OrderSummaryNextButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.36,
        height: size.height * 0.062,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff0D7A8A), Color(0xff189AB4)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        alignment: Alignment.center,
        child: Text(
          AppStrings.next,
          style: AppText.semiBold18Black.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

