import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AppSizes - Responsive sizes using flutter_screenutil
/// All values are responsive and adapt to different screen sizes
class AppSizes {
  // Private constructor to prevent instantiation
  AppSizes._();

  // ============ Avatar Sizes ============
  static double get avatarSize => 48.w;

  // ============ Border Radius ============
  static double get radiusSmall => 8.r;
  static double get radiusMedium => 12.r;
  static double get radius => 16.r;
  static double get radiusLarge => 24.r;
  static double get radiusXLarge => 30.r;

  // ============ Padding ============
  static double get paddinMinHeight => 4.h;
  static double get paddinMinWidth => 4.w;
  static double get paddingSmall => 8.w;
  static double get paddingSmallHeight => 8.w;
  static double get paddingMedium => 12.w;
  static double get padding => 16.w;
  static double get paddingHeight => 16.h;
  static double get paddingLarge => 24.w;
  static double get paddingXLarge => 32.w;
  static double get paddingXLargeHeight => 32.h;
  static double get paddingXXLarge => 60.w;

  // ============ Spacing ============
  static double get spacingMin => 4.h;
  static double get spacingSmall => 8.h;
  static double get spacingSmallWidth => 8.w;
  static double get spacingMedium => 12.h;
  static double get spacing => 16.h;
  static double get spacingLarge => 20.h;
  static double get spacingXLarge => 30.h;
  static double get spacingXXLarge => 40.h;

  // ============ Icon Sizes ============
  static double get iconSizeSmall => 14.w;
  static double get iconSizeMedium => 20.w;
  static double get iconSize => 24.w;
  static double get iconSizeLarge => 28.w;
  static double get iconSizeXLarge => 48.w;

  // ============ Specific Component Sizes ============
  static double get notificationBellSize => 48.w;
  static double get dialogWidth => 450.w;
  static double get searchIConWidth => 200.w;
  static double get searchIConHeight => 265.w;

  // ============ Home Screen Specific ============
  static double get homeHeaderHeight => 180.h;

  static const double sectionOffset = 60;

  static double get pageIndicatorWidth => 8.w;

  static double get cardWidth => 130.w;
  static double get cardImageHeight => 90.h;
  static double get addressTypeSelectorWidth => 90.w;

  static double get arrowIconHeight => 32.h;
  static double get arrowIconWidth => 32.w;

  static const double categoryCardWidth = 100;
  static const double categoryIconContainerSize = 90;
  static const double searchCategoriesIconHight = 110;
  static const double categoryIconContainerSizeHeight = 74;

  static double get bannerCardHeight => 165.h;
  static double get homeToBoxAdapterHeight => 24.h;

  // ============ Button Sizes ============
  static double get buttonHeight => 48.h;
  static double get buttonHeightSmall => 36.h;
  static double get buttonHeightLarge => 56.h;

  // ============ Card Sizes ============
  static double get cardElevation => 2;
  static double get cardPadding => 16.w;

  // ============ Divider ============
  static double get dividerThickness => 1;
  static double get dividerHeight => 1.h;

  // ============ App Bar ============
  static double get appBarHeight => 56.h;
  static double get appBarElevation => 0;

  // ============ Bottom Nav Bar ============
  static double get bottomNavBarHeight => 65.h;
  static double get bottomNavBarIconSize => 24.w;
}
