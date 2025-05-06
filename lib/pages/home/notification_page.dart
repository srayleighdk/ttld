import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

// A simple model for notification data
class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final IconData icon;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    this.icon = Icons.notifications,
    this.isRead = false,
  });
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Sample notification data
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: 'New Job Posting',
      subtitle: 'A new job matching your profile has been posted.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      icon: Icons.work,
    ),
    NotificationItem(
      id: '2',
      title: 'Application Viewed',
      subtitle: 'Your application for "Software Engineer" was viewed.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      icon: Icons.visibility,
      isRead: true,
    ),
    NotificationItem(
      id: '3',
      title: 'Message from Recruiter',
      subtitle: 'You have a new message from ABC Corp.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      icon: Icons.message,
    ),
    NotificationItem(
      id: '4',
      title: 'Profile Update Reminder',
      subtitle: 'Keep your profile updated for better matches.',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      icon: Icons.person_pin_circle_outlined,
      isRead: true,
    ),
  ];

  void _markAsRead(String id) {
    setState(() {
      final notification = _notifications.firstWhere((n) => n.id == id);
      notification.isRead = true;
    });
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined,
                      size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No Notifications',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You currently have no new notifications.',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: notification.isRead
                          ? Colors.grey.shade300
                          : Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        notification.icon,
                        color: notification.isRead
                            ? Colors.grey.shade600
                            : Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: Text(
                      notification.title,
                      style: TextStyle(
                        fontWeight: notification.isRead
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(notification.subtitle),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('MMM d, hh:mm a')
                              .format(notification.timestamp),
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[600]),
                        ),
                        if (!notification.isRead)
                          Container(
                            margin: const EdgeInsets.only(top: 4.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      // Handle notification tap, e.g., navigate to details or mark as read
                      _markAsRead(notification.id);
                      // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tapped on ${notification.title}')));
                    },
                    onLongPress: () {
                      // Optional: Show options like delete
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext bc) {
                          return SafeArea(
                            child: Wrap(
                              children: <Widget>[
                                if (!notification.isRead)
                                  ListTile(
                                    leading: const Icon(
                                        Icons.mark_chat_read_outlined),
                                    title: const Text('Mark as read'),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      _markAsRead(notification.id);
                                    },
                                  ),
                                ListTile(
                                  leading: const Icon(Icons.delete_outline),
                                  title: const Text('Delete notification'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    _deleteNotification(notification.id);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
