import 'package:flutter/material.dart';
import 'package:home_service_app/core/utils/helpers/cache_helper.dart';

class OnboardingCubit extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void nextPage(VoidCallback onFinish) {
    if (_currentPage < 2) {
      _currentPage++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else {
      onFinish();
    }
  }

  void skipToEnd() {
    // Navigation will be handled by the screen
  }

  void finishOnboarding() {
    CacheHelper.saveData(key: 'onBoarding', value: true);
  }

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
