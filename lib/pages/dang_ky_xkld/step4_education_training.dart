import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/models/ngoai_ngu_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/core/di/injection.dart';

class XKLDStep4EducationTraining extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final HosoXKLDModel formData;
  final Function(HosoXKLDModel) onDataChanged;

  const XKLDStep4EducationTraining({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _XKLDStep4EducationTrainingState createState() =>
      _XKLDStep4EducationTrainingState();
}

class _XKLDStep4EducationTrainingState
    extends State<XKLDStep4EducationTraining> {
  late TextEditingController _chuyenmonController;
  late TextEditingController _bacdaotaoController;
  late TextEditingController _dangdoanController;
  late TextEditingController _nndaduocdaotaoController;

  int? _selectedTrinhdohocvan;
  int? _selectedNgoaingudaotao;

  @override
  void initState() {
    super.initState();
    _chuyenmonController =
        TextEditingController(text: widget.formData.dkxkldChuyenmon);
    _bacdaotaoController =
        TextEditingController(text: widget.formData.dkxkldBacdaotao);
    _dangdoanController =
        TextEditingController(text: widget.formData.dkxkldDangdoan);
    _nndaduocdaotaoController =
        TextEditingController(text: widget.formData.dkxkldNndaduocdaotao);

    _selectedTrinhdohocvan = widget.formData.dkxklddmTrinhdohocvan;
    _selectedNgoaingudaotao = widget.formData.dkxklddmNgoaingudaotao;
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      dkxkldChuyenmon: _chuyenmonController.text,
      dkxkldBacdaotao: _bacdaotaoController.text,
      dkxkldDangdoan: _dangdoanController.text,
      dkxkldNndaduocdaotao: _nndaduocdaotaoController.text,
      dkxklddmTrinhdohocvan: _selectedTrinhdohocvan,
      dkxklddmNgoaingudaotao: _selectedNgoaingudaotao,
    );
    widget.onDataChanged(updatedData);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Học vấn & Đào tạo',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thông tin về trình độ học vấn và đào tạo của bạn',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Trình độ học vấn
          Text(
            'Trình độ học vấn',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          GenericPicker<TrinhDoHocVan>(
            label: 'Trình độ học vấn *',
            hintText: 'Chọn trình độ học vấn',
            items: locator<List<TrinhDoHocVan>>(),
            initialValue: _selectedTrinhdohocvan,
            onChanged: (value) {
              setState(() {
                _selectedTrinhdohocvan = value?.id is int
                    ? value?.id
                    : int.tryParse(value?.id?.toString() ?? '');
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          // Bậc đào tạo
          CustomTextField(
            controller: _bacdaotaoController,
            labelText: 'Bậc đào tạo',
            hintText: 'VD: Kỹ sư, Cử nhân...',
            prefixIcon: const Icon(FontAwesomeIcons.certificate, size: 18),
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Chuyên môn
          Text(
            'Chuyên môn & Kỹ năng',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            controller: _chuyenmonController,
            labelText: 'Chuyên môn hiện tại *',
            hintText: 'VD: Kỹ thuật điện, Cơ khí...',
            prefixIcon: const Icon(FontAwesomeIcons.briefcase, size: 18),
            maxLines: 2,
            validator: 'not_empty',
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Ngoại ngữ
          Text(
            'Ngoại ngữ',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          GenericPicker<NgoaiNgu>(
            label: 'Ngoại ngữ đã được đào tạo *',
            hintText: 'Chọn ngoại ngữ',
            items: locator<List<NgoaiNgu>>(),
            initialValue: _selectedNgoaingudaotao,
            onChanged: (value) {
              setState(() {
                _selectedNgoaingudaotao = value?.id is int
                    ? value?.id
                    : int.tryParse(value?.id?.toString() ?? '');
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          CustomTextField(
            controller: _nndaduocdaotaoController,
            labelText: 'Trình độ ngoại ngữ',
            hintText: 'VD: N3, TOPIK 3, IELTS 6.0...',
            prefixIcon: const Icon(FontAwesomeIcons.award, size: 18),
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Đảng đoàn
          Text(
            'Thông tin khác',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            controller: _dangdoanController,
            labelText: 'Đảng, đoàn thể',
            hintText: 'VD: Đoàn viên, Đảng viên...',
            prefixIcon: const Icon(FontAwesomeIcons.flag, size: 18),
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Info card
        ],
      ),
    );
  }

  @override
  void dispose() {
    _chuyenmonController.dispose();
    _bacdaotaoController.dispose();
    _dangdoanController.dispose();
    _nndaduocdaotaoController.dispose();
    super.dispose();
  }
}
