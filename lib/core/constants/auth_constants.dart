
class AuthConstants {
  AuthConstants._(); // Private constructor to prevent instantiation

  // ============================================================================
  // Timings (مدة زمنية)
  // ============================================================================

  /// OTP code length - 6 digits
  static const int otpCodeLength = 6;

  /// OTP timer total seconds - 59 seconds for countdown
  static const int otpTimerSeconds = 59;

  /// Shake animation duration in milliseconds
  static const int shakeAnimationDuration = 600;

  /// Splash screen animation duration in milliseconds
  static const int splashAnimationDuration = 500;

  /// Token expiry buffer - refresh token before 60 seconds of expiry
  static const int tokenExpiryBufferSeconds = 60;

  /// Remember Me auto-login delay in milliseconds
  static const int autoLoginDelay = 500;

  // ============================================================================
  // Animation Values (قيم الحركة)
  // ============================================================================

  /// Shake offset for OTP error animation - 8 pixels
  static const double shakeOffset = 8.0;

  /// Opacity value for splash screen background - 25%
  static const double splashBgOpacity = 0.25;

  /// Opacity value for address card selection - 8%
  static const double cardSelectionOpacity = 0.08;

  // ============================================================================
  // Layout Dimensions (أبعاد التخطيط)
  // ============================================================================

  /// Design size width for ScreenUtil
  static const int designWidth = 375;

  /// Design size height for ScreenUtil
  static const int designHeight = 812;

  /// Horizontal padding for screens
  static const double screenHorizontalPadding = 24.0;

  /// Vertical spacing between form fields
  static const double formFieldSpacing = 16.0;

  /// Bottom sheet handle width
  static const double bottomSheetHandleWidth = 60.0;

  /// Bottom sheet handle height
  static const double bottomSheetHandleHeight = 5.0;

  /// Standard border radius for components
  static const double standardBorderRadius = 12.0;

  /// Large border radius for badges
  static const double largeBorderRadius = 44.0;

  /// Country code divider width
  static const double countryCodeDividerWidth = 1.0;

  // ============================================================================
  // Typography (مقاييس الخطوط)
  // ============================================================================

  /// Extra large heading - for splash screen
  static const double headingXLFontSize = 24.0;

  /// Large heading font size
  static const double headingLFontSize = 18.0;

  /// Medium heading font size
  static const double headingMFontSize = 16.0;

  /// Body text font size
  static const double bodyFontSize = 15.0;

  /// Caption font size
  static const double captionFontSize = 14.0;

  /// Small text font size
  static const double smallFontSize = 13.0;

  /// Extra small text font size
  static const double xSmallFontSize = 12.0;

  /// Tiny text font size
  static const double tinyFontSize = 10.0;

  // ============================================================================
  // Spacing Values (قيم المسافات)
  // ============================================================================

  /// Extra small spacing
  static const double spacingXS = 4.0;

  /// Small spacing
  static const double spacingS = 8.0;

  /// Medium spacing
  static const double spacingM = 12.0;

  /// Large spacing
  static const double spacingL = 16.0;

  /// Extra large spacing
  static const double spacingXL = 20.0;

  /// 2X large spacing
  static const double spacing2XL = 24.0;

  /// 3X large spacing
  static const double spacing3XL = 32.0;

  /// Extra extra large spacing
  static const double spacingXXL = 40.0;

  /// Maximum spacing
  static const double spacingMax = 60.0;

  // ============================================================================
  // Button Dimensions (أبعاد الأزرار)
  // ============================================================================

  /// Standard button height
  static const double buttonHeight = 50.0;

  /// Standard button minimum width
  static const double buttonMinWidth = double.infinity;

  /// Icon size in buttons
  static const double buttonIconSize = 28.0;

  // ============================================================================
  // Form Field Dimensions (أبعاد حقول النماذج)
  // ============================================================================

  /// Horizontal padding inside text fields
  static const double textFieldHorizontalPadding = 16.0;

