import 'package:flutter/material.dart';
import '../model/blood_request_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class BloodRequestCard extends StatelessWidget {
  const BloodRequestCard({
    super.key,
    required this.request,
    this.onTap,
  });

  final BloodRequest request;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final urgencyColor = statusColor(request.urgency);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(urgencyColor),

              const SizedBox(height: 18),

              _buildBloodInfo(),

              const SizedBox(height: 18),

              const Divider(
                height: 1,
                color: Color(0xFF2A2226),
              ),

              const SizedBox(height: 16),

              _buildHospital(),

              const SizedBox(height: 12),

              _buildLocation(),

              const SizedBox(height: 18),

              _buildViewButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color urgencyColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: urgencyColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: urgencyColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: urgencyColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 7),
              Text(
                request.urgency.toUpperCase(),
                style: TextStyle(
                  color: urgencyColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        Text(
          _timeAgo(request.createdAt),
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildBloodInfo() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: AppColors.bloodGradient,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          alignment: Alignment.center,
          child: Text(
            request.bloodType,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),

        const SizedBox(width: 14),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Blood Needed',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              '${request.units} '
                  '${request.units == 1 ? 'unit' : 'units'}',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHospital() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.local_hospital_outlined,
          color: AppColors.primaryLight,
          size: 20,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hospital',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                request.hospital,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: AppColors.primaryLight,
          size: 20,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Location',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                request.location,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildViewButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          side: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 13,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.sm,
            ),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'VIEW REQUEST',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.7,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    }

    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
