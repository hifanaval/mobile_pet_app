import 'package:flutter/material.dart';

class AppColors {
  // Primary Theme Colors
  static const Color primaryLight = Color(0xFF5C60F5); // Main app color
  static const Color primaryDark = Color(0xFF3F51B5); // Dark mode primary

  // Background Colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF121212);

  // Surface Colors
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color transparent = Colors.transparent;

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF262626);
  static const Color textSecondaryLight = Color(0xFF5C5E5D);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // Icon Colors
  static const Color iconLight = Color(0xFF070707);
  static const Color iconDark = Color(0xFFB0B0B0);

  // Gender Icons
  static const Color maleIconColor = Color(0xFF2196F3); // Blue
  static const Color femaleIconColor = Color(0xFFFF4081); // Pink

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
  static const Color blue = Color(0xff494FDD);

  //border colors
  static const Color borderColor = Color(0xffE8E8E8);
  static const Color containerBorder = Color(0xffEBECEF);

  //container color
  static const Color pinkLight = Color(0xffFFECF4);
  static const Color blueLight = Color(0xffECF5FF);
  static const Color lightGrey = Color(0xffECECEC);
  static const Color lightBg = Color(0xffF9FAFB);

  // Input Field Colors
  static const Color inputBackgroundLight = Colors.white;
  static const Color inputBackgroundDark = Color(0xFF2A2A2A);
  static const Color inputBorderLight = Color(0xFFE0E0E0);
  static const Color inputBorderDark = Color(0xFF424242);

  // Custom Colors for Pet App
  static const Color addPetButtonLight =
      Color(0xFFFFD600); // Yellow button color
  static const Color addPetButtonDark = Color(0xFFFFB300);
  static const Color favoriteActive =
      Color(0xFFE91E63); // Heart icon when active
  static const Color favoriteInactive =
      Color(0xFFBDBDBD); // Heart icon when inactive

  // Helper method to get theme-based colors
  static Color getThemeColor(
      BuildContext context, Color lightColor, Color darkColor) {
    return Theme.of(context).brightness == Brightness.light
        ? lightColor
        : darkColor;
  }

  // Theme Data
  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryLight,
      scaffoldBackgroundColor: backgroundLight,
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryDark,
      scaffoldBackgroundColor: backgroundDark,
    );
  }
}
