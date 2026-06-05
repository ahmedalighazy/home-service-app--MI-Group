import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:home_service_app/features/home/presentation/cubit/home_state.dart';
import 'package:home_service_app/features/home/presentation/widgets/promo_banner_card.dart';
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
                return CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: PromoBannerCard(
                        title: state.data.banner.title,
                        subTitle: state.data.banner.subTitle,
                        price: state.data.banner.price,
                        offerPrice: state.data.banner.offerPrice,
                        promoCode: state.data.banner.promoCode,
                        imagePath: state.data.banner.imagePath,
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
                        specialOfferTitle: AppStrings.specialOfferTitle,
                        serviceAvailable24h: AppStrings.serviceAvailable24h,
                      ),
                    ),
                  ],
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
