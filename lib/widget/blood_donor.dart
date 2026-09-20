import 'package:flutter/material.dart';
import '../model/blood_donor.dart';

import '../theme/app_colors.dart';

class BloodDonorCard extends StatelessWidget {
  final BloodDonor donor;
  final VoidCallback onRequestBlood;

  const BloodDonorCard({
    super.key,
    required this.donor,
    required this.onRequestBlood,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final bloodTypeColor = isLight
        ? const Color(0xFF087443)
        : AppColors.success;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BLOOD REQUEST',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        donor.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                _Badge(
                  label: donor.bloodType,
                  color: bloodTypeColor,
                  icon: Icons.bloodtype_rounded,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _SummaryTile(
                    icon: Icons.location_on_outlined,
                    label: donor.location,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: donor.isAvailable
                ? const _Badge(
                    label: 'Available',
                    color: Colors.green,
                    icon: Icons.check_circle_outline_rounded,
                  )
                : _Badge(
                    label: 'Unavailable',
                    color: theme.disabledColor,
                    icon: Icons.remove_circle_outline_rounded,
                  ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showProfile(context),
                    icon: const Icon(Icons.person_outline_rounded, size: 18),
                    label: const Text('View profile'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: donor.isAvailable ? onRequestBlood : null,
                    icon: const Icon(Icons.water_drop_rounded, size: 18),
                    label: Text(donor.isAvailable ? 'Request' : 'Unavailable'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showProfile(BuildContext context) {
    final theme = Theme.of(context);
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: theme.colorScheme.primary.withValues(
                      alpha: 0.12,
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      donor.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  _Badge(
                    label: donor.bloodType,
                    color: theme.colorScheme.primary,
                    icon: Icons.bloodtype_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _ProfileRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: donor.email,
              ),
              _ProfileRow(
                icon: Icons.phone_outlined,
                label: 'Contact',
                value: donor.contact,
              ),
              _ProfileRow(
                icon: Icons.location_on_outlined,
                label: 'Location',
                value: donor.location,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 17, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 19, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color, required this.icon});

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
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
