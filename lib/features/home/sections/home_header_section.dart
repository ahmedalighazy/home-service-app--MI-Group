import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/widgets/gradient_header.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_header.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_search_field.dart';
import 'package:home_service_app/features/home/presentation/widgets/promo_banner_card.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const GradientHeader(
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
            price: '120',
            offerPrice: 'تبدأ الأسعار من 100 ريال',
            promoCode: 'CLEAN15',
            imagePath: AppAssets.banner,
          ),

          SizedBox(height: AppSizes.spacingLarge),
        ],
      ),
    );
  }
}
