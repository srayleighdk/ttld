import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/widgets/reuseable_widgets/multi_select_dropdown.dart';

class Step2DisplaySettings extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  // Education fields
  final int? trinhDoHocVanId;
  final int? nganhNgheId;
  final dynamic trinhDoDaoTaoId; // Can be int or string from API
  final TextEditingController kinhNghiemController;
  final TextEditingController bangCapKhacController;
  final TextEditingController trinhDoNgoaiNguController;
  final TextEditingController trinhDoTinHocController;

  // Callbacks
  final Function(TrinhDoHocVan?) onTrinhDoHocVanChanged;
  final Function(NganhNgheTD?) onNganhNgheChanged;
  final Function(TrinhDoChuyenMon?) onTrinhDoDaoTaoChanged;

  const Step2DisplaySettings({
    Key? key,
    required this.formKey,
    required this.trinhDoHocVanId,
    required this.nganhNgheId,
    required this.trinhDoDaoTaoId,
    required this.kinhNghiemController,
    required this.bangCapKhacController,
    required this.trinhDoNgoaiNguController,
    required this.trinhDoTinHocController,
    required this.onTrinhDoHocVanChanged,
    required this.onNganhNgheChanged,
    required this.onTrinhDoDaoTaoChanged,
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
          _buildSectionHeader(theme, 'TRÌNH ĐỘ CHUYÊN MÔN'),
          const SizedBox(height: 16),

          // Row 1: Trình độ học vấn cao nhất | Ngành nghề
          Row(
            children: [
              Expanded(
                child: GenericPicker<TrinhDoHocVan>(
                  label: 'Trình độ học vấn cao nhất (*)',
                  hintText: 'Chọn trình độ học vấn',
                  items: locator<List<TrinhDoHocVan>>(),
                  initialValue: trinhDoHocVanId,
                  onChanged: onTrinhDoHocVanChanged,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GenericPicker<NganhNgheTD>(
                  label: 'Ngành nghề',
                  hintText: 'Chọn ngành nghề',
                  items: locator<List<NganhNgheTD>>(),
                  initialValue: nganhNgheId,
                  onChanged: onNganhNgheChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row 2: Trình độ ngoại ngữ | Tin học/Kỹ thuật viên tin học
          Row(
            children: [
              Expanded(
                child: MultiSelectDropdown<TrinhDoNgoaiNgu>(
                  labelText: 'Trình độ ngoại ngữ',
                  hintText: 'Chọn trình độ ngoại ngữ',
                  items: locator<List<TrinhDoNgoaiNgu>>(),
                  controller: trinhDoNgoaiNguController,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MultiSelectDropdown<TrinhDoTinHoc>(
                  labelText: 'Tin học/Kỹ thuật viên tin học',
                  hintText: 'Chọn trình độ tin học',
                  items: locator<List<TrinhDoTinHoc>>(),
                  controller: trinhDoTinHocController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row 3: Trình độ đào tạo | Kinh nghiệm
          Row(
            children: [
              Expanded(
                child: GenericPicker<TrinhDoChuyenMon>(
                  label: 'Trình độ đào tạo',
                  hintText: 'Chọn trình độ đào tạo',
                  items: locator<List<TrinhDoChuyenMon>>(),
                  initialValue: trinhDoDaoTaoId,
                  onChanged: onTrinhDoDaoTaoChanged,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  labelText: 'Kinh nghiệm',
                  hintText: '0',
                  controller: kinhNghiemController,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12, top: 12),
                    child: Text(
                      '(tháng)',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row 4: Bằng cấp khác
          CustomTextField(
            labelText: 'Bằng cấp khác',
            hintText: 'Nhập bằng cấp khác',
            controller: bangCapKhacController,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
