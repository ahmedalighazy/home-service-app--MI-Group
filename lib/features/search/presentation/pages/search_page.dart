import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/home/domain/entities/category_entity.dart';
import 'package:home_service_app/features/search/domain/entities/search_suggestion_entity.dart';
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
            SearchAppBar(controller: _searchController, onChanged: (_) {}),

            Expanded(
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _searchController,
                builder: (context, value, _) {
                  final query = value.text.trim();

                  // Empty Search
                  if (query.isEmpty) {
                    return const SingleChildScrollView(
                      child: Column(
                        children: [
                          RecentSearchesSection(),
                          PopularSearchesSection(
                            searches: [
                              'تنظيف منزل',
                              'تنظيف أثاث',
                              'تنظيف بعد التشطيب',
                              'مكافحة حشرات',
                            ],
                          ),
                          SearchMaybeLookingForSection(
                            items: [
                              SearchSuggestionEntity(
                                title: AppStrings.insectsInHouse,
                                description: AppStrings.insectsInHouseDis,
                                imagePath: AppAssets.insectsInHouse,
                              ),
                              SearchSuggestionEntity(
                                title: AppStrings.insectsInHouse,
                                description: AppStrings.insectsInHouseDis,
                                imagePath: AppAssets.insectsInHouse,
                              ),
                              SearchSuggestionEntity(
                                title: AppStrings.insectsInHouse,
                                description: AppStrings.insectsInHouseDis,
                                imagePath: AppAssets.insectsInHouse,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  final results = [
                    'تنظيف منزل',
                    'تنظيف أثاث',
                    'تنظيف بعد التشطيب',
                    'مكافحة حشرات',
                  ].where((item) => item.contains(query)).toList();

                  // No Results
                  if (results.isEmpty) {
                    return SearchEmptyState(searchInputText: '"$query"');
                  }

                  // Results + Categories
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SearchResultsSection(results: results),

                        SearchCategoriesSection(
                          categories: const [
                            CategoryEntity(
                              title: 'تنظيف مطابخ',
                              iconPath: IconsPath.cleanerIcon,
                            ),
                            CategoryEntity(
                              title: 'تنظيف عادي',
                              iconPath: IconsPath.manualCleanerIcon,
                            ),
                            CategoryEntity(
                              title: 'تنظيف سجاد',
                              iconPath: IconsPath.bugIcon,
                            ),
                            CategoryEntity(
                              title: 'تنظيف كتب',
                              iconPath: IconsPath.institutionsIcon,
                            ),
                          ],
                        ),
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
