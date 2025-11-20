import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class XKLDStep3PhysicalHealth extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final HosoXKLDModel formData;
  final Function(HosoXKLDModel) onDataChanged;

  const XKLDStep3PhysicalHealth({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _XKLDStep3PhysicalHealthState createState() =>
      _XKLDStep3PhysicalHealthState();
}

class _XKLDStep3PhysicalHealthState extends State<XKLDStep3PhysicalHealth> {
  late TextEditingController _chieucaoController;
  late TextEditingController _cannangController;

  bool _coHochieu = false;
  bool _daKetHon = false;
  bool _suckhoeTot = false;
  bool _daPhongVan = false;

  @override
  void initState() {
    super.initState();
    _chieucaoController =
        TextEditingController(text: widget.formData.dkxkldChieucao);
    _cannangController =
        TextEditingController(text: widget.formData.dkxkldCannang);

    _coHochieu = widget.formData.dkxkldHochieu ?? false;
    _daKetHon = widget.formData.dkxkldHonnhan ?? false;
    _suckhoeTot = widget.formData.dkxkldIdTths ?? false;
    _daPhongVan = widget.formData.dkxkldIdKqpv ?? false;
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      dkxkldChieucao: _chieucaoController.text,
      dkxkldCannang: _cannangController.text,
      dkxkldHochieu: _coHochieu,
      dkxkldHonnhan: _daKetHon,
      dkxkldIdTths: _suckhoeTot,
      dkxkldIdKqpv: _daPhongVan,
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
            'Sức khỏe & Thể chất',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thông tin về sức khỏe và thể chất của bạn',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Thông tin thể chất
          Text(
            'Thông tin thể chất',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _chieucaoController,
                  labelText: 'Chiều cao (cm) *',
                  hintText: 'VD: 170',
                  prefixIcon: const Icon(FontAwesomeIcons.ruler, size: 18),
                  keyboardType: TextInputType.number,
                  validator: 'not_empty',
                  onChanged: (_) => _updateFormData(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  controller: _cannangController,
                  labelText: 'Cân nặng (kg) *',
                  hintText: 'VD: 65',
                  prefixIcon:
                      const Icon(FontAwesomeIcons.weightScale, size: 18),
                  keyboardType: TextInputType.number,
                  validator: 'not_empty',
                  onChanged: (_) => _updateFormData(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Tình trạng sức khỏe
          Text(
            'Tình trạng sức khỏe',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SwitchListTile(
            title: const Text('Sức khỏe tốt'),
            subtitle: const Text('Đủ điều kiện sức khỏe để đi XKLĐ'),
            value: _suckhoeTot,
            onChanged: (value) {
              setState(() {
                _suckhoeTot = value;
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
          const SizedBox(height: 8),

          const SizedBox(height: 24),
          const SizedBox(height: 24),

          // Giấy tờ & Tình trạng
          Text(
            'Giấy tờ & Tình trạng',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SwitchListTile(
            title: const Text('Có hộ chiếu'),
            subtitle: const Text('Đã có hộ chiếu hợp lệ'),
            value: _coHochieu,
            onChanged: (value) {
              setState(() {
                _coHochieu = value;
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
          const SizedBox(height: 8),

          SwitchListTile(
            title: const Text('Đã kết hôn'),
            subtitle: const Text('Tình trạng hôn nhân'),
            value: _daKetHon,
            onChanged: (value) {
              setState(() {
                _daKetHon = value;
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
          const SizedBox(height: 8),

          SwitchListTile(
            title: const Text('Đã phỏng vấn'),
            subtitle: const Text('Đã tham gia phỏng vấn tuyển dụng'),
            value: _daPhongVan,
            onChanged: (value) {
              setState(() {
                _daPhongVan = value;
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

          // Requirements card
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          FontAwesomeIcons.check,
          size: 14,
          color: Colors.green,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _chieucaoController.dispose();
    _cannangController.dispose();
    super.dispose();
  }
}
