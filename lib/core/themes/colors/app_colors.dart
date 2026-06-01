import 'package:flutter/material.dart';

class AppColors {
  // Basic Colors
  static const Color transparentColor = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Primary Teal/Cyan Colors - Based on Design System
  // Light Shades
  static const Color light = Color(0xFFE8F5F6); // #e8f5f6 - rgb(232, 245, 248)
  static const Color lightHover = Color(
    0xFFDCF0F4,
  ); // #dcf0f4 - rgb(220, 240, 244)
  static const Color lightActive = Color(
    0xFFB7E0E8,
  ); // #b7e0e8 - rgb(183, 224, 232)

  // Normal/Primary Shades
  static const Color primary = Color(
    0xFF189AB4,
  ); // #189ab4 - rgb(24, 154, 180) - Main Primary Color
  static const Color primaryHover = Color(
    0xFF168BA2,
  ); // #168ba2 - rgb(22, 139, 162)
  static const Color primaryActive = Color(
    0xFF137B90,
  ); // #137b90 - rgb(19, 123, 144)

  // Dark Shades
  static const Color dark = Color(0xFF127487); // #127487 - rgb(18, 116, 135)
  static const Color darkHover = Color(
    0xFF0E5C6C,
  ); // #0e5c6c - rgb(14, 92, 108)
  static const Color darkActive = Color(
    0xFF0B4551,
  ); // #0b4551 - rgb(11, 69, 81)

  // Darker Shade
  static const Color darker = Color(0xFF083638); // #083638 - rgb(8, 54, 63)

  // Aliases for backward compatibility
  static const Color greenPrimary = primary;
  static const Color greenNormalActive = primaryActive;
  static const Color greenDarker = darker;
  static const Color select = Color(0x40189AB4); // 25% opacity primary

  // Background Colors
  static const Color bgPrimary = Color(0xFFF8FAFC);
  static const Color softWhite = Color(0xFFF8FAFC);
  static const Color bgDisabled = Color(0xFFEDF2FA);

  // Gray Scale
  static const Color gray = Color(0xFF6D7688);
  static const Color lightGray = Color(0xFFD0D5D6);
  static const Color greyDarker = Color(0xFF2E353E);
  static const Color darkGrey = Color(0xFF2E353E);
  static const Color primaryGrey = Color(0xFF6D7688);
  static const Color secondaryGrey = Color(0xFF697D95);
  static const Color disabledText = Color(0xFFDAE1EE);

  // Text Colors
  static const Color primaryText = Color(0xFF313131);
  static const Color secondaryText = Color(0xFF6B7280);
  static const Color headingText = Color(0xFF2F3E4E);
  static const Color placeholder = Color(0xFFBFBFBF);
  static const Color body = Color(0xFF737373);
  static const Color hintText = Color(0xFF234731);

  // Border Colors
  static const Color borderInputs = Color(0xFFE5E7EB);
  static const Color borderFocus = primary;
  static const Color borderCards = Color(0xFFF1F5F9);
  static const Color borderSuccess = Color(0xFF15803D);

  // Status Colors
  static const Color errorRed = Color(0xFFDC2626);
  static const Color bgError = Color(0xFFFEF2F2);
  static const Color bgHint = Color(0xFF84E0A6);

  // Warning Colors
  static const Color yellow = Color(0xFFFEBB38);
  static const Color primaryYellow = Color(0xFFFEBB38);
  static const Color warningText = Color(0xFFD97706);
  static const Color bgWarning = Color(0xFFFFFBEB);
  static const Color warningRed = Color(0xFFD3503C);
  static const Color warningDark = Color(0xFF512C1B);

  // Icon Colors
  static const Color secondary = Color(0xFF1E275C);
  static const Color iconPrimary = Color(0xFF030E51);
  static const Color primaryBlack = Color(0xFF1A1A1A);
}
