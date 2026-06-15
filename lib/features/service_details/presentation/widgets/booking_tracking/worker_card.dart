import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';


class WorkerCard extends StatelessWidget {
  const WorkerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xffEAFBFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              color: AppColors.primary,
              size: 19,
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(AppStrings.ibrahimMohamed, style: AppText.semiBold12Black),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '4.7',
                    style: AppText.regular10Grey.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Icon(Icons.star, color: AppColors.yellow, size: 12),
                  const SizedBox(width: 3),
                  Text(AppStrings.text150, style: AppText.regular10Grey),
                ],
              ),
            ],
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xffEAFBFF),
            child: Text(
              AppStrings.ibrahimInitial,
              style: AppText.bold14Black.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

