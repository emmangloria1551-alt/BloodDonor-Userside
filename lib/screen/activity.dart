import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../widget/donation_activity.dart';
import 'join.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
        children: [
          Text('Your Activity', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(
            'Manage upcoming blood drives and review your donation history.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    color: theme.colorScheme.primary,
                    size: 30,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'You have helped save up to 6 lives.',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.55,
              ),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'History'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 460,
            child: TabBarView(
              children: [
                _UpcomingTab(theme: theme),
                _HistoryTab(theme: theme),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingTab extends StatelessWidget {
  const _UpcomingTab({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Text(
          'Upcoming blood donation activity',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.event_available_rounded,
                      color: theme.colorScheme.primary,
                      size: 30,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Community Blood Drive',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const _ActivityInfo(
                  icon: Icons.calendar_today_outlined,
                  text: 'September 20, 2026',
                ),
                const SizedBox(height: 9),
                const _ActivityInfo(
                  icon: Icons.access_time_outlined,
                  text: '9:00 AM – 3:00 PM',
                ),
                const SizedBox(height: 9),
                const _ActivityInfo(
                  icon: Icons.location_on_outlined,
                  text: 'City Hall',
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => BloodActivityDialog.show(context),
                    icon: const Icon(Icons.event_available_rounded),
                    label: const Text('View activity'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UpcomingBloodActivitiesScreen(),
              ),
            );
          },
          icon: const Icon(Icons.list_alt_rounded),
          label: const Text('See all upcoming activities'),
        ),
      ],
    );
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Text('Completed donations', style: theme.textTheme.titleMedium),
        const SizedBox(height: 10),
        Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary.withValues(
                alpha: 0.12,
              ),
              child: Icon(
                Icons.water_drop_rounded,
                color: theme.colorScheme.primary,
              ),
            ),
            title: const Text('Blood donation completed'),
            subtitle: const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text('June 20, 2026 • Community Hospital\n1 unit • O+'),
            ),
            isThreeLine: true,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: const Text(
                'Completed',
                style: TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Icon(
                  Icons.volunteer_activism_rounded,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Keep donating when you are eligible. Your history will grow with every completed donation.',
                    style: theme.textTheme.bodyMedium,
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

class _ActivityInfo extends StatelessWidget {
  const _ActivityInfo({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
