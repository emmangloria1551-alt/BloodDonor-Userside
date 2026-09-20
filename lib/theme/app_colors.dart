import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0B0A0C);
  static const Color surface = Color(0xFF161418);
  static const Color surfaceElevated = Color(0xFF1F1B1F);
  static const Color card = Color(0xFF1C171A);

  static const Color primary = Color(0xFFE1263A);
  static const Color primaryDark = Color(0xFF8C0F1F);
  static const Color primaryLight = Color(0xFFFF5C6C);

  static const Color critical = Color(0xFFFF3B3B);
  static const Color high = Color(0xFFFF9F43);
  static const Color normal = Color(0xFFFFD166);
  static const Color success = Color(0xFF35D07F);
  static const Color pending = Color(0xFFFFC94D);

  static const Color textPrimary = Color(0xFFF5EDEE);
  static const Color textSecondary = Color(0xFFAFA4A7);
  static const Color textMuted = Color(0xFF6E6468);

  static const LinearGradient bloodGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF3B4E),
      Color(0xFF8C0F1F),
    ],
  );

  static const LinearGradient darkFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1F1418),
      Color(0xFF0B0A0C),
    ],
  );

  static const LinearGradient lightFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFE7EA),
      Color(0xFFFFF7F8),
    ],
  );
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
