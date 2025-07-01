import 'package:flutter/material.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class AccountInfoSection extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController ntdMadnController;
  final TextEditingController ntdEmailController;
  final TextEditingController mstController;
  final ThemeData theme;

  const AccountInfoSection({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.ntdMadnController,
    required this.ntdEmailController,
    required this.mstController,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField.email(
            controller: ntdEmailController,
          ),
          const SizedBox(height: 8),
          CustomTextField(
            labelText: "Username",
            controller: usernameController,
            hintText: 'Username',
            readOnly: true,
          ),
          const SizedBox(height: 8),
          CustomTextField(
            labelText: "Mã số thuế",
            controller: mstController,
            hintText: 'Mã số thuế',
          ),
          // const SizedBox(height: 8),
          // CustomTextField.password(
          //   controller: passwordController,
          // ),
          const SizedBox(height: 8),
          CustomTextField(
            labelText: "Mã NTD",
            controller: ntdMadnController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter NTD Madn';
              }
              return null;
            },
            hintText: 'Mã NTD',
          ),
        ],
      ),
    );
  }
}
