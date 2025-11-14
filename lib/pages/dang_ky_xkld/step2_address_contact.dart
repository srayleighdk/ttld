import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';

class XKLDStep2AddressContact extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final HosoXKLDModel formData;
  final Function(HosoXKLDModel) onDataChanged;

  const XKLDStep2AddressContact({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _XKLDStep2AddressContactState createState() =>
      _XKLDStep2AddressContactState();
}

class _XKLDStep2AddressContactState extends State<XKLDStep2AddressContact> {
  late TextEditingController _nguyenquanController;
  late TextEditingController _hokhauController;
  late TextEditingController _diachitamtruController;
  late TextEditingController _thonBuonController;
  late TextEditingController _dienthoailienheController;

  String? _selectedTinh;
  String? _selectedHuyen;
  String? _selectedXa;

  @override
  void initState() {
    super.initState();
    _nguyenquanController =
        TextEditingController(text: widget.formData.dkxkldNguyenquan);
    _hokhauController =
        TextEditingController(text: widget.formData.dkxkldHokhauthuongtru);
    _diachitamtruController =
        TextEditingController(text: widget.formData.dkxkldDiachitamtru);
    _thonBuonController =
        TextEditingController(text: widget.formData.thonBuon);
    _dienthoailienheController =
        TextEditingController(text: widget.formData.dienthoailienhe);

    _selectedTinh = widget.formData.tinh;
    _selectedHuyen = widget.formData.huyenThiThanhPho;
    _selectedXa = widget.formData.xaPhuong;
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      dkxkldNguyenquan: _nguyenquanController.text,
      dkxkldHokhauthuongtru: _hokhauController.text,
      dkxkldDiachitamtru: _diachitamtruController.text,
      thonBuon: _thonBuonController.text,
      dienthoailienhe: _dienthoailienheController.text,
      tinh: _selectedTinh,
      huyenThiThanhPho: _selectedHuyen,
      xaPhuong: _selectedXa,
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
            'Địa chỉ & Liên hệ',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thông tin về địa chỉ và liên hệ của bạn',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Nguyên quán
          Text(
            'Nguyên quán',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _nguyenquanController,
            decoration: InputDecoration(
              labelText: 'Nguyên quán *',
              hintText: 'Nhập nguyên quán',
              prefixIcon: const Icon(FontAwesomeIcons.house, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập nguyên quán';
              }
              return null;
            },
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Hộ khẩu thường trú
          Text(
            'Hộ khẩu thường trú',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _hokhauController,
            decoration: InputDecoration(
              labelText: 'Địa chỉ hộ khẩu thường trú *',
              hintText: 'Nhập địa chỉ hộ khẩu',
              prefixIcon: const Icon(FontAwesomeIcons.home, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập địa chỉ hộ khẩu';
              }
              return null;
            },
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Thôn/Buôn
          TextFormField(
            controller: _thonBuonController,
            decoration: InputDecoration(
              labelText: 'Thôn/Buôn/Ấp',
              hintText: 'Nhập thôn/buôn/ấp',
              prefixIcon: const Icon(FontAwesomeIcons.streetView, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Tỉnh/Thành phố
          DropdownButtonFormField<String>(
            value: _selectedTinh,
            decoration: InputDecoration(
              labelText: 'Tỉnh/Thành phố *',
              prefixIcon: const Icon(FontAwesomeIcons.city, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: '01', child: Text('Hà Nội')),
              DropdownMenuItem(value: '79', child: Text('TP. Hồ Chí Minh')),
              DropdownMenuItem(value: '48', child: Text('Đà Nẵng')),
              DropdownMenuItem(value: '92', child: Text('Cần Thơ')),
              DropdownMenuItem(value: '31', child: Text('Hải Phòng')),
              // Add more provinces as needed
            ],
            validator: (value) {
              if (value == null) {
                return 'Vui lòng chọn tỉnh/thành phố';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedTinh = value;
                _selectedHuyen = null; // Reset district when province changes
                _selectedXa = null; // Reset ward when province changes
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          // Huyện/Quận
          DropdownButtonFormField<String>(
            value: _selectedHuyen,
            decoration: InputDecoration(
              labelText: 'Quận/Huyện',
              prefixIcon: const Icon(FontAwesomeIcons.mapLocation, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: '001', child: Text('Quận Ba Đình')),
              DropdownMenuItem(value: '002', child: Text('Quận Hoàn Kiếm')),
              DropdownMenuItem(value: '003', child: Text('Quận Tây Hồ')),
              // Add more districts as needed
            ],
            onChanged: (value) {
              setState(() {
                _selectedHuyen = value;
                _selectedXa = null; // Reset ward when district changes
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          // Xã/Phường
          DropdownButtonFormField<String>(
            value: _selectedXa,
            decoration: InputDecoration(
              labelText: 'Xã/Phường',
              prefixIcon: const Icon(FontAwesomeIcons.locationDot, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: '00001', child: Text('Phường Phúc Xá')),
              DropdownMenuItem(value: '00002', child: Text('Phường Trúc Bạch')),
              DropdownMenuItem(value: '00003', child: Text('Phường Vĩnh Phúc')),
              // Add more wards as needed
            ],
            onChanged: (value) {
              setState(() {
                _selectedXa = value;
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 24),

          // Địa chỉ tạm trú
          Text(
            'Địa chỉ tạm trú',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _diachitamtruController,
            decoration: InputDecoration(
              labelText: 'Địa chỉ tạm trú',
              hintText: 'Nhập địa chỉ tạm trú (nếu khác hộ khẩu)',
              prefixIcon: const Icon(FontAwesomeIcons.locationPin, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 2,
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Liên hệ khẩn cấp
          Text(
            'Liên hệ khẩn cấp',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _dienthoailienheController,
            decoration: InputDecoration(
              labelText: 'Số điện thoại liên hệ khẩn cấp',
              hintText: 'Nhập số điện thoại người thân',
              prefixIcon: const Icon(FontAwesomeIcons.phoneVolume, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: TextInputType.phone,
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
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.circleInfo,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Vui lòng cung cấp thông tin chính xác về địa chỉ để liên hệ khi cần thiết',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
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
    _nguyenquanController.dispose();
    _hokhauController.dispose();
    _diachitamtruController.dispose();
    _thonBuonController.dispose();
    _dienthoailienheController.dispose();
    super.dispose();
  }
}
