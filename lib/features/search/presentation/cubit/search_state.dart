import 'package:equatable/equatable.dart';
import 'package:home_service_app/features/home/domain/entities/category_entity.dart';
import 'package:home_service_app/features/search/domain/entities/search_result_entity.dart';
import 'package:home_service_app/features/search/domain/entities/search_suggestion_entity.dart';

class SearchState extends Equatable {
  final String query;

  final List<String> recentSearches;

  final List<SearchResultEntity> results;

  final List<CategoryEntity> categories;

  final List<SearchSuggestionEntity> suggestions;

  final List<String> popularSearches;

  const SearchState({
    this.query = '',
    this.results = const [],
    this.categories = const [],
    this.suggestions = const [],
    this.popularSearches = const [],
    this.recentSearches = const [],
  });

  SearchState copyWith({
    String? query,
    List<SearchResultEntity>? results,
    List<CategoryEntity>? categories,
    List<SearchSuggestionEntity>? suggestions,
    List<String>? popularSearches,
    List<String>? recentSearches,
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      categories: categories ?? this.categories,
      suggestions: suggestions ?? this.suggestions,
      popularSearches: popularSearches ?? this.popularSearches,
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }

  @override
  List<Object?> get props => [
    query,
    results,
    recentSearches,
    categories,
    suggestions,
    popularSearches,
  ];
}
