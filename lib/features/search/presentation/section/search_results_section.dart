import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/features/search/domain/entities/search_result_entity.dart';
import 'package:home_service_app/features/search/presentation/widgets/search_result_item.dart';

class SearchResultsSection extends StatelessWidget {
  const SearchResultsSection({
    super.key,
    required this.results,
    this.onResultTap,
  });

  final List<SearchResultEntity> results;
  final ValueChanged<SearchResultEntity>? onResultTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(AppSizes.padding),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];

        return SearchResultItem(
          title: result.title,
          onTap: () => onResultTap?.call(result),
        );
      },
    );
  }
}
