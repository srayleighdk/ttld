import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/core/di/injection.dart';

class XKLDStep5JobPreferences extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final HosoXKLDModel formData;
  final Function(HosoXKLDModel) onDataChanged;

  const XKLDStep5JobPreferences({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _XKLDStep5JobPreferencesState createState() =>
      _XKLDStep5JobPreferencesState();
}

class _XKLDStep5JobPreferencesState extends State<XKLDStep5JobPreferences> {
  late TextEditingController _nganhnghemongmuonController;
  late TextEditingController _viecdanglamController;
  late TextEditingController _ghichuController;

  int? _selectedQuocgia;
  int? _selectedDoituongchinhsach;
  bool _khanangtaichinh = false;
  bool _nhanSms = false;
  bool _nhanEmail = false;
  bool _nhanAddress = false;

  @override
  void initState() {
    super.initState();
    _nganhnghemongmuonController =
        TextEditingController(text: widget.formData.dkxkldNganhnghemongmuon);
    _viecdanglamController =
        TextEditingController(text: widget.formData.viecdanglam);
    _ghichuController =
        TextEditingController(text: widget.formData.dkxkldGhichu);

    _selectedQuocgia = widget.formData.dkxklddmQuocgia;
    _selectedDoituongchinhsach = widget.formData.dkxklddmDoituongchinhsach;
    _khanangtaichinh = widget.formData.dkxkldKhanangtaichinh ?? false;
    _nhanSms = widget.formData.dkxkldhtTelephone ?? false;
    _nhanEmail = widget.formData.dkxkldhtEmail ?? false;
    _nhanAddress = widget.formData.dkxkldhtAddress ?? false;
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      dkxkldNganhnghemongmuon: _nganhnghemongmuonController.text,
      viecdanglam: _viecdanglamController.text,
      dkxkldGhichu: _ghichuController.text,
      dkxklddmQuocgia: _selectedQuocgia,
      dkxklddmDoituongchinhsach: _selectedDoituongchinhsach,
      dkxkldKhanangtaichinh: _khanangtaichinh,
      dkxkldhtTelephone: _nhanSms,
      dkxkldhtEmail: _nhanEmail,
      dkxkldhtAddress: _nhanAddress,
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
            'Nguyện vọng làm việc',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thông tin về nguyện vọng và điều kiện làm việc ở nước ngoài',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Quốc gia mong muốn
          Text(
            'Quốc gia mong muốn',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          GenericPicker<QuocGia>(
            label: 'Quốc gia *',
            hintText: 'Chọn quốc gia',
            items: locator<List<QuocGia>>(),
            initialValue: _selectedQuocgia,
            onChanged: (value) {
              setState(() {
                _selectedQuocgia = value?.id is int
                    ? value?.id
                    : int.tryParse(value?.id?.toString() ?? '');
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 24),

          // Ngành nghề & Công việc
          Text(
            'Ngành nghề & Công việc',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            controller: _nganhnghemongmuonController,
            labelText: 'Ngành nghề mong muốn *',
            hintText: 'VD: Xây dựng, Chế biến thực phẩm...',
            prefixIcon: const Icon(FontAwesomeIcons.industry, size: 18),
            validator: 'not_empty',
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            controller: _viecdanglamController,
            labelText: 'Công việc hiện tại',
            hintText: 'Nhập công việc đang làm',
            prefixIcon: const Icon(FontAwesomeIcons.briefcase, size: 18),
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Khả năng tài chính
          Text(
            'Khả năng tài chính',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SwitchListTile(
            title: const Text('Có khả năng tài chính'),
            subtitle: const Text('Đủ khả năng chi trả chi phí đi XKLĐ'),
            value: _khanangtaichinh,
            onChanged: (value) {
              setState(() {
                _khanangtaichinh = value;
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

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.secondary.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.circleInfo,
                  color: theme.colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Chi phí đi XKLĐ dao động từ 50-150 triệu VNĐ tùy quốc gia. Nếu chưa có khả năng tài chính, bạn có thể vay vốn hoặc tìm chương trình hỗ trợ.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
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

          GenericPicker<DoiTuong>(
            label: 'Đối tượng chính sách *',
            hintText: 'Chọn đối tượng chính sách',
            items: locator<List<DoiTuong>>(),
            initialValue: _selectedDoituongchinhsach,
            onChanged: (value) {
              setState(() {
                _selectedDoituongchinhsach = value?.id is int
                    ? value?.id
                    : int.tryParse(value?.id?.toString() ?? '');
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 24),

          // Ghi chú
          Text(
            'Ghi chú',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            controller: _ghichuController,
            labelText: 'Ghi chú thêm',
            hintText: 'Thông tin thêm về nguyện vọng của bạn',
            prefixIcon: const Icon(FontAwesomeIcons.noteSticky, size: 18),
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
            subtitle: const Text('Nhận tin nhắn về các chương trình XKLĐ'),
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
            subtitle: const Text('Nhận email về thông tin tuyển dụng'),
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
          const SizedBox(height: 8),

          SwitchListTile(
            title: const Text('Nhận thông báo qua Địa chỉ'),
            subtitle: const Text('Nhận thư về các thông tin quan trọng'),
            value: _nhanAddress,
            onChanged: (value) {
              setState(() {
                _nhanAddress = value;
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
                      FontAwesomeIcons.circleCheck,
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
                  'Bạn đã hoàn thành tất cả các bước. Nhấn "Hoàn thành" để gửi hồ sơ đăng ký xuất khẩu lao động của bạn. Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.',
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
    _nganhnghemongmuonController.dispose();
    _viecdanglamController.dispose();
    _ghichuController.dispose();
    super.dispose();
  }
}
