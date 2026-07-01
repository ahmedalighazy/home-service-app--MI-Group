class AuthConstants {
  AuthConstants._();

  static const int otpCodeLength = 6;

  static const int otpTimerSeconds = 600;

  static const int shakeAnimationDuration = 600;

  static const int splashAnimationDuration = 500;

  static const int tokenExpiryBufferSeconds = 60;

  static const int autoLoginDelay = 500;

  static const double shakeOffset = 8.0;

  static const double splashBgOpacity = 0.25;

  static const double cardSelectionOpacity = 0.08;

  static const int designWidth = 375;

  static const int designHeight = 812;

  static const double screenHorizontalPadding = 24.0;

  static const double formFieldSpacing = 16.0;

  static const double bottomSheetHandleWidth = 60.0;

  static const double bottomSheetHandleHeight = 5.0;

  static const double standardBorderRadius = 12.0;

  static const double largeBorderRadius = 44.0;

  static const double countryCodeDividerWidth = 1.0;

  static const double headingXLFontSize = 24.0;

  static const double headingLFontSize = 18.0;

  static const double headingMFontSize = 16.0;

  static const double bodyFontSize = 15.0;

  static const double captionFontSize = 14.0;

  static const double smallFontSize = 13.0;

  static const double xSmallFontSize = 12.0;

  static const double tinyFontSize = 10.0;

  static const double spacingXS = 4.0;

  static const double spacingS = 8.0;

  static const double spacingM = 12.0;

  static const double spacingL = 16.0;

  static const double spacingXL = 20.0;

  static const double spacing2XL = 24.0;

  static const double spacing3XL = 32.0;

  static const double spacingXXL = 40.0;

  static const double spacingMax = 60.0;

  static const double buttonHeight = 50.0;

  static const double buttonMinWidth = double.infinity;

  static const double buttonIconSize = 28.0;

  static const double textFieldHorizontalPadding = 16.0;

  static const double textFieldVerticalPadding = 12.0;

  static const double textFieldBorderWidth = 1.0;

  static const double countryCodeFieldHeight = 30.0;

  static const int minPasswordLength = 6;

  static const int maxPasswordLength = 128;

  static const int minNameLength = 2;

  static const int maxNameLength = 50;

  static const String qatarCountryCode = '+974';

  static const String qatarFlagEmoji = '🇶🇦';

  static const String qatarPhonePlaceholder = '5123 4567';

  static const int connectionTimeout = 30;

  static const int readTimeout = 30;

  static const int writeTimeout = 30;

  static const int maxRetryAttempts = 3;

  static const int retryDelayMs = 1000;

  static const double percent100 = 1.0;

  static const double percent50 = 0.5;

  static const double percent25 = 0.25;

  static const double percent20 = 0.2;

  static const double percent10 = 0.1;

  static const int maxShakeIterations = 5;

  static const int animationTweenWeight = 1;

  static const int animationTweenWeightHigh = 2;

  static const double splashBgHeightRatio = 0.5;

  static const double noElevation = 0.0;

  static const double standardElevation = 2.0;

  static const double itemHorizontalSpacing = 13.0;
}

class AuthSizes {
  static const double radius = 12.0;
  static const double radiusLarge = 44.0;
}

class AuthDurations {
  static const Duration shake = Duration(milliseconds: 600);
  static const Duration splash = Duration(milliseconds: 500);
  static const Duration autoLogin = Duration(milliseconds: 500);
}

class AuthPaddingValues {
  static const double screenHorizontal = 24.0;
  static const double formField = 16.0;
  static const double countryCodeHorizontal = 12.0;
  static const double listItemHorizontal = 13.0;
}
