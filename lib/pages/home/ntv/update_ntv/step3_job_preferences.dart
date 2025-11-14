import 'package:flutter/material.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/core/di/injection.dart';

class Step3JobPreferences extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  // Text field controllers
  final TextEditingController congViecMMController;
  final TextEditingController noiLamViecMMController;
  final TextEditingController congViecDaLamController;
  final TextEditingController khaNangSoTruongController;

  // Dropdown IDs
  final int? viTriMMId;
  final int? mucLuongId;
  final int? thoiGianLamViecMMId;
  final int? hinhThucCtyMMId;

  // Callbacks
  final Function(ChucDanhModel?) onViTriMMChanged;
  final Function(MucLuongMM?) onMucLuongChanged;
  final Function(ThoiGianLamViec?) onThoiGianLamViecChanged;
  final Function(HinhThucDoanhNghiep?) onHinhThucCtyMMChanged;

  const Step3JobPreferences({
    Key? key,
    required this.formKey,
    required this.congViecMMController,
    required this.noiLamViecMMController,
    required this.congViecDaLamController,
    required this.khaNangSoTruongController,
    required this.viTriMMId,
    required this.mucLuongId,
    required this.thoiGianLamViecMMId,
    required this.hinhThucCtyMMId,
    required this.onViTriMMChanged,
    required this.onMucLuongChanged,
    required this.onThoiGianLamViecChanged,
    required this.onHinhThucCtyMMChanged,
  }) : super(key: key);

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader(theme, 'NHU CẦU CÔNG VIỆC, VỊ TRÍ VIỆC LÀM MONG MUỐN (MONG MUỐN = MM)'),
          const SizedBox(height: 16),

          // Row 1: Công việc MM (full width)
          CustomTextField(
            labelText: 'Công việc MM',
            hintText: 'Cong nghe thong tin',
            controller: congViecMMController,
          ),
          const SizedBox(height: 12),

          // Row 2: Vị trí MM | Mức lương
          Row(
            children: [
              Expanded(
                child: GenericPicker<ChucDanhModel>(
                  label: 'Vị trí MM',
                  hintText: 'Chọn vị trí',
                  items: locator<List<ChucDanhModel>>(),
                  initialValue: viTriMMId,
                  onChanged: onViTriMMChanged,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GenericPicker<MucLuongMM>(
                  label: 'Mức lương',
                  hintText: 'Thỏa thuận',
                  items: locator<List<MucLuongMM>>(),
                  initialValue: mucLuongId,
                  onChanged: onMucLuongChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row 3: Thời gian làm việc MM | Hình thức Cty MM
          Row(
            children: [
              Expanded(
                child: GenericPicker<ThoiGianLamViec>(
                  label: 'Thời gian làm việc MM',
                  hintText: 'Chọn thời gian làm việc',
                  items: locator<List<ThoiGianLamViec>>(),
                  initialValue: thoiGianLamViecMMId,
                  onChanged: onThoiGianLamViecChanged,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GenericPicker<HinhThucDoanhNghiep>(
                  label: 'Hình thức Cty MM',
                  hintText: 'Chọn hình thức công ty',
                  items: locator<List<HinhThucDoanhNghiep>>(),
                  initialValue: hinhThucCtyMMId,
                  onChanged: onHinhThucCtyMMChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row 4: Nơi làm việc MM (full width)
          CustomTextField(
            labelText: 'Nơi làm việc MM',
            hintText: 'Nhập nơi làm việc mong muốn',
            controller: noiLamViecMMController,
          ),
          const SizedBox(height: 12),

          // Row 5: Công việc đã làm (multiline)
          CustomTextField(
            labelText: 'Công việc đã làm',
            hintText: 'công việc hiện tại đang làm hoặc đã từng làm ở công ty khác, Công ty đã từng công tác...',
            controller: congViecDaLamController,
            maxLines: 4,
            minLines: 3,
          ),
          const SizedBox(height: 12),

          // Row 6: Khả năng, sở trường (multiline)
          CustomTextField(
            labelText: 'Khả năng, sở trường',
            hintText: 'kỹ năng mềm, kỹ năng giao tiếp, kỹ năng phân tích...',
            controller: khaNangSoTruongController,
            maxLines: 4,
            minLines: 3,
          ),
        ],
      ),
    );
  }
}
