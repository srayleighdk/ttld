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
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
      body: Container(
        color: Colors.amber, // A bright color to make it obvious
        child: const Center(
          child: Text(
            'Test Content',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
