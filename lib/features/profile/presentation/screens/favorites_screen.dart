import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import '../widgets/favorites_list_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This will be replaced by BLoC state in the future
    bool hasFavorites =
        true; // Changed to false to test empty state or leave as variable

    return Scaffold(
      appBar: CustomAppBar(title: context.tr(LocaleKeys.profileFavorites)),
      body: hasFavorites
          ? const FavoritesListWidget()
          // ignore: dead_code
          : EmptyStateWidget(
              iconPath: IconsPath.illustrationSvg,
              title: context.tr(LocaleKeys.profileNoFavoritesYet),
              subtitle: context.tr(LocaleKeys.profileSaveServicesHint),
              onButtonPressed: () {},
              buttonLabel: context.tr(LocaleKeys.homeBrowseServices),
            ),
    );
  }
}
