import 'package:flutter/material.dart';
import 'drawer.dart';
import 'join.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../widget/gradient_button.dart';
import 'donate_screen.dart';
import "blood_request.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Donate(),
              ),


            );
          }
            else if (index == 2){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context)=>Blood_Request()));
          };
          },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: "Donate",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency),
            label: "Request Blood",
          ),
        ],
      ),

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        title: const Text('Community Blood Donor'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),

      // =========================
      // DRAWER
      // =========================
      drawer: const AppDrawer(),

      // =========================
      // BODY
      // =========================
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // GREETING
          const Text(
            'Hello, Brylle! 👋',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Ready to save a life today?',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 22),

          // =========================
          // BLOOD TYPE CARD
          // =========================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppColors.bloodGradient,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 90),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'YOUR BLOOD TYPE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'O+',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 80),
                      borderRadius: BorderRadius.circular(
                        AppRadius.pill,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 8,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Available to Donate',
                          style: TextStyle(
                            color: Colors.green,
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

          // =========================
          // URGENT BLOOD REQUEST
          // =========================
          const Text(
            'URGENT BLOOD REQUEST',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 0.4,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 30),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.emergency,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'No Urgent Request',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'There are currently no urgent blood requests.',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 26),

          // =========================
          // UPCOMING BLOOD ACTIVITY
          // =========================
          const Text(
            'UPCOMING BLOOD ACTIVITY',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 0.4,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ACTIVITY HEADER
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

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Blood Donation Activity',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              'Give blood, give hope.',
                              style: TextStyle(
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

                  // DATE
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'September 20, 2026',
                  ),

                  const SizedBox(height: 12),

                  // TIME
                  _InfoRow(
                    icon: Icons.access_time_outlined,
                    label: '9:00 AM – 3:00 PM',
                  ),

                  const SizedBox(height: 12),

                  // LOCATION
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'City Hall',
                  ),

                  const SizedBox(height: 16),

                  // JOIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: GradientButton(
                      label: 'JOIN NOW',
                      onTap: () {
                        BloodActivityDialog.show(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================
// INFO ROW
// =========================

class _InfoRow extends StatelessWidget {
  const _InfoRow({
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