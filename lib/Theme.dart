import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core surfaces
  static const Color background = Color(0xFF0B0A0C);
  static const Color surface = Color(0xFF161418);
  static const Color surfaceElevated = Color(0xFF1F1B1F);
  static const Color card = Color(0xFF1C171A);

  // Blood reds
  static const Color primary = Color(0xFFE1263A); // core blood red
  static const Color primaryDark = Color(0xFF8C0F1F);
  static const Color primaryLight = Color(0xFFFF5C6C);

  // Status
  static const Color critical = Color(0xFFFF3B3B);
  static const Color high = Color(0xFFFF9F43);
  static const Color normal = Color(0xFFFFD166);
  static const Color success = Color(0xFF35D07F);
  static const Color pending = Color(0xFFFFC94D);

  // Text
  static const Color textPrimary = Color(0xFFF5EDEE);
  static const Color textSecondary = Color(0xFFAFA4A7);
  static const Color textMuted = Color(0xFF6E6468);

  static const LinearGradient bloodGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF3B4E), Color(0xFF8C0F1F)],
  );

  static const LinearGradient darkFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1F1418), Color(0xFF0B0A0C)],
  );
}

class AppRadius {
  AppRadius._();
  static const double sm = 10;
  static const double md = 16;
  static const double lg = 22;
  static const double pill = 100;
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surface,
        error: AppColors.critical,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
        fontFamily: 'Roboto',
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
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
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: const BorderSide(color: Color(0xFF2A2226), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceElevated,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: Color(0xFF2A2226)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: const TextStyle(color: AppColors.textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          textStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.surface,
      ),
      dividerColor: const Color(0xFF2A2226),
      splashColor: AppColors.primary.withOpacity(0.08),
      highlightColor: Colors.transparent,
    );
  }
}

Color statusColor(String urgency) {
  switch (urgency.toLowerCase()) {
    case 'critical':
      return AppColors.critical;
    case 'high':
      return AppColors.high;
    default:
      return AppColors.normal;
  }
}
