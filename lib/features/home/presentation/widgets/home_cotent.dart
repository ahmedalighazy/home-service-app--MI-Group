import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/widgets/gradient_header.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_header.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_search_field.dart';
import 'package:home_service_app/features/home/presentation/widgets/promo_banner_card.dart';
import 'package:home_service_app/features/home/presentation/widgets/service_card.dart';
import 'package:home_service_app/features/home/presentation/widgets/service_category_card.dart';
import 'package:home_service_app/features/home/presentation/widgets/special_offer_banner.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header Section with Gradient
        const SliverToBoxAdapter(
          child: GradientHeader(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: AppSizes.spacingMedium),
                HomeHeader(),
                SizedBox(height: AppSizes.spacingLarge),
                HomeSearchField(),
                SizedBox(height: AppSizes.spacingLarge),
                PromoBannerCard(
                  title: 'أنس أعمال التنظيف بعد العمل',
                  subTitle: 'تنظيف بالساعة',
                  price: '120 ',
                  offerPrice: 'تبدأ الأسعار من 100 ريال',
                  promoCode: 'CLEAN15',
                  imagePath: AppAssets.banner,
                ),
                SizedBox(height: AppSizes.spacingLarge),
              ],
            ),
          ),
        ),

        // Service Categories Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Row(
                children: [
                  ServiceCategoryCard(
                    icon: Iconsax.building_copy,
                    title: 'خدمات المؤسسات',
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  ServiceCategoryCard(
                    icon: Iconsax.security_safe_copy,
                    title: 'خدمات مكافحة الحشرات',
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  ServiceCategoryCard(
                    icon: Iconsax.broom_copy,
                    title: 'تنظيف منزل',
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  ServiceCategoryCard(
                    icon: Iconsax.heart_copy,
                    title: 'تنظيف منزل عميق',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),

        // Popular Services Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'عرض الكل',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryGrey,
                        ),
                      ),
                    ),
                    const Text(
                      'الاكثر طلبا',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    children: [
                      ServiceCard(
                        title: 'تنظيف الزجاج',
                        imagePath: 'assets/images/Rectangle 45.png',
                        badge: 'جديد',
                        onTap: () {},
                      ),
                      const SizedBox(width: 16),
                      ServiceCard(
                        title: 'القضاء علي الحشرات',
                        imagePath: AppAssets.banner,
                        discount: 'خصم يصل لـ %20',
                        onTap: () {},
                      ),
                      const SizedBox(width: 16),
                      ServiceCard(
                        title: 'تنظيف أثاث عميق',
                        imagePath:
                            'assets/images/Gemini_Generated_Image_easzy8easzy8easz 1.png',
                        discount: 'خصم يصل لـ %70',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Special Offer Banner
        const SliverToBoxAdapter(child: SpecialOfferBanner()),

        SliverToBoxAdapter(
          child: SizedBox(height: AppSizes.homeToBoxAdapterHeight),
        ),
      ],
    );
  }
}
