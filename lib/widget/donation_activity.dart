import 'package:blood_donor/model/blood_request_model.dart';
import 'package:blood_donor/model/blood_drive.dart';
import 'package:flutter/material.dart';
import '../theme/app_radius.dart';

class DonationActivityCard extends StatefulWidget {
  const DonationActivityCard({
    super.key,
    required this.activity,
    required this.onJoin,
    required this.isCompatible,
  });

  final BloodRequest activity;
  final VoidCallback onJoin;
  final bool isCompatible;

  @override
  State<DonationActivityCard> createState() => _DonationActivityCardState();
}

class UpcomingBloodActivitiesScreen extends StatelessWidget {
  const UpcomingBloodActivitiesScreen({super.key});

  static const activities = [
    BloodDrive(
      name: 'Community Blood Drive',
      description: 'Give blood, give hope.',
      date: 'September 20, 2026',
      time: '9:00 AM – 3:00 PM',
      location: 'City Hall',
    ),
    BloodDrive(
      name: 'Red Cross Donation Day',
      description: 'Help keep local blood supplies ready.',
      date: 'October 4, 2026',
      time: '8:00 AM – 2:00 PM',
      location: 'Quezon City Sports Complex',
    ),
    BloodDrive(
      name: 'Hospital Community Drive',
      description: 'Every donation can save up to three lives.',
      date: 'October 18, 2026',
      time: '10:00 AM – 4:00 PM',
      location: 'Community Hospital',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming Blood Activities')),
      body: ListView.separated(
        padding: const EdgeInsets.all(18),
        itemCount: activities.length,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final activity = activities[index];
          return _UpcomingActivityCard(activity: activity);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showActivityDetails(context, activities.first),
        icon: const Icon(Icons.event_available_rounded),
        label: const Text('View first activity'),
      ),
    );
  }

  static void _showActivityDetails(BuildContext context, BloodDrive activity) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(activity.name),
        content: Text(
          '${activity.description}\n\n'
          '${activity.date}\n${activity.time}\n${activity.location}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Reserve slot'),
          ),
        ],
      ),
    );
  }
}

class _UpcomingActivityCard extends StatelessWidget {
  const _UpcomingActivityCard({required this.activity});

  final BloodDrive activity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: () => UpcomingBloodActivitiesScreen._showActivityDetails(
          context,
          activity,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(
                      Icons.water_drop_rounded,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      activity.name,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(activity.description, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 12),
              _ActivityDetailRow(
                icon: Icons.calendar_today_outlined,
                label: activity.date,
              ),
              const SizedBox(height: 8),
              _ActivityDetailRow(
                icon: Icons.access_time_outlined,
                label: activity.time,
              ),
              const SizedBox(height: 8),
              _ActivityDetailRow(
                icon: Icons.location_on_outlined,
                label: activity.location,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityDetailRow extends StatelessWidget {
  const _ActivityDetailRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(child: Text(label)),
      ],
    );
  }
}

class _DonationActivityCardState extends State<DonationActivityCard> {
  bool _showProfile = false;

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.bloodtype_rounded,
                    color: colorScheme.primary,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BLOOD REQUEST',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        activity.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${activity.hospital} • ${activity.location}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                _RequestBadge(
                  icon: Icons.bloodtype_rounded,
                  label: activity.bloodType,
                  color: colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _RequestBadge(
                  icon: Icons.priority_high_rounded,
                  label: activity.urgency,
                  color: _urgencyColor(activity.urgency),
                ),
                if (widget.isCompatible)
                  const _RequestBadge(
                    icon: Icons.check_circle_rounded,
                    label: 'Compatible',
                    color: Colors.green,
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _SummaryItem(
                    icon: Icons.water_drop_outlined,
                    label:
                        '${activity.units} ${activity.units == 1 ? 'unit' : 'units'} needed',
                  ),
                ),
                _SummaryItem(
                  icon: Icons.calendar_today_outlined,
                  label: _formatDate(activity.createdAt),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        setState(() => _showProfile = !_showProfile),
                    icon: Icon(
                      _showProfile
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.person_outline_rounded,
                    ),
                    label: Text(_showProfile ? 'Hide details' : 'View details'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: widget.onJoin,
                    icon: const Icon(Icons.volunteer_activism_rounded),
                    label: const Text('Donate'),
                  ),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              child: !_showProfile
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.45,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            InfoRow(
                              icon: Icons.email_outlined,
                              label: activity.email,
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              icon: Icons.phone_outlined,
                              label: activity.contact,
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              icon: Icons.location_on_outlined,
                              label: activity.location,
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              icon: Icons.local_hospital_outlined,
                              label: activity.hospital,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _RequestBadge extends StatelessWidget {
  const _RequestBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.icon, required this.label});

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
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

Color _urgencyColor(String urgency) {
  switch (urgency.toLowerCase()) {
    case 'critical':
      return const Color(0xFFD32F2F);
    case 'urgent':
      return const Color(0xFFE07800);
    default:
      return const Color(0xFF9A7200);
  }
}

String _formatDate(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
