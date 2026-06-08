import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:home_service_app/features/search/presentation/cubit/search_state.dart';
import 'package:home_service_app/features/search/presentation/section/popular_searches_section.dart';
import 'package:home_service_app/features/search/presentation/section/recent_searches_section.dart';
import 'package:home_service_app/features/search/presentation/section/search_categories_section.dart';
import 'package:home_service_app/features/search/presentation/section/search_empty_state.dart';
import 'package:home_service_app/features/search/presentation/section/search_maybe_looking_for_section.dart';
import 'package:home_service_app/features/search/presentation/section/search_results_section.dart';
import 'package:home_service_app/features/search/presentation/widgets/search_app_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchAppBar(
              controller: _searchController,
              onChanged: (value) {
                context.read<SearchCubit>().search(value);
              },
            ),

            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  final query = state.query;

                  // Empty Search
                  if (query.isEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          RecentSearchesSection(
                            recentSearches: state.recentSearches,
                            onClearAll: () {
                              context.read<SearchCubit>().clearRecentSearches();
                            },
                          ),

                          PopularSearchesSection(
                            searches: state.popularSearches,
                          ),

                          SearchMaybeLookingForSection(
                            items: state.suggestions,
                          ),
                        ],
                      ),
                    );
                  }

                  // No Results
                  if (state.results.isEmpty) {
                    return SearchEmptyState(searchInputText: '"$query"');
                  }

                  // Results
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SearchResultsSection(
                          results: state.results,
                          onResultTap: (result) {
                            context.read<SearchCubit>().addRecentSearch(
                              result.title,
                            );
                          },
                        ),

                        SearchCategoriesSection(categories: state.categories),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
