import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/nganh_nghe_model.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/form/modern_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class CompanyInfoSection extends StatelessWidget {
  final TextEditingController ntdTenController;
  final TextEditingController ntdTentatController;
  final int? ntdLoai;
  final Function(int?) onNtdLoaiChanged;
  final String? idNganhKinhTe;
  final Function(NganhNgheKT?) onNganhKinhTeChanged;
  final ThemeData theme;

  const CompanyInfoSection({
    Key? key,
    required this.ntdTenController,
    required this.ntdTentatController,
    required this.ntdLoai,
    required this.onNtdLoaiChanged,
    required this.idNganhKinhTe,
    required this.onNganhKinhTeChanged,
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
            label: "Tên nhà tuyển dụng",
            controller: ntdTenController,
            hint: 'Tên nhà tuyển dụng',
          ),
          const SizedBox(height: 16),
          ModernTextField(
            label: "Tên viết tắt",
            controller: ntdTentatController,
            hint: 'Tên viết tắt',
          ),
          const SizedBox(height: 16),
          CustomPickerMap(
            label: const Text("Loại doanh nghiệp"),
            items: loaiDoanhNgiepOptions,
            selectedItem: ntdLoai,
            onChanged: onNtdLoaiChanged,
          ),
          const SizedBox(height: 16),
          ModernPicker<NganhNgheKT>(
            initialValue: idNganhKinhTe,
            items: locator<List<NganhNgheKT>>(),
            onChanged: onNganhKinhTeChanged,
            label: 'Ngành nghề chính',
          ),
        ],
      ),
    );
  }
}