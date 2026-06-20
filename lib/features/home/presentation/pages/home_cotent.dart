import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:home_service_app/features/home/presentation/cubit/home_state.dart';
import 'package:home_service_app/features/home/presentation/sections/home_promo_banner_section.dart';
import 'package:home_service_app/features/home/presentation/sections/home_categories_section.dart';
import 'package:home_service_app/features/home/presentation/sections/home_header_section.dart';
import 'package:home_service_app/features/home/presentation/sections/home_popular_services_section.dart';
import 'package:home_service_app/features/home/presentation/sections/home_special_offer_section.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeaderSection(),

        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is HomeError) {
                return Center(child: Text(state.message));
              }

              if (state is HomeLoaded) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: HomePromoBannerSection(
                          banners: state.data.banners,
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: HomeCategoriesSection(
                          categories: state.data.categories,
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: HomePopularServicesSection(
                          services: state.data.services,
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: HomeSpecialOfferSection(
                          specialOfferTitle: context.l10n.specialOfferTitle,
                          serviceAvailable24h: context.l10n.serviceAvailable24h,
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: SizedBox(height: AppSizes.spacingXLarge),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
