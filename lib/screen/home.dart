import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'drawer.dart';
import 'join.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../widget/gradient_button.dart';
import '../widget/app_logo.dart';
import 'donate_screen.dart';
import "blood_request.dart";
import 'profile.dart';
import '../model/user_profile.dart';
import 'notifications.dart';
import 'activity.dart';
import '../widget/donation_activity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<HomeScreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<HomeScreen> {
  late int _currentIndex;
  late UserProfile _user;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _user = UserProfile(
      name: 'Brylle',
      email: 'brylle@example.com',
      contact: '0912 345 6789',
      address: 'Quezon City, Philippines',
      bloodType: 'O+',
    );
  }

  Future<void> _navigateToProfile() async {
    final updatedUser = await showDialog<UserProfile>(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        backgroundColor: Colors.transparent,
        child: ProfileScreen(initialUser: _user),
      ),
    );

    if (updatedUser != null && mounted) {
      setState(() {
        _user = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_outlined),
            activeIcon: Icon(Icons.water_drop_rounded),
            label: 'Donate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bloodtype_outlined),
            activeIcon: Icon(Icons.bloodtype_rounded),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history_rounded),
            label: 'Activity',
          ),
        ],
      ),

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? 'Community Blood Donor'
              : _currentIndex == 1
              ? 'Donate Blood'
              : _currentIndex == 2
              ? 'Request Blood'
              : 'Your Activity',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: _navigateToProfile,
            tooltip: 'Profile',
            icon: const Icon(Icons.account_circle_outlined),
          ),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: appThemeMode,
            builder: (context, themeMode, child) {
              final isDark = themeMode == ThemeMode.dark;
              return IconButton(
                tooltip: isDark
                    ? 'Switch to light mode'
                    : 'Switch to dark mode',
                onPressed: () {
                  appThemeMode.value = isDark
                      ? ThemeMode.light
                      : ThemeMode.dark;
                },
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              );
            },
          ),
        ],
      ),

      // =========================
      // DRAWER
      // =========================
      drawer: AppDrawer(onProfileTap: _navigateToProfile),

      // =========================
      // BODY
      // =========================
      body: _currentIndex == 0
          ? _buildHomeContent()
          : _currentIndex == 1
          ? const Donate()
          : _currentIndex == 2
          ? const BloodRequestScreen()
          : const ActivityScreen(),
    );
  }

  Widget _buildHomeContent() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bloodCardTextColor = theme.colorScheme.onSurface;
    final bloodCardMutedColor =
        theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurface;
    final bloodCardAccent = theme.colorScheme.primary;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(
          'Hello, ${_user.name}! 👋',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 6),
        Text(
          'Your donation can help save up to 3 lives.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Every donation brings hope closer to someone who needs it.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'What would you like to do?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.water_drop_rounded,
                title: 'Donate Blood',
                subtitle: 'Save up to 3 lives',
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.bloodtype_rounded,
                title: 'Request Blood',
                subtitle: 'Find a donor',
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: bloodCardAccent.withValues(alpha: isDark ? 0.35 : 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: bloodCardAccent.withValues(alpha: isDark ? 0.18 : 0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR BLOOD TYPE',
                  style: TextStyle(
                    color: bloodCardTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _user.bloodType,
                  style: TextStyle(
                    color: bloodCardAccent,
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
                    color: bloodCardAccent.withValues(
                      alpha: isDark ? 0.18 : 0.1,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, color: AppColors.success, size: 8),
                      const SizedBox(width: 6),
                      Text(
                        'Available to Donate',
                        style: TextStyle(
                          color: AppColors.success,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() => _currentIndex = 3),
                    icon: const Icon(Icons.event_note_rounded),
                    label: const Text('View donation activity'),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You are eligible to donate',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: bloodCardAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: isDark ? 0.7 : 0.8,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Column(
                    children: [
                      _BloodStatusRow(
                        icon: Icons.history_rounded,
                        label: 'Last donation',
                        value: 'June 20, 2026',
                        textColor: bloodCardTextColor,
                        mutedColor: bloodCardMutedColor,
                      ),
                      const SizedBox(height: 10),
                      _BloodStatusRow(
                        icon: Icons.event_available_rounded,
                        label: 'Next eligible date',
                        value: 'September 20, 2026',
                        textColor: bloodCardTextColor,
                        mutedColor: bloodCardMutedColor,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(height: 1),
                ),
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(
                          alpha: 0.12,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_rounded,
                        color: theme.colorScheme.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your impact',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    const _ImpactValue(value: '2', label: 'Donations'),
                    const SizedBox(width: 18),
                    const _ImpactValue(value: '6', label: 'Lives helped'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 26),
        Text(
          'Urgent blood requests',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 0.8,
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
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.bloodtype_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No urgent requests nearby',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'We’ll notify you when someone needs your blood type.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: theme.textTheme.bodyMedium?.color
                                      ?.withValues(alpha: 0.7),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming blood drives',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 0.8,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UpcomingBloodActivitiesScreen(),
                  ),
                );
              },
              child: const Text('See more'),
            ),
          ],
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
                    const AppLogo(size: 48, iconSize: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Blood Donation Activity',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Give blood, give hope.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: theme.textTheme.bodyMedium?.color
                                      ?.withValues(alpha: 0.7),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    _ActivityTag(
                      icon: Icons.timelapse_rounded,
                      label: 'Starts in 4 days',
                    ),
                    const SizedBox(width: 8),
                    _ActivityTag(
                      icon: Icons.people_alt_outlined,
                      label: '12 slots',
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'September 20, 2026',
                ),
                const SizedBox(height: 12),
                _InfoRow(
                  icon: Icons.access_time_outlined,
                  label: '9:00 AM – 3:00 PM',
                ),
                const SizedBox(height: 12),
                _InfoRow(icon: Icons.location_on_outlined, label: 'City Hall'),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: GradientButton(
                    label: 'RESERVE MY SLOT',
                    icon: Icons.event_available_rounded,
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
    );
  }
}

// =========================
// INFO ROW
// =========================

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        hoverColor: primary.withValues(alpha: 0.08),
        splashColor: primary.withValues(alpha: 0.12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: isDark
                  ? theme.dividerColor.withValues(alpha: 0.8)
                  : theme.dividerColor,
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: isDark ? 0.18 : 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isDark ? theme.colorScheme.secondary : primary,
                  size: 22,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Icon(
                Icons.arrow_forward_rounded,
                color: isDark ? theme.colorScheme.secondary : primary,
                size: 19,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImpactValue extends StatelessWidget {
  const _ImpactValue({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _ActivityTag extends StatelessWidget {
  const _ActivityTag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: theme.colorScheme.primary),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BloodStatusRow extends StatelessWidget {
  const _BloodStatusRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.textColor,
    required this.mutedColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: textColor, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(label, style: TextStyle(color: mutedColor, fontSize: 12)),
        ),
        Text(
          value,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
