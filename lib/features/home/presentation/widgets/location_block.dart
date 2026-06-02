import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class LocationBlock extends StatelessWidget {
  const LocationBlock({
    super.key,
    required this.label,
    required this.address,
    this.onTap,
  });

  final String label;
  final String address;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label row with dropdown chevron
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: AppText.ibmButton16()),
              const SizedBox(width: AppSizes.spacingMin),
              SvgPicture.asset(
                IconsPath.arrow,
                width: AppSizes.spacingSmall,
                height: AppSizes.spacingSmall,
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spacingMin),

          // Address row with pin icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                IconsPath.location,
                width: AppSizes.spacingLarge,
                height: AppSizes.spacingLarge,
              ),
              const SizedBox(width: AppSizes.spacingMin),
              Flexible(
                child: Text(
                  address,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.ibmPlexSansArabic16SemiBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
