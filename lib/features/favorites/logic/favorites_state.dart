import 'package:home_service_app/features/favorites/data/models/favorite_responses.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final FavoriteResponses favoriteResponses;
  FavoritesLoaded(this.favoriteResponses);
}

final class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}
