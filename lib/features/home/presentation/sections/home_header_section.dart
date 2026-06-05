import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/widgets/gradient_header.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_header.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_search_field.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientHeader(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: AppSizes.spacingMedium),
          const HomeHeader(),
          SizedBox(height: AppSizes.spacingLarge),
          const HomeSearchField(),
          SizedBox(height: AppSizes.spacingLarge),
        ],
      ),
    );
  }
}
