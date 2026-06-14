import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dummy/search_dummy_data.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(_buildInitialState());

  static SearchState _buildInitialState() {
    return SearchState(
      recentSearches: SearchDummyData.recentSearches,
      categories: SearchDummyData.categories,
      suggestions: SearchDummyData.suggestions,
      popularSearches: SearchDummyData.popularSearches,
    );
  }

  void addRecentSearch(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) return;

    final updatedSearches = [
      trimmedValue,
      ...state.recentSearches.where((item) => item != trimmedValue),
    ].take(10).toList();

    emit(state.copyWith(recentSearches: updatedSearches));
  }

  void clearRecentSearches() {
    emit(state.copyWith(recentSearches: []));
  }

  void search(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    final filteredResults = SearchDummyData.results
        .where((item) => item.title.toLowerCase().contains(normalizedQuery))
        .toList();

    emit(state.copyWith(query: query, results: filteredResults));
  }

  void clearSearch() {
    emit(state.copyWith(query: '', results: []));
  }
}
