import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/favorite_responses.dart';
import '../data/repos/favorites_repo.dart';
import '../data/repos/local_favorites_manager.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo _favoritesRepo;

  FavoritesCubit(this._favoritesRepo) : super(FavoritesInitial());

  Future<void> getFavorites() async {
    emit(FavoritesLoading());
    
    // Load local items
    final localItems = LocalFavoritesManager.getLocalFavorites();

    final result = await _favoritesRepo.getFavorites();
    result.when(
      success: (remoteData) {
        final remoteItems = remoteData.content ?? [];
        final mergedItems = [...localItems];
        for (final remoteItem in remoteItems) {
          if (!mergedItems.any((e) => e.id == remoteItem.id)) {
            mergedItems.add(remoteItem);
          }
        }
        LocalFavoritesManager.saveAllFavorites(mergedItems);

        final response = FavoriteResponses(
          totalElements: mergedItems.length,
          totalPages: remoteData.totalPages,
          pageable: remoteData.pageable,
          first: remoteData.first,
          last: remoteData.last,
          size: remoteData.size,
          content: mergedItems,
          number: remoteData.number,
          sort: remoteData.sort,
          numberOfElements: mergedItems.length,
          empty: mergedItems.isEmpty,
        );
        emit(FavoritesLoaded(response));
      },
      failure: (error) {
        // If remote fails, fallback to local favorites if they exist
        if (localItems.isNotEmpty) {
          final response = FavoriteResponses(
            totalElements: localItems.length,
            content: localItems,
            empty: false,
          );
          emit(FavoritesLoaded(response));
        } else {
          emit(FavoritesError(error.message ?? 'Unknown error occurred'));
        }
      },
    );
  }

  Future<void> removeFavorite(String listingId) async {
    // Remove locally
    await LocalFavoritesManager.removeFavorite(listingId);

    final currentState = state;
    if (currentState is FavoritesLoaded) {
      final oldContent = currentState.favoriteResponses.content;
      final updatedContent = oldContent
          ?.where((element) => element.id != listingId)
          .toList();
      
      final updatedResponses = FavoriteResponses(
        totalElements: (currentState.favoriteResponses.totalElements ?? 1) - 1,
        totalPages: currentState.favoriteResponses.totalPages,
        pageable: currentState.favoriteResponses.pageable,
        first: currentState.favoriteResponses.first,
        last: currentState.favoriteResponses.last,
        size: currentState.favoriteResponses.size,
        content: updatedContent,
        number: currentState.favoriteResponses.number,
        sort: currentState.favoriteResponses.sort,
        numberOfElements: (currentState.favoriteResponses.numberOfElements ?? 1) - 1,
        empty: updatedContent?.isEmpty ?? true,
      );

      // Optimistically update the UI
      emit(FavoritesLoaded(updatedResponses));

      final result = await _favoritesRepo.removeFavorite(listingId);
      result.when(
        success: (_) {
          // Keep updated
        },
        failure: (error) {
          // Revert back on error
          getFavorites();
        },
      );
    }
  }

  Future<void> addFavorite(String listingId) async {
    final result = await _favoritesRepo.addFavorite(listingId);
    result.when(
      success: (_) {
        getFavorites();
      },
      failure: (error) {
        getFavorites();
      },
    );
  }
}

