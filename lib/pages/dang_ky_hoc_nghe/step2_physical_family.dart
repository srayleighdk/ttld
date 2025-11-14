import 'package:flutter/material.dart';
import 'package:ttld/models/hoso_dtn/hoso_dtn_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class VTStep2PhysicalFamily extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final HosoDTN formData;
  final Function(HosoDTN) onDataChanged;

  const VTStep2PhysicalFamily({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _VTStep2PhysicalFamilyState createState() => _VTStep2PhysicalFamilyState();
}

class _VTStep2PhysicalFamilyState extends State<VTStep2PhysicalFamily> {
  late TextEditingController _chieuCaoController;
  late TextEditingController _canNangController;
  late TextEditingController _matTraiController;
  late TextEditingController _matPhaiController;
  late TextEditingController _muMauController;
  late TextEditingController _hoTenChaController;
  late TextEditingController _hoTenMeController;
  late TextEditingController _soConController;
  late TextEditingController _daLamViecNuocNgoaiController;

  bool _docThan = false;
  bool _daCoGiaDinh = false;
  bool _daLyDi = false;
  bool _coBhtn = false;

  @override
  void initState() {
    super.initState();
    _chieuCaoController =
        TextEditingController(text: widget.formData.chieuCao);
    _canNangController = TextEditingController(text: widget.formData.canNang);
    _matTraiController = TextEditingController(text: widget.formData.matTrai);
    _matPhaiController = TextEditingController(text: widget.formData.matPhai);
    _muMauController = TextEditingController(text: widget.formData.muMau);
    _hoTenChaController =
        TextEditingController(text: widget.formData.hoTenCha);
    _hoTenMeController = TextEditingController(text: widget.formData.hoTenMe);
    _soConController =
        TextEditingController(text: widget.formData.soCon?.toString() ?? '');
    _daLamViecNuocNgoaiController =
        TextEditingController(text: widget.formData.daLamViecONuocNgoai);

    _docThan = widget.formData.docThan ?? false;
    _daCoGiaDinh = widget.formData.daCoGiaDinh ?? false;
    _daLyDi = widget.formData.daLyDi ?? false;
    _coBhtn = widget.formData.coBhtn ?? false;
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      chieuCao: _chieuCaoController.text,
      canNang: _canNangController.text,
      matTrai: _matTraiController.text,
      matPhai: _matPhaiController.text,
      muMau: _muMauController.text,
      hoTenCha: _hoTenChaController.text,
      hoTenMe: _hoTenMeController.text,
      soCon: _soConController.text.isNotEmpty
          ? int.tryParse(_soConController.text)
          : null,
      daLamViecONuocNgoai: _daLamViecNuocNgoaiController.text,
      docThan: _docThan,
      daCoGiaDinh: _daCoGiaDinh,
      daLyDi: _daLyDi,
      coBhtn: _coBhtn,
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
            'Thông tin sức khỏe & gia đình',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thông tin về sức khỏe, thể chất và gia đình của bạn',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Thông tin sức khỏe
          Text(
            'Thông tin sức khỏe',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  labelText: 'Chiều cao (cm)',
                  hintText: 'VD: 170',
                  controller: _chieuCaoController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _updateFormData(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  labelText: 'Cân nặng (kg)',
                  hintText: 'VD: 65',
                  controller: _canNangController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _updateFormData(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  labelText: 'Thị lực mắt trái',
                  hintText: 'VD: 10/10',
                  controller: _matTraiController,
                  onChanged: (_) => _updateFormData(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  labelText: 'Thị lực mắt phải',
                  hintText: 'VD: 10/10',
                  controller: _matPhaiController,
                  onChanged: (_) => _updateFormData(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          CustomTextField(
            labelText: 'Mù màu',
            hintText: 'VD: Không, Đỏ-Xanh...',
            controller: _muMauController,
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          CheckboxListTile(
            title: const Text('Có BHTN (Bảo hiểm thất nghiệp)'),
            value: _coBhtn,
            onChanged: (value) {
              setState(() {
                _coBhtn = value ?? false;
                _updateFormData();
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Thông tin gia đình
          Text(
            'Thông tin gia đình',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            labelText: 'Họ tên cha',
            hintText: 'Nhập họ tên cha',
            controller: _hoTenChaController,
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            labelText: 'Họ tên mẹ',
            hintText: 'Nhập họ tên mẹ',
            controller: _hoTenMeController,
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Tình trạng hôn nhân
          Text(
            'Tình trạng hôn nhân',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilterChip(
                label: const Text('Độc thân'),
                selected: _docThan,
                onSelected: (value) {
                  setState(() {
                    _docThan = value;
                    if (value) {
                      _daCoGiaDinh = false;
                      _daLyDi = false;
                    }
                    _updateFormData();
                  });
                },
                selectedColor: theme.colorScheme.primaryContainer,
                checkmarkColor: theme.colorScheme.primary,
              ),
              FilterChip(
                label: const Text('Đã có gia đình'),
                selected: _daCoGiaDinh,
                onSelected: (value) {
                  setState(() {
                    _daCoGiaDinh = value;
                    if (value) {
                      _docThan = false;
                      _daLyDi = false;
                    }
                    _updateFormData();
                  });
                },
                selectedColor: theme.colorScheme.primaryContainer,
                checkmarkColor: theme.colorScheme.primary,
              ),
              FilterChip(
                label: const Text('Ly dị'),
                selected: _daLyDi,
                onSelected: (value) {
                  setState(() {
                    _daLyDi = value;
                    if (value) {
                      _docThan = false;
                      _daCoGiaDinh = false;
                    }
                    _updateFormData();
                  });
                },
                selectedColor: theme.colorScheme.primaryContainer,
                checkmarkColor: theme.colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_daCoGiaDinh || _daLyDi)
            CustomTextField(
              labelText: 'Số con',
              hintText: 'Nhập số con',
              controller: _soConController,
              keyboardType: TextInputType.number,
              onChanged: (_) => _updateFormData(),
            ),
          if (_daCoGiaDinh || _daLyDi) const SizedBox(height: 24),

          // Kinh nghiệm làm việc nước ngoài
          Text(
            'Kinh nghiệm làm việc nước ngoài',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            labelText: 'Đã làm việc ở nước ngoài',
            hintText: 'VD: Hàn Quốc, Nhật Bản...',
            controller: _daLamViecNuocNgoaiController,
            maxLines: 2,
            onChanged: (_) => _updateFormData(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _chieuCaoController.dispose();
    _canNangController.dispose();
    _matTraiController.dispose();
    _matPhaiController.dispose();
    _muMauController.dispose();
    _hoTenChaController.dispose();
    _hoTenMeController.dispose();
    _soConController.dispose();
    _daLamViecNuocNgoaiController.dispose();
    super.dispose();
  }
}
