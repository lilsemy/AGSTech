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

/// Defines the design rules and pre-configured themes for the app
class AppTheme {
  /// Base builder that creates a ThemeData instance with all fine-grained styling
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

      // Color scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
        tertiary: accentColor,
        surface: backgroundColor,
        onPrimary: AppColors.white,
        onSurface: textColor,
        error: AppColors.burgundy,
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),

      // Typography
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: textColor),
        bodyMedium: TextStyle(fontSize: 14, color: textColor),
      ),

      // Elevated Buttons (with rounded corners & custom padding)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // Outlined Buttons
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // Input Fields (TextFormFields, etc.)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }

  // --- Predefined Theme Configurations ---

  /// General areas (Login, Onboarding, etc.)
  static final ThemeData general = build(
    primaryColor: AppColors.navy,
    accentColor: AppColors.sand,
    backgroundColor: AppColors.white,
    textColor: AppColors.anthracite,
  );

  /// Customer-specific view theme
  static final ThemeData customer = build(
    primaryColor: AppColors.navy,
    accentColor: AppColors.burgundy,
    backgroundColor: AppColors.cream,
    textColor: AppColors.anthracite,
  );

  /// Employee-specific view theme
  static final ThemeData employee = build(
    primaryColor: AppColors.navy,
    accentColor: AppColors.sageDark,
    backgroundColor: AppColors.offWhite,
    textColor: AppColors.anthracite,
  );
}
