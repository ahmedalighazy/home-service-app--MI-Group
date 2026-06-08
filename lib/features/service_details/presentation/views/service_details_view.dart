import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/presentation/views/service_page_view.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../data/service_mock_data.dart';


class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = ServiceMockData.pages;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          itemBuilder: (context, index) => ServicePage(
            data: pages[index],
            pageController: _pageController,
            pageCount: pages.length,
          ),
        ),
      ),
    );
  }
}

