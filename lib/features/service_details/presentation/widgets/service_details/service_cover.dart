import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_cover_icon_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubit/feature_cubit.dart';
import '../../cubit/feature_state.dart';

class ServiceCover extends StatelessWidget {
  final String coverImage;
  final PageController pageController;
  final int pageCount;

  const ServiceCover({
    super.key,
    required this.coverImage,
    required this.pageController,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.30,
      child: Stack(
        children: [
          // Background image
          Image.asset(coverImage, fit: BoxFit.cover, width: double.infinity),

          //  Action buttons row
          Positioned(
            top: size.height * 0.015,
            left: size.width * 0.04,
            right: size.width * 0.04,
            child: Row(
              children: [
                BlocSelector<FeatureCubit, FeatureState, bool>(
                  selector: (state) => state is FeatureLoaded
                      ? state.isServiceCoverFavorite
                      : false,
                  builder: (context, isFavorite) {
                    return ServiceCoverIconButton(
                      icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                      iconColor: isFavorite ? Colors.red : AppColors.black,
                      onTap: context
                          .read<FeatureCubit>()
                          .toggleServiceCoverFavorite,
                    );
                  },
                ),
                SizedBox(width: size.width * 0.02),
                ServiceCoverIconButton(
                  icon: Icons.share_outlined,
                  iconColor: AppColors.black,
                  onTap: () {},
                ),
                const Spacer(),
                ServiceCoverIconButton(
                  icon: Icons.arrow_forward,
                  iconColor: AppColors.black,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          // SmoothPageIndicator
          Positioned(
            bottom: size.height * 0.012,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: pageCount,
                  effect: ExpandingDotsEffect(
                    dotWidth: size.width * 0.021,
                    dotHeight: size.width * 0.021,
                    expansionFactor: 3,
                    spacing: size.width * 0.014,
                    dotColor: AppColors.lightGrey,
                    activeDotColor: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

