import 'package:flutter/material.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/core/di/injection.dart';

class Step3JobPreferences extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cvMongMuonController;
  final TextEditingController uvnvTienluong;
  final TextEditingController uvcmCongviechientaiController;
  final TextEditingController uvcmKynangController;
  final TextEditingController uvGhichuController;
  final TextEditingController uvnvNoilamviecController;
  final int? uvnvVitrimongmuonId;
  final int? idMucluong;
  final int? uvnvThoigianId;
  final int? uvnvHinhthuccongtyId;
  final Function(ChucDanhModel?) onChucDanhChanged;
  final Function(MucLuongMM?) onMucLuongChanged;
  final Function(ThoiGianLamViec?) onThoiGianLamViecChanged;
  final Function(HinhThucDoanhNghiep?) onHinhThucDoanhNghiepChanged;
  final Function(TinhThanhModel?) onTinhThanhMMChanged;

  const Step3JobPreferences({
    Key? key,
    required this.formKey,
    required this.cvMongMuonController,
    required this.uvnvTienluong,
    required this.uvcmCongviechientaiController,
    required this.uvcmKynangController,
    required this.uvGhichuController,
    required this.uvnvNoilamviecController,
    required this.uvnvVitrimongmuonId,
    required this.idMucluong,
    required this.uvnvThoigianId,
    required this.uvnvHinhthuccongtyId,
    required this.onChucDanhChanged,
    required this.onMucLuongChanged,
    required this.onThoiGianLamViecChanged,
    required this.onHinhThucDoanhNghiepChanged,
    required this.onTinhThanhMMChanged,
  }) : super(key: key);

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(
      ThemeData theme, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader(theme, title),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
        const SizedBox(height: 16),
      ],
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
          _buildFormSection(
            theme,
            'Việc làm mong muốn',
            [
              CustomTextField(
                labelText: 'Việc làm mong muốn',
                hintText: 'Việc làm mong muốn',
                controller: cvMongMuonController,
                validator: 'not_empty',
              ),
              const SizedBox(height: 12),
              GenericPicker<ChucDanhModel>(
                label: 'Chức vụ mong muốn',
                items: locator<List<ChucDanhModel>>(),
                initialValue: uvnvVitrimongmuonId,
                onChanged: onChucDanhChanged,
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thông tin lương',
            [
              GenericPicker<MucLuongMM>(
                label: 'Mức lương mong muốn',
                items: locator<List<MucLuongMM>>(),
                initialValue: idMucluong,
                onChanged: onMucLuongChanged,
              ),
              const SizedBox(height: 12),
              CustomTextField.number(
                allowDecimals: true,
                hintText: 'Lương khởi điểm',
                controller: uvnvTienluong,
                validator: 'not_empty',
                labelText: 'Lương khởi điểm',
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thời gian và hình thức làm việc',
            [
              GenericPicker<ThoiGianLamViec>(
                label: 'Thời gian làm việc mong muốn',
                items: locator<List<ThoiGianLamViec>>(),
                initialValue: uvnvThoigianId,
                onChanged: onThoiGianLamViecChanged,
              ),
              const SizedBox(height: 12),
              GenericPicker<HinhThucDoanhNghiep>(
                label: 'Hình thức công ty mong muốn',
                items: locator<List<HinhThucDoanhNghiep>>(),
                initialValue: uvnvHinhthuccongtyId,
                onChanged: onHinhThucDoanhNghiepChanged,
              ),
              const SizedBox(height: 12),
              GenericPicker<TinhThanhModel>(
                label: 'Thành phố mong muốn',
                items: locator<List<TinhThanhModel>>(),
                initialValue: uvnvNoilamviecController.text,
                onChanged: onTinhThanhMMChanged,
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Kinh nghiệm và kỹ năng',
            [
              CustomTextField.textArea(
                labelText: 'Công việc đã làm',
                hintText: 'Công việc đã làm',
                minLines: 3,
                maxLines: 5,
                controller: uvcmCongviechientaiController,
                validator: 'not_empty',
              ),
              const SizedBox(height: 12),
              CustomTextField.textArea(
                labelText: 'Kỹ năng',
                hintText: 'Kỹ năng',
                minLines: 3,
                maxLines: 5,
                controller: uvcmKynangController,
              ),
              const SizedBox(height: 12),
              CustomTextField.textArea(
                labelText: 'Ghi chú',
                hintText: 'Ghi chú',
                minLines: 3,
                maxLines: 5,
                controller: uvGhichuController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
