import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/dan_toc_model.dart';
import 'package:ttld/models/ton_giao_model.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/models/status_vieclam_model.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/helppers/map_help.dart';

class BasicInfoSection extends StatelessWidget {
  final TextEditingController iduvController;
  final TextEditingController hotenController;
  final TextEditingController soCmndController;
  final TextEditingController ngaycapController;
  final TextEditingController noicapController;
  final TextEditingController ngaysinhController;
  final int? selectedGioitinh;
  final int? selectedDantoc;
  final int? selectedTongiao;
  final int? selectedDoituong;
  final int? selectedStatusVieclam;
  final bool xacnhan;
  final Function(int?) onGioitinhChanged;
  final Function(int?) onDantocChanged;
  final Function(int?) onTongiaoChanged;
  final Function(int?) onDoituongChanged;
  final Function(int?) onStatusVieclamChanged;
  final Function(bool?) onXacnhanChanged;
  final VoidCallback onNgaysinhTap;
  final VoidCallback onNgaycapTap;
  final VoidCallback onUpdate;

  const BasicInfoSection({
    super.key,
    required this.iduvController,
    required this.hotenController,
    required this.soCmndController,
    required this.ngaycapController,
    required this.noicapController,
    required this.ngaysinhController,
    required this.selectedGioitinh,
    required this.selectedDantoc,
    required this.selectedTongiao,
    required this.selectedDoituong,
    required this.selectedStatusVieclam,
    required this.xacnhan,
    required this.onGioitinhChanged,
    required this.onDantocChanged,
    required this.onTongiaoChanged,
    required this.onDoituongChanged,
    required this.onStatusVieclamChanged,
    required this.onXacnhanChanged,
    required this.onNgaysinhTap,
    required this.onNgaycapTap,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: Id ứng viên | Họ và tên | Xác nhận
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomTextField(
                labelText: 'Họ và tên',
                hintText: 'Nhập họ và tên đầy đủ',
                controller: hotenController,
                onChanged: (_) => onUpdate(),
              ),
            ),
            // const SizedBox(width: 12),
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Checkbox(
            //       value: xacnhan,
            //       onChanged: onXacnhanChanged,
            //     ),
            //     const Text('Xác nhận'),
            //   ],
            // ),
          ],
        ),
        const SizedBox(height: 16),

        // Row: Số CCCD
        CustomTextField(
          labelText: 'Số CCCD',
          hintText: 'Nhập số CCCD',
          controller: soCmndController,
          keyboardType: TextInputType.number,
          onChanged: (_) => onUpdate(),
        ),
        const SizedBox(height: 16),

        // Row: Ngày cấp
        GestureDetector(
          onTap: onNgaycapTap,
          child: AbsorbPointer(
            child: CustomTextField(
              labelText: 'Ngày cấp',
              hintText: 'Chọn ngày cấp',
              controller: ngaycapController,
              readOnly: true,
              onChanged: (_) => onUpdate(),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Row: Nơi cấp
        CustomTextField(
          labelText: 'Nơi cấp',
          hintText: 'Nhập nơi cấp',
          controller: noicapController,
          onChanged: (_) => onUpdate(),
        ),
        const SizedBox(height: 16),

        // Row: Ngày sinh
        GestureDetector(
          onTap: onNgaysinhTap,
          child: AbsorbPointer(
            child: CustomTextField(
              labelText: 'Ngày sinh',
              hintText: 'Chọn ngày sinh',
              controller: ngaysinhController,
              readOnly: true,
              onChanged: (_) => onUpdate(),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Row: Giới tính
        CustomPickerMap(
          label: const Text('Giới tính'),
          items: gioiTinhOptions,
          selectedItem: selectedGioitinh,
          onChanged: onGioitinhChanged,
        ),
        const SizedBox(height: 16),

        // Row: Dân tộc
        GenericPicker<DanToc>(
          label: 'Dân tộc',
          hintText: 'Chọn dân tộc',
          items: locator<List<DanToc>>(),
          initialValue: selectedDantoc,
          onChanged: (value) => onDantocChanged(value?.id is int
              ? value?.id
              : int.tryParse(value?.id?.toString() ?? '')),
        ),
        const SizedBox(height: 16),

        // Row: Tôn giáo
        GenericPicker<TonGiao>(
          label: 'Tôn giáo',
          hintText: 'Chọn tôn giáo',
          items: locator<List<TonGiao>>(),
          initialValue: selectedTongiao,
          onChanged: (value) => onTongiaoChanged(value?.id is int
              ? value?.id
              : int.tryParse(value?.id?.toString() ?? '')),
        ),
        const SizedBox(height: 16),

        // Row: Đối tượng
        GenericPicker<DoiTuong>(
          label: 'Đối tượng',
          hintText: 'Chưa xác định',
          items: locator<List<DoiTuong>>(),
          initialValue: selectedDoituong,
          onChanged: (value) => onDoituongChanged(value?.id is int
              ? value?.id
              : int.tryParse(value?.id?.toString() ?? '')),
        ),
        const SizedBox(height: 16),

        // Row: TT Việc làm
        GenericPicker<StatusViecLam>(
          label: 'TT Việc làm',
          hintText: 'Chọn trạng thái việc làm',
          items: locator<List<StatusViecLam>>(),
          initialValue: selectedStatusVieclam,
          onChanged: (value) => onStatusVieclamChanged(value?.id is int
              ? value?.id
              : int.tryParse(value?.id?.toString() ?? '')),
        ),
      ],
    );
  }
}
