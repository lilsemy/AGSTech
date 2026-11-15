import 'package:flutter/material.dart';

/// Definitions of all custom color values used throughout the application
class AppColors {
  // Shared brand colors
  static const Color navy = Color(0xFF354B65);
  static const Color anthracite = Color(0xFF292E36);
  static const Color white = Color(0xFFFFFFFF);

  // Customer colors
  static const Color cream = Color(0xFFF3F0E9);
  static const Color sand = Color(0xFFD9C8B5);

  // Employee colors
  static const Color sage = Color(0xFF718C7A);
  static const Color sageDark = Color(0xFF526C5A);
  static const Color lightSage = Color(0xFFEAF0EB);
  static const Color offWhite = Color(0xFFF3F5F6);

  // Special accents
  static const Color burgundy = Color(0xFFA64D5D);
  static const Color copper = Color(0xFFA77D65);

  // Additional neutral colors
  static const Color grey = Color(0xFF747B83);
  static const Color lightGrey = Color(0xFFE4E7EB);
}

/// Helper class to build consistent Themedata instances
class AppThemeBuilder {
  static ThemeData build({
    required Color backgroundColor,
    required Color accentColor,
    required Color primaryColor,
    required Color textColor,
  }) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
        surface: backgroundColor,
        onSurface: textColor,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

/// Defines the design for General Areas (e.g., Login, Onboarding)
class AppThemes {
  static final ThemeData general = AppThemeBuilder.build(
    primaryColor: AppColors.navy,
    accentColor: AppColors.sand,
    backgroundColor: Colors.white, // Clean white or light neutral for login
    textColor: AppColors.anthracite,
  );

  /// Defines the design specific to customer view
  static final ThemeData customer = AppThemeBuilder.build(
    primaryColor: AppColors.navy,
    accentColor: AppColors.burgundy,
    backgroundColor: AppColors.cream,
    textColor: AppColors.anthracite,
  );

  /// Defines the design specific to employee view
  static final ThemeData employee = AppThemeBuilder.build(
    primaryColor: AppColors.navy,
    accentColor: AppColors.sageDark,
    backgroundColor: AppColors.offWhite,
    textColor: AppColors.anthracite,
  );
}
