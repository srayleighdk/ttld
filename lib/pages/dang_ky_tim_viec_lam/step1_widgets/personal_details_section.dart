import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/tttantat/tttantat.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class PersonalDetailsSection extends StatelessWidget {
  final TextEditingController masoBhxhController;
  final TextEditingController mahoGdController;
  final TextEditingController mahoGiaDinhController;
  final TextEditingController suckhoeController;
  final TextEditingController caoController;
  final TextEditingController nangController;
  final TextEditingController congViecHienTaiController;
  final bool? idTtHonNhan;
  final int? idTantat;
  final Function(bool?) onHonNhanChanged;
  final Function(int?) onTantatChanged;
  final VoidCallback onUpdate;

  const PersonalDetailsSection({
    super.key,
    required this.masoBhxhController,
    required this.mahoGdController,
    required this.mahoGiaDinhController,
    required this.suckhoeController,
    required this.caoController,
    required this.nangController,
    required this.congViecHienTaiController,
    required this.idTtHonNhan,
    required this.idTantat,
    required this.onHonNhanChanged,
    required this.onTantatChanged,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row: TT hôn nhân
        CustomPickerMap(
          label: const Text('TT hôn nhân'),
          items: const {
            true: 'Độc thân',
            false: 'Đã kết hôn',
          },
          selectedItem: idTtHonNhan,
          onChanged: onHonNhanChanged,
        ),
        const SizedBox(height: 16),

        // Row: TT tôn tật
        GenericPicker<TtTantat>(
          label: 'TT tàn tật',
          hintText: 'Chọn',
          items: locator<List<TtTantat>>(),
          initialValue: idTantat,
          onChanged: (value) => onTantatChanged(value?.id is int
              ? value?.id
              : int.tryParse(value?.id?.toString() ?? '')),
        ),
        const SizedBox(height: 16),

        // Row: Mã số BHXH
        CustomTextField(
          labelText: 'Mã sổ BHXH',
          hintText: 'Nhập mã BHXH',
          controller: masoBhxhController,
          onChanged: (_) => onUpdate(),
        ),
        const SizedBox(height: 16),

        // Row: Mã HGĐ
        CustomTextField(
          labelText: 'Mã HGĐ',
          hintText: 'Nhập mã HGĐ',
          controller: mahoGdController,
          onChanged: (_) => onUpdate(),
        ),
        const SizedBox(height: 16),

        // Row: Sức khỏe
        CustomTextField(
          labelText: 'Sức khỏe',
          hintText: 'Tình trạng sức khỏe',
          controller: suckhoeController,
          onChanged: (_) => onUpdate(),
        ),
        const SizedBox(height: 16),

        // Row: Chiều cao
        CustomTextField(
          labelText: 'Chiều cao',
          hintText: 'cm',
          controller: caoController,
          keyboardType: TextInputType.number,
          onChanged: (_) => onUpdate(),
        ),
        const SizedBox(height: 16),

        // Row: Cân nặng
        CustomTextField(
          labelText: 'Cân nặng',
          hintText: 'kg',
          controller: nangController,
          keyboardType: TextInputType.number,
          onChanged: (_) => onUpdate(),
        ),
        const SizedBox(height: 16),

        // Row: Việc làm hiện tại
        CustomTextField(
          labelText: 'Việc làm hiện tại',
          hintText: 'Mô tả công việc hiện tại',
          controller: congViecHienTaiController,
          maxLines: 3,
          onChanged: (_) => onUpdate(),
        ),
      ],
    );
  }
}
