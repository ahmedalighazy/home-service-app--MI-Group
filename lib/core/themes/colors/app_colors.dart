import 'package:flutter/material.dart';

class AppColors {
  // colors ui profile
  static const Color transparentColor = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color black100 = Color(0x0A000000);

  // UI Specific Colors
  static const Color backgroundGrey = Color(0xFFF9FAFB);
  static const Color borderGrey = Color(0xFFE5E7EB);
  static const Color textDarkGrey = Color(0xFF374151);
  static const Color textLightGrey = Color(0xFF6B7280);
  static const Color inputBg = Color(0xFFF3F4F6);

  // Danger / Delete Colors
  static const Color redDanger = Color(0xFFDC2626);
  static const Color red = Color(0xFFD2503C);

  static const Color redDangerBg = Color(0xFFFEF2F2);
  static const Color redBorder = Color(0xFFFCA5A5);

  // Teal / Button Colors
  static const Color tealPrimary = Color(0xFF0F766E);

  static const Color dark300 = Color(0xFFEEF2F6); // Main dark teal
  // Brand Colors (Teal / Cyan family)

  // Theme Main Colors (Teal)
  static const Color dark = Color(0xFF0A434E); // Main dark teal
  static const Color darkHover = Color(0xFF0E5C6C);
  static const Color darkHover2 = Color(0xFFF2F2F2);

  static const Color darkActive = Color(0xFF0B4551);
  static const Color greenDarker = Color(0xFF08363F);
  static const Color greenPrimary = Color(0xFF189AB4); // Main green/cyan
  static const Color greenNormalActive = Color(0xFF137B90);
  static const Color select = Color(
    0x40189AB4,
  ); // 25% opacity greenPrimary (fixed from 0xFF189AB440)

  // Light shades
  static const Color light = Color(0xFFE8F5F8);
  static const Color lightHover = Color(0xFFDCF0F4);
  static const Color lightActive = Color(0xFFB7E0E8);

  // Primary Teal/Cyan Colors - Based on Design System

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

  // Darker Shade
  static const Color darker = Color(0xFF083638); // #083638 - rgb(8, 54, 63)
  static const Color whitecancel = Color(
    0xFFD9E1EE,
  ); // #083638 - rgb(8, 54, 63)
  static const Color dividerGrey = Color(
    0xFFF3F4F6,
  ); // Using inputBg color as divider

  // Aliases for backward compatibility

  // Background Colors
  static const Color bgPrimary = Color(0xFFF8FAFC);
  static const Color softWhite = Color(0xFFF8FAFC); // Alias for theme support
  static const Color grayWhite = Color(0xFFF2F2F2); // Alias for theme support

  // Grays
  static const Color gray = Color(0xFF6D7688);
  static const Color lightGray = Color(
    0xFFD0D5D6,
  ); // Fixed from 0xFFD0D5D62E (invisible due to 18% opacity / invalid 10-digit)
  static const Color greyDarker = Color(0xFF2E353E);
  static const Color darkGrey = Color(0xFF2E353E); // Alias for theme support
  static const Color primaryGrey = Color(0xFF6D7688); // Alias for theme support
  static const Color secondaryGrey = Color(
    0xFF6D7688,
  ); // Alias for theme support
  static const Color bgDisabled = Color(0xFF697D95);
  static const Color disabledText = Color(0xFFDAE1EE);

  // Text Colors
  static const Color primaryText = Color(0xFF313131);
  static const Color secondaryText = Color(0xFF6B7280);
  static const Color headingText = Color(0xFF2F3E4E);
  static const Color placeholder = Color(0xFFBFBFBF);
  static const Color body = Color(0xFF737373);
  static const Color hintText = Color(0xFF234731);

  // Borders
  static const Color borderInputs = Color(0xFFE5E7EB);
  static const Color borderInput = Color(0xFFE5E7EB);

  static const Color borderFocus = primary;
  static const Color borderCards = Color(0xFFF1F5F9);
  static const Color borderSuccess = Color(0xFF15803D);

  // Status & Actions
  static const Color errorRed = Color(0xFFDC2626);
  static const Color errorRed2 = Color(0xAAFBF3F3);

  static const Color bgError = Color(0xFFFEF2F2);

  // Warnings (Spelling and format fixed)
  static const Color yellow = Color(0xFFFEBB38);
  static const Color primaryYellow = Color(
    0xFFFEBB38,
  ); // Alias for theme support
  static const Color warningText = Color(0xFFD97706);
  static const Color bgWarning = Color(0xFFFFFBEB);
  static const Color warningRed = Color(0xFFD3503C); // Fixed from bgWaring2
  static const Color warningDark = Color(
    0xFF512C1B,
  ); // Fixed from bgWaring 10-digit (was 0xFF512C1BF0)

  // Custom Alerts
  static const Color bgHint = Color(0xFF84E0A6);

  // UI Icon Colors
  static const Color secondary = Color(0xFF1E275C);
  static const Color iconPrimary = Color(0xFF030E51);
  static const Color primaryBlack = Color(0xFF1A1A1A);

  // UI Specific Badges/Buttons
  static const Color badgeBlue = Color(0xFF4DA3BF);
  static const Color lightIndigo = Color(0xFFEDF1FA);
}
