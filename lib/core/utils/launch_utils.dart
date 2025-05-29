import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Attempts to launch a phone call for the given [phoneNumber].
/// Shows a SnackBar if the call cannot be launched.
Future<void> launchPhoneCall(BuildContext context, String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    // Optionally show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Không thể gửi yêu cầu'),
      ),
    );
  }
}
