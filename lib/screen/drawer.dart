import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _go(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      gradient: AppColors.bloodGradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.water_drop, color: Colors.white, size: 20),
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
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerItem(icon: Icons.home_rounded, label: 'Home', onTap: () => _go(context, const HomeScreen())),
                  _DrawerItem(icon: Icons.water_drop_rounded, label: 'Donate Blood', onTap: () {}),
                  _DrawerItem(icon: Icons.search_rounded, label: 'Search Donor', onTap: () {}),
                  _DrawerItem(icon: Icons.request_page_rounded, label: 'Request Blood', onTap: () {}),
                  _DrawerItem(icon: Icons.calendar_month_rounded, label: 'Blood Activities', onTap: () {}),
                  _DrawerItem(icon: Icons.receipt_long_rounded, label: 'My History', onTap: () {}),
                  _DrawerItem(icon: Icons.notifications_rounded, label: 'Notifications', trailing: '3', onTap: () {}),
                  _DrawerItem(icon: Icons.person_rounded, label: 'My Profile', onTap: () {}),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Divider(height: 1),
                  ),
                  _DrawerItem(icon: Icons.settings_rounded, label: 'Settings', onTap: () => Navigator.pop(context)),
                  _DrawerItem(icon: Icons.help_outline_rounded, label: 'Help & Support', onTap: () => Navigator.pop(context)),
                  _DrawerItem(
                    icon: Icons.logout_rounded,
                    label: 'Logout',
                    danger: true,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
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
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final String? trailing;
  final bool danger;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.critical : AppColors.textPrimary;
    return ListTile(
      leading: Icon(icon, color: danger ? AppColors.critical : AppColors.primaryLight, size: 22),
      title: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 14.5),
      ),
      trailing: trailing != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                trailing!,
                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
              ),
            )
          : null,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
