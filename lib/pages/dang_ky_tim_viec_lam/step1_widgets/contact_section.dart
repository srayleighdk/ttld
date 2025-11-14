import 'package:flutter/material.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class ContactSection extends StatelessWidget {
  final TextEditingController dienthoaiController;
  final TextEditingController emailController;
  final TextEditingController nguoiLienHeController;
  final TextEditingController hotenNguoiLienHeController;
  final bool nhanMail;
  final bool sms;
  final Function(bool?) onNhanMailChanged;
  final Function(bool?) onSmsChanged;
  final VoidCallback onUpdate;

  const ContactSection({
    super.key,
    required this.dienthoaiController,
    required this.emailController,
    required this.nguoiLienHeController,
    required this.hotenNguoiLienHeController,
    required this.nhanMail,
    required this.sms,
    required this.onNhanMailChanged,
    required this.onSmsChanged,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row: Điện thoại
        CustomTextField(
          labelText: 'Điện thoại',
          hintText: 'Nhập số điện thoại',
          controller: dienthoaiController,
          keyboardType: TextInputType.phone,
          onChanged: (_) => onUpdate(),
        ),
        const SizedBox(height: 16),

        // Row: Email
        CustomTextField(
          labelText: 'Email',
          hintText: 'Nhập email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => onUpdate(),
        ),
        const SizedBox(height: 16),

        // Row: Checkboxes
        Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: nhanMail,
                  onChanged: onNhanMailChanged,
                ),
                const Text('Nhận mail'),
              ],
            ),
            const SizedBox(width: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: sms,
                  onChanged: onSmsChanged,
                ),
                const Text('SMS'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Row: Người liên hệ
        CustomTextField(
          labelText: 'Người liên hệ',
          hintText: 'Tên người liên hệ',
          controller: nguoiLienHeController,
          onChanged: (_) => onUpdate(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
