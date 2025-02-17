import 'package:flutter/material.dart';
import 'package:ttld/widgets/custom_user_profile.dart';

class NTVHomePage extends StatelessWidget {
  const NTVHomePage({super.key});

  static const String routePath = '/ntv_home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NTV Home'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => GoRouter.of(context).pop(),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomUserProfile(
            //   userName: 'John Doe',
            //   avatarUrl: 'https://example.com/avatar.jpg',
            //   email: 'test@test.com',
            // ),
            ProfileSection(),
            const SizedBox(height: 20),
            const Text(
              "Here you can manage your account, check balance, and perform other actions.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to a relevant page, for example: Account details or balance page
                // context.go('/account_balance');
              },
              child: const Text('View Account Balance'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to another action, such as transferring funds or scanning a QR code
                // context.go('/qr_scan');
              },
              child: const Text('Scan QR Code'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to a different section
                // context.go('/phone_top_up');
              },
              child: const Text('Phone Top-Up'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to another page or perform an action
                // context.go('/another_page');
              },
              child: const Text('Other Action'),
            ),
          ],
        ),
      ),
    );
  }
}
