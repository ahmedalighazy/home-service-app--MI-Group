import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/search/presentation/cubit/search_cubit.dart';

mixin SearchLogic<T extends StatefulWidget> on State<T> {
  late final TextEditingController searchController;

  void initSearchController() {
    searchController = TextEditingController();
  }

  void onSearchChanged(BuildContext context, String value) {
    context.read<SearchCubit>().search(value);
  }

  void onClearRecentSearches(BuildContext context) {
    context.read<SearchCubit>().clearRecentSearches();
  }

  void onResultTap(BuildContext context, String title) {
    context.read<SearchCubit>().addRecentSearch(title);
  }

  void onClearSearch(BuildContext context) {
    searchController.clear();
    context.read<SearchCubit>().clearSearch();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
