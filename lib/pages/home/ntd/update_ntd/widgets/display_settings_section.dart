import 'package:flutter/material.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';

class DisplaySettingsSection extends StatelessWidget {
  final bool ntdhtNlh;
  final ValueChanged<bool?> onNtdhtNlhChanged;
  final bool ntdhtTelephone;
  final ValueChanged<bool?> onNtdhtTelephoneChanged;
  final bool ntdhtWeb;
  final ValueChanged<bool?> onNtdhtWebChanged;
  final bool ntdhtFax;
  final ValueChanged<bool?> onNtdhtFaxChanged;
  final bool ntdhtEmail;
  final ValueChanged<bool?> onNtdhtEmailChanged;
  final bool ntdhtAddress;
  final ValueChanged<bool?> onNtdhtAddressChanged;
  final ThemeData theme;

  const DisplaySettingsSection({
    Key? key,
    required this.ntdhtNlh,
    required this.onNtdhtNlhChanged,
    required this.ntdhtTelephone,
    required this.onNtdhtTelephoneChanged,
    required this.ntdhtWeb,
    required this.onNtdhtWebChanged,
    required this.ntdhtFax,
    required this.onNtdhtFaxChanged,
    required this.ntdhtEmail,
    required this.onNtdhtEmailChanged,
    required this.ntdhtAddress,
    required this.onNtdhtAddressChanged,
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
            label: "Người liên hệ",
            value: ntdhtNlh,
            onChanged: onNtdhtNlhChanged,
          ),
          CustomCheckbox(
            label: "Số điện thoại",
            value: ntdhtTelephone,
            onChanged: onNtdhtTelephoneChanged,
          ),
          CustomCheckbox(
            label: "Website",
            value: ntdhtWeb,
            onChanged: onNtdhtWebChanged,
          ),
          CustomCheckbox(
            label: "Fax",
            value: ntdhtFax,
            onChanged: onNtdhtFaxChanged,
          ),
          CustomCheckbox(
            label: "Email",
            value: ntdhtEmail,
            onChanged: onNtdhtEmailChanged,
          ),
          CustomCheckbox(
            label: "Địa chỉ",
            value: ntdhtAddress,
            onChanged: onNtdhtAddressChanged,
          ),
        ],
      ),
    );
  }
}