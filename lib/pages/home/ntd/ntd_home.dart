import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NTDHomePage extends StatelessWidget {
  const NTDHomePage({super.key});

  static const String routePath = '/ntd_home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NTD Home'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to the NTD Home Page",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Here you can manage NTD-related tasks and access key features.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to NTD-specific task page, like reports, statistics, etc.
                // context.go('/ntd_reports');
              },
              child: const Text('View Reports'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to a QR scan page, transfer page, or other action for NTD
                // context.go('/ntd_transfer');
              },
              child: const Text('NTD Transfer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to a phone top-up page or another NTD-specific action
                // context.go('/phone_top_up');
              },
              child: const Text('Phone Top-Up'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Another action for NTD, like a setting or report page
                // context.go('/ntd_other_action');
              },
              child: const Text('Other NTD Actions'),
            ),
          ],
        ),
      ),
    );
  }
}
