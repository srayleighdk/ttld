import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';

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

          DropdownButtonFormField<int>(
            value: _selectedTrinhdohocvan,
            decoration: InputDecoration(
              labelText: 'Trình độ học vấn *',
              prefixIcon: const Icon(FontAwesomeIcons.graduationCap, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 1, child: Text('12/12')),
              DropdownMenuItem(value: 2, child: Text('10/12')),
              DropdownMenuItem(value: 3, child: Text('9/12')),
              DropdownMenuItem(value: 4, child: Text('Trung cấp')),
              DropdownMenuItem(value: 5, child: Text('Cao đẳng')),
              DropdownMenuItem(value: 6, child: Text('Đại học')),
              DropdownMenuItem(value: 7, child: Text('Sau đại học')),
            ],
            validator: (value) {
              if (value == null) {
                return 'Vui lòng chọn trình độ học vấn';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedTrinhdohocvan = value;
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          // Bậc đào tạo
          TextFormField(
            controller: _bacdaotaoController,
            decoration: InputDecoration(
              labelText: 'Bậc đào tạo',
              hintText: 'VD: Kỹ sư, Cử nhân...',
              prefixIcon: const Icon(FontAwesomeIcons.certificate, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
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

          TextFormField(
            controller: _chuyenmonController,
            decoration: InputDecoration(
              labelText: 'Chuyên môn hiện tại *',
              hintText: 'VD: Kỹ thuật điện, Cơ khí...',
              prefixIcon: const Icon(FontAwesomeIcons.briefcase, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập chuyên môn';
              }
              return null;
            },
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

          DropdownButtonFormField<int>(
            value: _selectedNgoaingudaotao,
            decoration: InputDecoration(
              labelText: 'Ngoại ngữ đã được đào tạo *',
              prefixIcon: const Icon(FontAwesomeIcons.language, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 1, child: Text('Tiếng Anh')),
              DropdownMenuItem(value: 2, child: Text('Tiếng Nhật')),
              DropdownMenuItem(value: 3, child: Text('Tiếng Hàn')),
              DropdownMenuItem(value: 4, child: Text('Tiếng Trung')),
              DropdownMenuItem(value: 5, child: Text('Tiếng Đức')),
              DropdownMenuItem(value: 6, child: Text('Không')),
              DropdownMenuItem(value: 7, child: Text('Khác')),
            ],
            validator: (value) {
              if (value == null) {
                return 'Vui lòng chọn ngoại ngữ';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedNgoaingudaotao = value;
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _nndaduocdaotaoController,
            decoration: InputDecoration(
              labelText: 'Trình độ ngoại ngữ',
              hintText: 'VD: N3, TOPIK 3, IELTS 6.0...',
              prefixIcon: const Icon(FontAwesomeIcons.award, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
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

          TextFormField(
            controller: _dangdoanController,
            decoration: InputDecoration(
              labelText: 'Đảng, đoàn thể',
              hintText: 'VD: Đoàn viên, Đảng viên...',
              prefixIcon: const Icon(FontAwesomeIcons.flag, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.lightbulb,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lưu ý quan trọng',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Trình độ ngoại ngữ tốt sẽ tăng cơ hội được tuyển dụng. Nhiều quốc gia yêu cầu trình độ ngoại ngữ tối thiểu (VD: Nhật Bản yêu cầu N4, Hàn Quốc yêu cầu TOPIK 2).',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
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
