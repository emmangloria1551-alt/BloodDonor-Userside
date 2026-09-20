import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      icon: Icons.water_drop_rounded,
      title: 'Your next donation date is coming up',
      message: 'You may be eligible to donate again on September 20, 2026.',
      time: 'Today',
      color: AppColors.primary,
    ),
    _NotificationItem(
      icon: Icons.bloodtype_rounded,
      title: 'Urgent blood request nearby',
      message:
          'A patient needs O+ blood. Check the request and help if you can.',
      time: 'Yesterday',
      color: AppColors.critical,
    ),
    _NotificationItem(
      icon: Icons.favorite_rounded,
      title: 'Your donation makes a difference',
      message:
          'One donation can help save up to three lives. Thank you, Brylle!',
      time: '3 days ago',
      color: AppColors.success,
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (final notification in _notifications) {
        notification.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unreadCount = _notifications.where((item) => !item.isRead).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text('Mark all read'),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _EmptyNotifications(theme: theme)
          : ListView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
              children: [
                Text(
                  unreadCount == 0
                      ? 'You’re all caught up'
                      : '$unreadCount new notification${unreadCount == 1 ? '' : 's'}',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 14),
                ..._notifications.map(
                  (notification) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _NotificationCard(
                      notification: notification,
                      onTap: () => setState(() {
                        notification.isRead = true;
                      }),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _NotificationItem {
  _NotificationItem({
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String message;
  final String time;
  final Color color;
  bool isRead = false;
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification, required this.onTap});

  final _NotificationItem notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = notification.isRead
        ? theme.colorScheme.surface
        : theme.colorScheme.primary.withValues(alpha: 0.07);

    return Card(
      color: background,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: notification.color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(notification.icon, color: notification.color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: notification.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w800,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(top: 6, left: 8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      notification.message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      notification.time,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: 64,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text('No notifications yet', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'We’ll let you know when something needs your attention.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
