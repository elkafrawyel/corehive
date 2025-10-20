import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/material.dart';
import '../../../data/models/notification_model.dart';
import '../../widgets/app_card.dart';
import '../../widgets/paginated_views/app_paginated_listview.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final GlobalKey<AppPaginatedListviewState> listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: AppPaginatedListview<NotificationModel>(
        key: listKey,
        fakeDataGenerator: () {
          return List.generate(
            15,//page size
            (i) => NotificationModel(
              id: i.toString(),
              title: 'Notification Title $i',
              body: 'Body of notification.',
              date: DateTime.now().subtract(Duration(minutes: i)),
            ),
          );
        },
        shimmerLoading: _NotificationShimmer(),
        emptyView: const Center(child: Text('No notifications found.')),
        child: (notification) => GestureDetector(
          onTap: () {
            listKey.currentState?.updateSingleItem(
              notification.copyWith(isRead: true),
            );
          },
          child: _NotificationTile(notification: notification),
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      elevation: notification.isRead ? 0 : 2,
      child: ListTile(
        leading: Icon(
          notification.isRead ? Icons.notifications_none : Icons.notifications,
          color: notification.isRead
              ? Colors.grey
              : Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead
                ? FontWeight.normal
                : FontWeight.bold,
          ),
        ),
        subtitle: Text(notification.body),
        trailing: Text(
          _formatDate(notification.date),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hr ago';
    } else {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    }
  }
}

class _NotificationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        leading: Container(width: 32, height: 32, color: Colors.grey[300]),
        title: Container(
          height: 14,
          color: Colors.grey[300],
          margin: const EdgeInsets.symmetric(vertical: 4),
        ),
        subtitle: Container(
          height: 10,
          color: Colors.grey[200],
          margin: const EdgeInsets.symmetric(vertical: 2),
        ),
        trailing: Container(width: 40, height: 10, color: Colors.grey[200]),
      ),
    );
  }
}
