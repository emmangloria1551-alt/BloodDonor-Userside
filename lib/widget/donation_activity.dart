import 'package:blood_donor/model/blood_request_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../widget/gradient_button.dart';

class DonationActivityCard extends StatelessWidget {
  const DonationActivityCard({
    super.key,
    required this.activity,
    required this.onJoin,
  });

  final BloodRequest activity;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Activity header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 30),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.water_drop_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        activity.bloodType,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Date
            InfoRow(
              icon: Icons.emergency_outlined,
              label: "${activity.units}units",
            ),

            const SizedBox(height: 12),

            // Time
            InfoRow(
              icon: Icons.access_time_outlined,
              label: activity.hospital,
            ),

            const SizedBox(height: 12),

            // Location
            InfoRow(
              icon: Icons.location_on_outlined,
              label: activity.location,
            ),

            const SizedBox(height: 16),

            // Button
            SizedBox(
              width: double.infinity,
              child: GradientButton(
                label: 'Help now ',
                onTap: onJoin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.textSecondary,
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
