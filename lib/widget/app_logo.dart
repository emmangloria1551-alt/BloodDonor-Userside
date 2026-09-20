import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final double iconSize;
  final bool hasGradient;

  const AppLogo({
    super.key,
    this.size = 48,
    this.iconSize = 24,
    this.hasGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: hasGradient ? AppColors.bloodGradient : null,
        color: hasGradient ? null : AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.water_drop_rounded,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}
