import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../data/models/service_page_model.dart';
import '../cubit/feature_cubit.dart';
import '../cubit/feature_state.dart';
import '../widgets/service_details/order_summary_bar.dart';
import '../widgets/service_details/service_category_tab.dart';
import '../widgets/service_details/service_cover.dart';
import '../widgets/service_details/service_page_content.dart';
import '../widgets/service_details/title_section.dart';
import 'extras_step_view.dart';


class ServicePage extends StatelessWidget {
  final ServicePageModel data;
  final PageController pageController;
  final int pageCount;

  const ServicePage({
    super.key,
    required this.data,
    required this.pageController,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ColoredBox(
      color: AppColors.scaffoldBg,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ServiceCover(
                  coverImage: data.coverImage,
                  pageController: pageController,
                  pageCount: pageCount,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.014,
                  ),
                  child: TitleSection(
                    currentStep: data.currentStep,
                    totalSteps: data.totalSteps,
                    mainTitle: data.mainTitle,
                    rate: data.rate,
                    reviews: data.reviews,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocSelector<FeatureCubit, FeatureState, int>(
                  selector: (state) => state is FeatureLoaded
                      ? state.selectedServiceCategoryIndex
                      : 0,
                  builder: (context, selectedIndex) {
                    return ServiceCategoryTabBar(
                      categories: data.categories,
                      selectedIndex: selectedIndex,
                      onCategorySelected: context
                          .read<FeatureCubit>()
                          .selectServiceCategory,
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: size.height * 0.01)),
              SliverToBoxAdapter(
                child: BlocSelector<FeatureCubit, FeatureState, int>(
                  selector: (state) => state is FeatureLoaded
                      ? state.selectedServiceCategoryIndex
                      : 0,
                  builder: (context, selectedIndex) {
                    return ServicePageContent(
                      data: data,
                      selectedCategoryIndex: selectedIndex,
                    );

                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: size.height * 0.1)),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:
                BlocSelector<
                  FeatureCubit,
                  FeatureState,
                  ({bool hasItems, double total})
                >(
                  selector: (state) {
                    final loaded = state is FeatureLoaded
                        ? state
                        : const FeatureLoaded();
                    return (
                      hasItems: loaded.hasServiceCartItems,
                      total: loaded.serviceCartTotal,
                    );
                  },
                  builder: (context, cart) {
                    return AnimatedSlide(
                      offset: cart.hasItems ? Offset.zero : const Offset(0, 1),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      child: AnimatedOpacity(
                        opacity: cart.hasItems ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 250),
                        child: OrderSummaryBar(
                          total: cart.total,
                          onNext: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<FeatureCubit>(),
                                child: ExtrasStepScreen(cartTotal: cart.total),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}

