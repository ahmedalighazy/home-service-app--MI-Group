import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/empty_state_widget.dart';
import '../widgets/favorites_list_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bool hasFavorites = true;

    return Scaffold(
      // backgroundColor: AppColors.softWhite,
      appBar: CustomAppBar(title: context.l10n.favorites),
      body: SafeArea(
        child: hasFavorites
            ? const FavoritesListWidget()
            // ignore: dead_code
            : EmptyStateWidget(
                iconPath: IconsPath.illustrationSvg,
                title: context.l10n.noFavoritesYet,
                subtitle: context.l10n.saveServicesToAccessLater,
                onButtonPressed: () {},
                buttonLabel: context.l10n.browseServices,
              ),
      ),
    );
  }
}
