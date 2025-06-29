import 'package:flutter/material.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';

class StatusAndActivitySection extends StatelessWidget {
  final int? idStatus;
  final Function(int?) onStatusChanged;
  final int? idThoiGianHoatDong;
  final Function(int?) onThoiGianHoatDongChanged;
  final ThemeData theme;

  const StatusAndActivitySection({
    Key? key,
    required this.idStatus,
    required this.onStatusChanged,
    required this.idThoiGianHoatDong,
    required this.onThoiGianHoatDongChanged,
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
          CustomPickerMap<int>(
            label: const Text("Trạng thái"),
            items: statusOptions,
            selectedItem: idStatus,
            onChanged: onStatusChanged,
            hint: 'Chọn trạng thái',
          ),
          const SizedBox(height: 16),
          CustomPickerMap<int>(
            label: const Text("Thời gian hoạt động"),
            items: thoiGianHoatDongOptions,
            selectedItem: idThoiGianHoatDong,
            onChanged: onThoiGianHoatDongChanged,
            hint: 'Chọn thời gian hoạt động',
          ),
        ],
      ),
    );
  }
}