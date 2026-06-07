import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/features/home/domain/entities/banner_entity.dart';
import 'package:home_service_app/features/home/presentation/widgets/custom_page_indicator.dart';
import 'package:home_service_app/features/home/presentation/widgets/promo_banner_card.dart';

class HomePromoBannerSection extends StatefulWidget {
  const HomePromoBannerSection({super.key, required this.banners});

  final List<BannerEntity> banners;

  @override
  State<HomePromoBannerSection> createState() => _HomePromoBannerSectionState();
}

class _HomePromoBannerSectionState extends State<HomePromoBannerSection> {
  late final PageController _pageController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: AppSizes.bannerCardHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = widget.banners[index];

              return PromoBannerCard(
                title: banner.title,
                subTitle: banner.subTitle,
                price: banner.price,
                offerPrice: banner.offerPrice,
                promoCode: banner.promoCode,
                imagePath: banner.imagePath,
              );
            },
          ),
        ),

        SizedBox(height: AppSizes.spacingMedium),

        // Page Indicator
        CustomPageIndicator(widget: widget, currentIndex: _currentIndex),
      ],
    );
  }
}
