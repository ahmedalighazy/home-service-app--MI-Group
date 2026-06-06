import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/utils/l10n/app_strings.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../widgets/favorites_list_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bool hasFavorites = true;

    return Scaffold(
      // backgroundColor: AppColors.softWhite,
      appBar: const CustomAppBar(title: AppStrings.favorites),
      body: SafeArea(
        child: hasFavorites
            ? const FavoritesListWidget()
            : EmptyStateWidget(
                iconPath: IconsPath.illustrationSvg,
                title: AppStrings.noFavoritesYet,
                subtitle: AppStrings.saveServicesToAccessLater,
                onButtonPressed: () {},
                buttonLabel: AppStrings.browseServices,
              ),
      ),
    );
  }
}