  /// Vertical padding inside text fields
  static const double textFieldVerticalPadding = 12.0;

  /// Text field border width
  static const double textFieldBorderWidth = 1.0;

  // ============================================================================
  // Text Field Heights (ارتفاعات حقول النص)
  // ============================================================================

  /// Country code field height (for phone input)
  static const double countryCodeFieldHeight = 30.0;

  // ============================================================================
  // Input Validation (قواعد التحقق من الإدخال)
  // ============================================================================

  /// Minimum password length
  static const int minPasswordLength = 6;

  /// Maximum password length
  static const int maxPasswordLength = 128;

  /// Minimum name length
  static const int minNameLength = 2;

  /// Maximum name length
  static const int maxNameLength = 50;

  // ============================================================================
  // Country & Phone (الدولة والهاتف)
  // ============================================================================

  /// Qatar country code
  static const String qatarCountryCode = '+974';

  /// Qatar flag emoji
  static const String qatarFlagEmoji = '🇶🇦';

  /// Qatar default phone placeholder
  static const String qatarPhonePlaceholder = '5123 4567';

  // ============================================================================
  // HTTP & Network (الشبكة والاتصال)
  // ============================================================================

  /// Connection timeout in seconds
  static const int connectionTimeout = 30;

  /// Read timeout in seconds
  static const int readTimeout = 30;

  /// Write timeout in seconds
  static const int writeTimeout = 30;

  // ============================================================================
  // Retry Policy (سياسة المحاولة مرة أخرى)
  // ============================================================================

  /// Maximum number of retry attempts
  static const int maxRetryAttempts = 3;

  /// Retry delay in milliseconds
  static const int retryDelayMs = 1000;

  // ============================================================================
  // Percentage Values (القيم المئوية)
  // ============================================================================

  /// 100% value (for animations/opacity)
  static const double percent100 = 1.0;

  /// 50% value
  static const double percent50 = 0.5;

  /// 25% value
  static const double percent25 = 0.25;

  /// 20% value
  static const double percent20 = 0.2;

  /// 10% value
  static const double percent10 = 0.1;

  // ============================================================================
  // Threshold Values (قيم الحدود)
  // ============================================================================

  /// Maximum shake offset iterations (for OTP shake animation)
  static const int maxShakeIterations = 5;

  /// Weight for animation tween sequence
  static const int animationTweenWeight = 1;

  /// Higher weight for animation tween sequence
  static const int animationTweenWeightHigh = 2;

  // ============================================================================
  // Screen Heights (ارتفاعات الشاشة)
  // ============================================================================

  /// Splash screen background height ratio (50% of screen)
  static const double splashBgHeightRatio = 0.5;

  // ============================================================================
  // Elevation & Shadow (الارتفاع والظل)
  // ============================================================================

  /// No elevation/shadow
  static const double noElevation = 0.0;

  /// Standard elevation for cards
  static const double standardElevation = 2.0;

  // ============================================================================
  // Grid & List (الشبكة والقوائم)
  // ============================================================================

  /// Horizontal spacing in grid/list items
  static const double itemHorizontalSpacing = 13.0;
}

// ============================================================================
// Helper Classes (فئات مساعدة)
// ============================================================================

/// Size class for screen dimensions
class AuthSizes {
  static const double radius = 12.0;
  static const double radiusLarge = 44.0;
}

/// Duration class for animations
class AuthDurations {
  static const Duration shake = Duration(milliseconds: 600);
  static const Duration splash = Duration(milliseconds: 500);
  static const Duration autoLogin = Duration(milliseconds: 500);
}

/// Padding values (use with EdgeInsets.symmetric or EdgeInsets.all)
class AuthPaddingValues {
  static const double screenHorizontal = 24.0;
  static const double formField = 16.0;
  static const double countryCodeHorizontal = 12.0;
  static const double listItemHorizontal = 13.0;
}
