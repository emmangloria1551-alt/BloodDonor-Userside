import 'package:flutter/material.dart';
import 'Theme.dart';
import 'Common.dart';

class HelpRequestDialog {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const _HelpRequestSheet();
      },
    );
  }
}

class _HelpRequestSheet extends StatelessWidget {
  const _HelpRequestSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        24,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==============================
            // HANDLE
            // ==============================

            Center(
              child: Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 22),

            // ==============================
            // HEADER
            // ==============================

            Row(
              children: [

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.water_drop_rounded,
                    color: AppColors.primary,
                    size: 26,
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    'Blood Donation Request',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // ==============================
            // BLOOD TYPE + STATUS
            // ==============================

            Row(
              children: [

                const Expanded(
                  child: Text(
                    'A+ Blood Needed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                const StatusChip(
                  label: 'Critical',
                  color: AppColors.critical,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ==============================
            // REQUEST DETAILS
            // ==============================

            const _HelpDetailRow(
              icon: Icons.person_outline,
              label: 'Patient',
              value: 'Maria Santos',
            ),

            const SizedBox(height: 13),

            const _HelpDetailRow(
              icon: Icons.local_hospital_outlined,
              label: 'Hospital',
              value: 'City Hospital',
            ),

            const SizedBox(height: 13),

            const _HelpDetailRow(
              icon: Icons.location_on_outlined,
              label: 'Location',
              value: 'Quezon City',
            ),

            const SizedBox(height: 13),

            const _HelpDetailRow(
              icon: Icons.water_drop_outlined,
              label: 'Blood Needed',
              value: '2 Units',
            ),

            const SizedBox(height: 13),

            const _HelpDetailRow(
              icon: Icons.access_time_outlined,
              label: 'Needed',
              value: 'Today',
            ),

            const SizedBox(height: 22),

            // ==============================
            // QUESTION
            // ==============================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.07),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Are you available to help with this blood request?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==============================
            // BUTTONS
            // ==============================

            Row(
              children: [

                // CANCEL
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // I CAN HELP
                Expanded(
                  child: GradientButton(
                    label: 'I CAN HELP',
                    onTap: () {
                      Navigator.pop(context);

                      Future.delayed(
                        const Duration(milliseconds: 200),
                            () {
                          if (context.mounted) {
                            _showSuccessDialog(context);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // SUCCESS DIALOG
  // ==========================================

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: const EdgeInsets.fromLTRB(
            24,
            28,
            24,
            20,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // Success icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.green,
                  size: 34,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Thank You!',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Your willingness to donate has been recorded.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'The hospital or requester can contact you regarding this request.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: 'DONE',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


// ==========================================
// DETAIL ROW
// ==========================================

class _HelpDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _HelpDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Icon(
          icon,
          size: 19,
          color: AppColors.primaryLight,
        ),

        const SizedBox(width: 10),

        Text(
          '$label:',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),

        const SizedBox(width: 6),

        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
