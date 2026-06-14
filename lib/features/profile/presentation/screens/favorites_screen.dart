import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import '../widgets/favorites_list_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This will be replaced by BLoC state in the future
    const bool hasFavorites = true;

    return Scaffold(
      // backgroundColor: AppColors.softWhite,
      appBar: const CustomAppBar(title: AppStrings.favorites),
      body: hasFavorites
          ? const FavoritesListWidget()
          : EmptyStateWidget(
              iconPath: IconsPath.illustrationSvg,
              title: AppStrings.noFavoritesYet,
              subtitle: AppStrings.saveServicesToAccessLater,
              onButtonPressed: () {},
              buttonLabel: AppStrings.browseServices,
            ),
    );
  }
}
