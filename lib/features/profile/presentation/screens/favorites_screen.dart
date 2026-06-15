import 'package:flutter/material.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/utils/l10n/app_strings.dart';
import '../widgets/favorites_list_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(title: AppStrings.favorites),
      body: const SafeArea(
        child: FavoritesListWidget(),
      ),
    );
  }
}
