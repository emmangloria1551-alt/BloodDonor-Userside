import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';

final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.dark);

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: Colors.white,
      error: AppColors.critical,
      onPrimary: Colors.white,
      onSurface: const Color(0xFF2B2022),
    );

    final textTheme = ThemeData.light().textTheme.copyWith(
      displaySmall: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        height: 1.15,
        letterSpacing: -0.5,
      ),
      headlineSmall: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        height: 1.2,
        letterSpacing: -0.2,
      ),
      titleLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      titleMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16,
        height: 1.45,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14,
        height: 1.4,
      ),
      labelLarge: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFFFF7F8),
      textTheme: textTheme.apply(
        bodyColor: const Color(0xFF2B2022),
        displayColor: const Color(0xFF2B2022),
        fontFamily: 'Roboto',
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFF7F8),
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Color(0xFF2B2022)),
        titleTextStyle: TextStyle(
          color: Color(0xFF2B2022),
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: const BorderSide(color: Color(0xFFE8DADD)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: Color(0xFFE8DADD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: Color(0xFFE8DADD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: const TextStyle(color: Color(0xFF8F7E82)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Color(0xFF8F7E82),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
      iconTheme: const IconThemeData(size: 23, opticalSize: 23),
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
      dividerColor: const Color(0xFFE8DADD),
    );
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: AppColors.surface,
      error: AppColors.critical,
      onPrimary: Colors.white,
      onSurface: AppColors.textPrimary,
      outline: const Color(0xFF2A2226),
    );

    final textTheme = ThemeData.dark().textTheme.copyWith(
      displaySmall: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        height: 1.15,
        letterSpacing: -0.5,
      ),
      headlineSmall: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        height: 1.2,
        letterSpacing: -0.2,
      ),
      titleLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      titleMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16,
        height: 1.45,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14,
        height: 1.4,
      ),
      labelLarge: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
        fontFamily: 'Roboto',
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.md,
          ),
          side: const BorderSide(
            color: Color(0xFF2A2226),
            width: 1,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.sm,
          ),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.sm,
          ),
          borderSide: const BorderSide(
            color: Color(0xFF2A2226),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.sm,
          ),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(
          color: AppColors.textMuted,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          side: const BorderSide(color: AppColors.primaryLight, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
      iconTheme: const IconThemeData(size: 23, opticalSize: 23),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.surface,
      ),
      dividerColor: const Color(0xFF2A2226),
      splashColor: AppColors.primary.withValues(
        alpha: 0.08,
      ),
      highlightColor: Colors.transparent,
    );
  }
}
