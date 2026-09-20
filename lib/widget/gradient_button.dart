import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.height = 52,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: AppColors.bloodGradient,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          hoverColor: Colors.white.withValues(alpha: 0.1),
          splashColor: Colors.white.withValues(alpha: 0.2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                ],
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
