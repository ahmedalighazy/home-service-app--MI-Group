import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubit/feature_cubit.dart';
import '../../cubit/feature_state.dart';
import 'corporate_hero_icon_button.dart';

class CorporateHero extends StatelessWidget {
  final String imagePath;
  final VoidCallback onBack;

  const CorporateHero({
    super.key,
    required this.imagePath,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.18,
          child: Image.asset(
            imagePath,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: BlocSelector<FeatureCubit, FeatureState, bool>(
            selector: (state) =>
                state is FeatureLoaded ? state.isCorporateFavorite : false,
            builder: (context, isFavorite) {
              return CorporateHeroIconButton(
                icon: isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                iconColor: isFavorite ? Colors.red : AppColors.black,
                onTap: context.read<FeatureCubit>().toggleCorporateFavorite,
              );
            },
          ),
        ),
        Positioned(
          top: 16,
          right: 62,
          child: CorporateHeroIconButton(
            icon: Icons.reply_rounded,
            onTap: () {},
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: CorporateHeroIconButton(
            icon: Icons.arrow_forward_rounded,
            onTap: onBack,
          ),
        ),
      ],
    );
  }
}
