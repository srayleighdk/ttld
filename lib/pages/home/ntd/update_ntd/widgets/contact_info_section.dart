import 'package:flutter/material.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/widgets/form/modern_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/core/di/injection.dart';

class ContactInfoSection extends StatelessWidget {
  final TextEditingController ntdNguoilienheController;
  final int? ntdChucvu;
  final Function(ChucDanhModel?) onChucDanhChanged;
  final ThemeData theme;

  const ContactInfoSection({
    Key? key,
    required this.ntdNguoilienheController,
    required this.ntdChucvu,
    required this.onChucDanhChanged,
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
          ModernTextField(
            label: "Tên người liên hệ",
            controller: ntdNguoilienheController,
            hint: 'Tên người liên hệ',
          ),
          const SizedBox(height: 16),
          GenericPicker<ChucDanhModel>(
            label: "Chức vụ người liên hệ",
            items: locator<List<ChucDanhModel>>(),
            initialValue: ntdChucvu,
            onChanged: onChucDanhChanged,
          ),
        ],
      ),
    );
  }
}