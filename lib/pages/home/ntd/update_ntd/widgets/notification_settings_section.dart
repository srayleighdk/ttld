import 'package:flutter/material.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';

class NotificationSettingsSection extends StatelessWidget {
  final bool newletterSubscription;
  final ValueChanged<bool?> onNewletterSubscriptionChanged;
  final bool jobsletterSubscription;
  final ValueChanged<bool?> onJobsletterSubscriptionChanged;
  final ThemeData theme;

  const NotificationSettingsSection({
    Key? key,
    required this.newletterSubscription,
    required this.onNewletterSubscriptionChanged,
    required this.jobsletterSubscription,
    required this.onJobsletterSubscriptionChanged,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCheckbox(
            label: "Đăng ký nhận bản tin",
            value: newletterSubscription,
            onChanged: onNewletterSubscriptionChanged,
          ),
          const SizedBox(height: 12),
          CustomCheckbox(
            label: "Đăng ký nhận bản tin việc làm",
            value: jobsletterSubscription,
            onChanged: onJobsletterSubscriptionChanged,
          ),
        ],
      ),
    );
  }
}