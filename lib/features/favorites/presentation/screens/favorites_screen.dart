import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import '../../logic/favorites_cubit.dart';
import '../../logic/favorites_state.dart';
import '../widgets/empty_favorites_view.dart';
import '../widgets/favorites_list_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      appBar: CustomAppBar(title: context.tr(LocaleKeys.profileFavorites)),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (state is FavoritesLoaded) {
            final items = state.favoriteResponses.content ?? [];
            if (items.isEmpty) {
              return const EmptyFavoritesView();
            }
            return FavoritesListWidget(items: items);
          } else if (state is FavoritesError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: AppText.mediumIbm(
                        color: AppColors.red,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<FavoritesCubit>().getFavorites();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: Text(
                        context.tr(LocaleKeys.ok),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
