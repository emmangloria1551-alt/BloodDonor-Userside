import 'package:flutter/material.dart';
import 'Theme.dart';
import 'Transition.dart';
import 'Drawer.dart';
import 'Common.dart';
import 'Help.dart';
import 'Join.dart';
class HomeScreen extends StatelessWidget {
  final bool embedded;

  const HomeScreen({
    super.key,
    this.embedded = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeSlideIn(
            child: const Text(
              'Hello, Brylle! 👋',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(height: 4),

          FadeSlideIn(
            delayMs: 40,
            child: Text(
              'Ready to save a life today?',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.5,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ==================================================
          // BLOOD TYPE CARD
          // ==================================================

          FadeSlideIn(
            delayMs: 80,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 26,
              ),
              decoration: BoxDecoration(
                gradient: AppColors.bloodGradient,
                borderRadius: BorderRadius.circular(
                  AppRadius.lg,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [

                  Text(
                    'YOUR BLOOD TYPE',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'O+',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Availability
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(
                        AppRadius.pill,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [

                        Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 8,
                        ),

                        SizedBox(width: 6),

                        Text(
                          'Available to Donate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 26),

          // ==================================================
          // URGENT BLOOD REQUEST
          // ==================================================

          FadeSlideIn(
            delayMs: 120,
            child: Row(
              children: const [

                Icon(
                  Icons.warning_rounded,
                  color: AppColors.critical,
                  size: 18,
                ),

                SizedBox(width: 6),

                Text(
                  'URGENT BLOOD REQUEST',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          FadeSlideIn(
            delayMs: 150,
            child: SectionCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Blood type + status
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        const Expanded(
                          child: Text(
                            'A+ Blood Needed',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        const StatusChip(
                          label: 'Critical',
                          color: AppColors.critical,
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Patient name
                    Row(
                      children: [

                        Icon(
                          Icons.person_outline,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          'Maria Santos',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 11),

                    // Location
                    Row(
                      children: [

                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),

                        const SizedBox(width: 8),

                        const Expanded(
                          child: Text(
                            'Quezon City',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 11),

                    // Hospital
                    Row(
                      children: [

                        Icon(
                          Icons.local_hospital_outlined,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),

                        const SizedBox(width: 8),

                        const Expanded(
                          child: Text(
                            'City Hospital',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 11),

                    // Units
                    Row(
                      children: [

                        const Icon(
                          Icons.water_drop_outlined,
                          size: 18,
                          color: AppColors.primaryLight,
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          '2 Units',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 11),

                    // Needed time
                    Row(
                      children: [

                        Icon(
                          Icons.access_time_outlined,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          'Needed Today',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Help button
                    SizedBox(
                      width: double.infinity,
                      child: GradientButton(
                        label: 'HELP NOW',
                        onTap: () {
                          HelpRequestDialog.show(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 26),

          // ==================================================
          // UPCOMING BLOOD ACTIVITY
          // ==================================================

          FadeSlideIn(
            delayMs: 190,
            child: const Text(
              'UPCOMING BLOOD ACTIVITY',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 0.4,
              ),
            ),
          ),

          const SizedBox(height: 10),

          FadeSlideIn(
            delayMs: 220,
            child: SectionCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Activity header
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary
                                .withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.water_drop_rounded,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Community Blood Drive',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                'Give blood, give hope.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Date
                    Row(
                      children: [

                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                          color: AppColors.primaryLight,
                        ),

                        const SizedBox(width: 9),

                        const Text(
                          'September 20, 2026',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Time
                    Row(
                      children: [

                        const Icon(
                          Icons.access_time_outlined,
                          size: 18,
                          color: AppColors.primaryLight,
                        ),

                        const SizedBox(width: 9),

                        const Text(
                          '9:00 AM – 3:00 PM',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Location
                    Row(
                      children: [

                        const Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: AppColors.primaryLight,
                        ),

                        const SizedBox(width: 9),

                        const Expanded(
                          child: Text(
                            'City Hall',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Join Activity
                    SizedBox(
                      width: double.infinity,
                      child: GradientButton(
                        label: 'JOIN ACTIVITY',
                        onTap: () {
                          BloodActivityDialog.show(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 26),

          // ==================================================
          // QUICK ACTIONS
          // ==================================================

          const Text(
            'QUICK ACTIONS',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 0.4,
            ),
          ),

          const SizedBox(height: 10),

          FadeSlideIn(
            delayMs: 260,
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              // Smaller gaps
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,

              // Smaller/shorter cards
              childAspectRatio: 1.9,

              children: [

                // Donate
                _QuickAction(
                  icon: Icons.water_drop_rounded,
                  label: 'Donate Blood',
                  onTap: () {

                  },
                ),

                // Find
                _QuickAction(
                  icon: Icons.search_rounded,
                  label: 'Search Donor',
                  onTap: () {
                   ;
                  },
                ),

                // Request
                _QuickAction(
                  icon: Icons.calendar_month_rounded,
                  label: 'Blood Activities',
                  onTap: () {

                  },
                ),

                // History
                _QuickAction(
                  icon: Icons.receipt_long_rounded,
                  label: 'History',
                  onTap: () {

                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );

    // ======================================================
    // EMBEDDED HOME
    // ======================================================

    if (embedded) {
      return content;
    }

    // ======================================================
    // STANDALONE HOME
    // ======================================================

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Community Blood Donor',
        ),
        actions: [

          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
            onPressed: () {

            },
          ),
        ],
      ),

      drawer: const AppDrawer(),

      body: content,
    );
  }
}


// ==========================================================
// QUICK ACTION WIDGET
// ==========================================================

class _QuickAction extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_QuickAction> createState() => _QuickActionState();
}


class _QuickActionState extends State<_QuickAction> {
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTapDown: (_) {
        setState(() {
          _scale = 0.95;
        });
      },

      onTapUp: (_) {
        setState(() {
          _scale = 1;
        });
      },

      onTapCancel: () {
        setState(() {
          _scale = 1;
        });
      },

      onTap: widget.onTap,

      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(
          milliseconds: 120,
        ),

        child: SectionCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Smaller icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: AppColors.primaryLight,
                  size: 19,
                ),
              ),

              const SizedBox(height: 5),

              // Smaller text
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
