import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/features/home/sections/home_categories_section.dart';
import 'package:home_service_app/features/home/sections/home_header_section.dart';
import 'package:home_service_app/features/home/sections/home_popular_services_section.dart';
import 'package:home_service_app/features/home/sections/home_special_offer_section.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: HomeHeaderSection()),

        SliverToBoxAdapter(child: HomeCategoriesSection()),

        SliverToBoxAdapter(child: HomePopularServicesSection()),

        SliverToBoxAdapter(
          child: SizedBox(height: AppSizes.homeToBoxAdapterHeight),
        ),

        SliverToBoxAdapter(child: HomeSpecialOfferSection()),
      ],
    );
  }
}
