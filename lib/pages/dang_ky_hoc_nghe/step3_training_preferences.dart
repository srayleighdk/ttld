import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/models/hoso_dtn/hoso_dtn_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class VTStep3TrainingPreferences extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final HosoDTN formData;
  final Function(HosoDTN) onDataChanged;

  const VTStep3TrainingPreferences({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _VTStep3TrainingPreferencesState createState() =>
      _VTStep3TrainingPreferencesState();
}

class _VTStep3TrainingPreferencesState
    extends State<VTStep3TrainingPreferences> {
  late TextEditingController _ghichuController;

  int? _selectedTrinhdohocvan;
  int? _selectedTruong;
  int? _selectedNghedaotao;
  int? _selectedNghenganhan;
  int? _selectedNghesocap;
  int? _selectedDoituongchinhsach;
  bool _nhanSms = false;
  bool _nhanEmail = false;

  @override
  void initState() {
    super.initState();
    _ghichuController = TextEditingController(text: widget.formData.dkdtnGhichu);

    _selectedTrinhdohocvan = widget.formData.dkdtndmTrinhdohocvanDtn;
    _selectedTruong = widget.formData.dkdtndmTruong;
    _selectedNghedaotao = widget.formData.dkdtndmNghedaotao;
    _selectedNghenganhan = widget.formData.dkdtndmNghenganhan;
    _selectedNghesocap = widget.formData.dkdtndmNghesocap;
    _selectedDoituongchinhsach = widget.formData.dkdtndmDoituongchinhsach;
    _nhanSms = widget.formData.dkdtnhtTelephone ?? false;
    _nhanEmail = widget.formData.dkdtnhtEmail ?? false;
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      dkdtnGhichu: _ghichuController.text,
      dkdtndmTrinhdohocvanDtn: _selectedTrinhdohocvan,
      dkdtndmTruong: _selectedTruong,
      dkdtndmNghedaotao: _selectedNghedaotao,
      dkdtndmNghenganhan: _selectedNghenganhan,
      dkdtndmNghesocap: _selectedNghesocap,
      dkdtndmDoituongchinhsach: _selectedDoituongchinhsach,
      dkdtnhtTelephone: _nhanSms,
      dkdtnhtEmail: _nhanEmail,
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
            'Nguyện vọng đào tạo',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thông tin về nguyện vọng đào tạo nghề của bạn',
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
              labelText: 'Trình độ học vấn hiện tại',
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
            ],
            onChanged: (value) {
              setState(() {
                _selectedTrinhdohocvan = value;
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 24),

          // Nguyện vọng đào tạo
          Text(
            'Nguyện vọng đào tạo',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<int>(
            value: _selectedTruong,
            decoration: InputDecoration(
              labelText: 'Trường mong muốn *',
              prefixIcon: const Icon(FontAwesomeIcons.school, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 1, child: Text('Trường Cao đẳng nghề A')),
              DropdownMenuItem(value: 2, child: Text('Trường Cao đẳng nghề B')),
              DropdownMenuItem(value: 3, child: Text('Trường Trung cấp nghề C')),
              DropdownMenuItem(value: 4, child: Text('Trung tâm dạy nghề D')),
            ],
            validator: (value) {
              if (value == null) {
                return 'Vui lòng chọn trường';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedTruong = value;
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<int>(
            value: _selectedNghedaotao,
            decoration: InputDecoration(
              labelText: 'Nghề đào tạo mong muốn *',
              prefixIcon: const Icon(FontAwesomeIcons.hammer, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 1, child: Text('Điện công nghiệp')),
              DropdownMenuItem(value: 2, child: Text('Cơ khí')),
              DropdownMenuItem(value: 3, child: Text('Hàn')),
              DropdownMenuItem(value: 4, child: Text('May công nghiệp')),
              DropdownMenuItem(value: 5, child: Text('Nấu ăn')),
              DropdownMenuItem(value: 6, child: Text('Công nghệ thông tin')),
              DropdownMenuItem(value: 7, child: Text('Kế toán')),
            ],
            validator: (value) {
              if (value == null) {
                return 'Vui lòng chọn nghề đào tạo';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedNghedaotao = value;
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<int>(
            value: _selectedNghenganhan,
            decoration: InputDecoration(
              labelText: 'Nghề ngắn hạn',
              prefixIcon: const Icon(FontAwesomeIcons.clock, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 1, child: Text('Lái xe')),
              DropdownMenuItem(value: 2, child: Text('Điện dân dụng')),
              DropdownMenuItem(value: 3, child: Text('Sửa chữa điện thoại')),
              DropdownMenuItem(value: 4, child: Text('Làm bánh')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedNghenganhan = value;
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<int>(
            value: _selectedNghesocap,
            decoration: InputDecoration(
              labelText: 'Nghề sơ cấp',
              prefixIcon: const Icon(FontAwesomeIcons.screwdriver, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 1, child: Text('Thợ điện')),
              DropdownMenuItem(value: 2, child: Text('Thợ hàn')),
              DropdownMenuItem(value: 3, child: Text('Thợ mộc')),
              DropdownMenuItem(value: 4, child: Text('Thợ sửa xe')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedNghesocap = value;
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 24),

          // Đối tượng chính sách
          Text(
            'Đối tượng chính sách',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<int>(
            value: _selectedDoituongchinhsach,
            decoration: InputDecoration(
              labelText: 'Đối tượng chính sách *',
              prefixIcon: const Icon(FontAwesomeIcons.userShield, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 1, child: Text('Người nghèo')),
              DropdownMenuItem(value: 2, child: Text('Hộ cận nghèo')),
              DropdownMenuItem(value: 3, child: Text('Dân tộc thiểu số')),
              DropdownMenuItem(value: 4, child: Text('Người khuyết tật')),
              DropdownMenuItem(value: 5, child: Text('Không thuộc đối tượng')),
            ],
            validator: (value) {
              if (value == null) {
                return 'Vui lòng chọn đối tượng chính sách';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedDoituongchinhsach = value;
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 24),

          // Ghi chú
          Text(
            'Thông tin thêm',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            labelText: 'Ghi chú',
            hintText: 'Thông tin thêm về nguyện vọng của bạn',
            controller: _ghichuController,
            maxLines: 4,
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Nhận thông báo
          Text(
            'Nhận thông báo',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SwitchListTile(
            title: const Text('Nhận thông báo qua SMS'),
            subtitle: const Text('Nhận tin nhắn về các khóa đào tạo phù hợp'),
            value: _nhanSms,
            onChanged: (value) {
              setState(() {
                _nhanSms = value;
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
            title: const Text('Nhận thông báo qua Email'),
            subtitle: const Text('Nhận email về thông tin đào tạo'),
            value: _nhanEmail,
            onChanged: (value) {
              setState(() {
                _nhanEmail = value;
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

          // Summary card
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
                      FontAwesomeIcons.circleInfo,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Hoàn tất đăng ký',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Bạn đã hoàn thành tất cả các bước. Nhấn "Hoàn thành" để gửi đăng ký học nghề của bạn.',
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
    _ghichuController.dispose();
    super.dispose();
  }
}
