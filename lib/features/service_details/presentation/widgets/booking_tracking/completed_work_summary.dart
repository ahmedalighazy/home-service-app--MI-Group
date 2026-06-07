import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_tracking/summary_metric_card.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/image/app_assets.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';


class CompletedWorkSummary extends StatelessWidget {
  const CompletedWorkSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(AppStrings.summaryWorkCompleted, style: AppText.semiBold14Black),
              const SizedBox(width: 8),
              Container(width: 2, height: 18, color: AppColors.primary),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
              child: SummaryMetricCard(
                icon: Icons.access_time_rounded,
                label: AppStrings.timeSpent,
                value: AppStrings.oneHundredEightyMinutes,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: SummaryMetricCard(
                icon: Icons.cleaning_services_outlined,
                label: AppStrings.typeService,
                value: AppStrings.cleaningHome2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffF8FAFB),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  AppAssets.serviceItem,
                  width: 92,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppStrings.eightRoomsCompleted,
                      style: AppText.semiBold12Black.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.fullLivingRoomKitchenBedroomsWithCleaningComplete,
                      textAlign: TextAlign.end,
                      style: AppText.regular12Grey.copyWith(height: 1.35),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

