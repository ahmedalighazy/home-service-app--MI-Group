import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/features/search/presentation/widgets/search_result_item.dart';

class SearchResultsSection extends StatelessWidget {
  const SearchResultsSection({super.key, required this.results});

  final List<String> results;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(AppSizes.padding),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return SearchResultItem(title: results[index], onTap: () {});
      },
    );
  }
}
