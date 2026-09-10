import 'package:flutter/material.dart';
import 'Theme.dart';
import 'Transition.dart';
import 'Home.dart';
import 'Login.dart';

class AppDrawer extends StatelessWidget {
  final int currentIndexHint;
  const AppDrawer({super.key, this.currentIndexHint = -1});

  void _go(BuildContext context, Widget screen) {
    Navigator.pop(context);
    pushSlideFade(context, screen);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          gradient: AppColors.bloodGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.water_drop,
                            color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'COMMUNITY\nBLOOD DONOR',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            letterSpacing: 0.5,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: const Color(0xFF2A2226)),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.primaryDark,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Brylle Pat',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text('Blood Type: O+',
                                      style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12)),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: const [
                                  Icon(Icons.circle,
                                      color: AppColors.success, size: 8),
                                  SizedBox(width: 4),
                                  Text('Active Donor',
                                      style: TextStyle(
                                          color: AppColors.success,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerItem(
                    icon: Icons.home_rounded,
                    label: 'Home',
                    onTap: () => _go(context, const HomeScreen()),
                  ),
                  _DrawerItem(
                    icon: Icons.water_drop_rounded,
                    label: 'Donate Blood',
                    onTap: (){

                    }
                  ),
                  _DrawerItem(
                    icon: Icons.person_rounded,
                    label: 'Search Donor',
                    onTap: (){

                    }
                  ),
                  _DrawerItem(
                    icon: Icons.taxi_alert_rounded,
                    label: 'Request Blood',
                    onTap: (){

                    }
                  ),
                  _DrawerItem(
                    icon: Icons.calendar_month_rounded,
                    label: 'Blood Activities',
                    onTap: (){

                    }
                  ),
                  _DrawerItem(
                    icon: Icons.receipt_long_rounded,
                    label: 'My History',
                    onTap: (){

                    }
                  ),
                  _DrawerItem(
                    icon: Icons.notifications_rounded,
                    label: 'Notifications',
                    trailing: '3',
                    onTap: (){

                    }
                  ),
                  _DrawerItem(
                    icon: Icons.person_rounded,
                    label: 'My Profile',
                    onTap: (){

                    }
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Divider(height: 1),
                  ),
                  _DrawerItem(
                    icon: Icons.settings_rounded,
                    label: 'Settings',
                    onTap: () => Navigator.pop(context),
                  ),
                  _DrawerItem(
                    icon: Icons.help_outline_rounded,
                    label: 'Help & Support',
                    onTap: () => Navigator.pop(context),
                  ),
                  _DrawerItem(
                    icon: Icons.logout_rounded,
                    label: 'Logout',
                    danger: true,
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        SlideFadeRoute(page: const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailing;
  final bool danger;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.critical : AppColors.textPrimary;
    return ListTile(
      leading: Icon(icon, color: danger ? AppColors.critical : AppColors.primaryLight, size: 22),
      title: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 14.5)),
      trailing: trailing != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(trailing!,
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
            )
          : null,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
