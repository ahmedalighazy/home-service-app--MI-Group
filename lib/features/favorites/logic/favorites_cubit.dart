import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/favorite_responses.dart';
import '../data/repos/favorites_repo.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo _favoritesRepo;

  FavoritesCubit(this._favoritesRepo) : super(FavoritesInitial());

  Future<void> getFavorites() async {
    emit(FavoritesLoading());
    final result = await _favoritesRepo.getFavorites();
    result.when(
      success: (data) => emit(FavoritesLoaded(data)),
      failure: (error) => emit(FavoritesError(error.message ?? 'Unknown error occurred')),
    );
  }

  Future<void> removeFavorite(String listingId) async {
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

      // Optimistically update the UI to feel premium and fast
      emit(FavoritesLoaded(updatedResponses));

      final result = await _favoritesRepo.removeFavorite(listingId);
      result.when(
        success: (_) {
          // Keep the updated list
        },
        failure: (error) {
          // Revert back on error by fetching again
          getFavorites();
        },
      );
    }
  }

  Future<void> addFavorite(String listingId) async {
    final result = await _favoritesRepo.addFavorite(listingId);
    result.when(
      success: (_) {
        // If we are currently on the screen, reload the list to get full details of the added listing
        getFavorites();
      },
      failure: (error) {
        // Handle failure if needed
      },
    );
  }
}
