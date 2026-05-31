import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.white,
      splashColor: AppColors.primaryBlack,
      cardColor: AppColors.primaryYellow,
      canvasColor: AppColors.white,
      disabledColor: AppColors.darkGrey,
      focusColor: AppColors.primaryGrey,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.primaryYellow),
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryYellow,
        backgroundColor: AppColors.softWhite,
        unselectedItemColor: AppColors.darkGrey,
      ));

  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryBlack,
      splashColor: AppColors.white,
      cardColor: AppColors.primaryYellow,
      canvasColor: AppColors.darkGrey,
      disabledColor: AppColors.darkGrey,
      focusColor: AppColors.darkGrey,
      scaffoldBackgroundColor: AppColors.primaryBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryBlack,
        iconTheme: IconThemeData(color: AppColors.primaryYellow),
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryYellow,
        backgroundColor: AppColors.darkGrey,
        unselectedItemColor: AppColors.white,
      ));
}
