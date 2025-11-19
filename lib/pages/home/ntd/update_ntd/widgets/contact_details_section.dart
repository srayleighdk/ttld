import 'package:flutter/material.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class ContactDetailsSection extends StatelessWidget {
  final TextEditingController ntdWebsiteController;
  final TextEditingController ntdFaxController;
  final TextEditingController ntdDienthoaiController;
  final ThemeData theme;

  const ContactDetailsSection({
    Key? key,
    required this.ntdWebsiteController,
    required this.ntdFaxController,
    required this.ntdDienthoaiController,
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
          CustomTextField(
            labelText: "Website",
            controller: ntdWebsiteController,
            hintText: 'Website',
          ),
          const SizedBox(height: 16),
          CustomTextField(
            labelText: "Fax",
            controller: ntdFaxController,
            hintText: 'Fax',
          ),
          const SizedBox(height: 16),
          CustomTextField.number(
            labelText: "Điện thoại",
            controller: ntdDienthoaiController,
            hintText: 'Điện thoại',
          ),
        ],
      ),
    );
  }
}
