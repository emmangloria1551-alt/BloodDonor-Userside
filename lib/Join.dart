import 'package:flutter/material.dart';
import 'Theme.dart';
import 'Common.dart';

class BloodActivityDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return const _BloodActivityDialogContent();
      },
    );
  }
}

class _BloodActivityDialogContent extends StatelessWidget {
  const _BloodActivityDialogContent();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          22,
          24,
          22,
          22,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==================================================
              // HEADER
              // ==================================================

              Row(
                children: [

                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.water_drop_rounded,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Text(
                      'Blood Donation Activity',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ==================================================
              // ACTIVITY NAME
              // ==================================================

              const Text(
                'Community Blood Drive',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Give blood, give hope.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // ACTIVITY DETAILS
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.08),
                  ),
                ),
                child: Column(
                  children: [

                    const _ActivityDetailRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Date',
                      value: 'September 20, 2026',
                    ),

                    const SizedBox(height: 16),

                    const _ActivityDetailRow(
                      icon: Icons.access_time_outlined,
                      label: 'Time',
                      value: '9:00 AM – 3:00 PM',
                    ),

                    const SizedBox(height: 16),

                    const _ActivityDetailRow(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: 'City Hall',
                    ),

                    const SizedBox(height: 16),

                    const _ActivityDetailRow(
                      icon: Icons.local_hospital_outlined,
                      label: 'Organizer',
                      value: 'City Blood Bank',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // MESSAGE
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  'Would you like to join this blood donation activity?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // BUTTONS
              // ==================================================

              Row(
                children: [

                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color: AppColors.primary.withOpacity(0.35),
                          ),
                        ),
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SUCCESS DIALOG
  // ==========================================================

  static void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              30,
              24,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.green,
                    size: 38,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'You\'re In!',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'You have successfully joined the Community Blood Drive.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'We\'ll remind you about the activity before the event.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: GradientButton(
                    label: 'DONE',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// ==========================================================
// DETAIL ROW
// ==========================================================

class _ActivityDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ActivityDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.10),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            icon,
            size: 19,
            color: AppColors.primaryLight,
          ),
        ),

        const SizedBox(width: 12),

        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
