import 'package:flutter/material.dart';

class Step4Confirmation extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String hoten;
  final String email;
  final Function() onSubmit;

  const Step4Confirmation({
    Key? key,
    required this.formKey,
    required this.hoten,
    required this.email,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Display summary of entered information
          Text('Họ tên: $hoten'),
          Text('Email: $email'),
          // Add other summary fields as needed
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text('Xác nhận và Lưu'),
          ),
        ],
      ),
    );
  }
}
