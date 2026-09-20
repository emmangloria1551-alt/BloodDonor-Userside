import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../widget/gradient_button.dart';
import '../widget/app_logo.dart';
class BloodActivityDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const _BloodActivityDialogContent(),
    );
  }
}

class _BloodActivityDialogContent extends StatelessWidget {
  const _BloodActivityDialogContent();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const AppLogo(
                  size: 52,
                  iconSize: 28,
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'Blood Donation Activity',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const Text('Community Blood Drive', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(
              'Give blood, give hope.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 22),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.08)),
              ),
              child: const Column(
                children: [
                  _DetailRow(icon: Icons.calendar_today_outlined, label: 'Date', value: 'September 20, 2026'),
                  SizedBox(height: 16),
                  _DetailRow(icon: Icons.access_time_outlined, label: 'Time', value: '9:00 AM – 3:00 PM'),
                  SizedBox(height: 16),
                  _DetailRow(icon: Icons.location_on_outlined, label: 'Location', value: 'City Hall'),
                  SizedBox(height: 16),
                  _DetailRow(icon: Icons.local_hospital_outlined, label: 'Organizer', value: 'City Blood Bank'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'Would you like to join this blood donation activity?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, height: 1.4),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('CANCEL', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: GradientButton(
                      label: 'JOIN NOW',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryLight),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(value, style: const TextStyle(fontSize: 13)),
        ),
      ],
    );
  }
}
