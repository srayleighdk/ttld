import 'package:flutter/material.dart';
import 'package:ttld/widgets/common/custom_app_bar.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  static const routePath = '/error';

  const ErrorPage(
      {super.key, this.errorMessage = 'An unexpected error occurred.'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Lỗi',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 50,
            ),
            const SizedBox(height: 20),
            Text(
              errorMessage,
              style: const TextStyle(fontSize: 18, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back or to a different page
                Navigator.of(context).pop();
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
