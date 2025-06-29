import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/models/loai_hinh_model.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class CompanyTypeSection extends StatelessWidget {
  final int? ntdHinhthucdoanhnghiep;
  final Function(HinhThucDoanhNghiep?) onHinhThucDoanhNghiepChanged;
  final String? idLoaiHinhDoanhNghiep;
  final Function(LoaiHinh?) onLoaiHinhChanged;
  final ThemeData theme;

  const CompanyTypeSection({
    Key? key,
    required this.ntdHinhthucdoanhnghiep,
    required this.onHinhThucDoanhNghiepChanged,
    required this.idLoaiHinhDoanhNghiep,
    required this.onLoaiHinhChanged,
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
          GenericPicker<HinhThucDoanhNghiep>(
            label: "Hình thức doanh nghiệp",
            items: locator<List<HinhThucDoanhNghiep>>(),
            initialValue: ntdHinhthucdoanhnghiep,
            onChanged: onHinhThucDoanhNghiepChanged,
          ),
          const SizedBox(height: 16),
          GenericPicker<LoaiHinh>(
            label: "Loại hình doanh nghiệp",
            items: locator<List<LoaiHinh>>(),
            initialValue: idLoaiHinhDoanhNghiep,
            onChanged: onLoaiHinhChanged,
          ),
        ],
      ),
    );
  }
}