import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/home/domain/entities/service_entity.dart';
import 'package:home_service_app/features/home/presentation/widgets/section_header.dart';
import 'package:home_service_app/features/home/presentation/widgets/service_card.dart';

class HomePopularServicesSection extends StatelessWidget {
  const HomePopularServicesSection({super.key, required this.services});

  final List<ServiceEntity> services;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: context.tr(LocaleKeys.mostRequested)),

        SizedBox(height: AppSizes.spacingMedium),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: services
                .map(
                  (service) => Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: AppSizes.paddingMedium,
                      bottom: AppSizes.paddingXLargeHeight,
                    ),
                    child: ServiceCard(service: service, onTap: () {}),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
