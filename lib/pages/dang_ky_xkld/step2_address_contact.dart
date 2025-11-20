import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/cascade_location_picker_grok.dart';

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
  late TextEditingController _dummyAddressController;

  String? _selectedTinh;
  String? _selectedHuyen;
  String? _selectedXa;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _initLocationData();
  }

  @override
  void didUpdateWidget(XKLDStep2AddressContact oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.formData != oldWidget.formData) {
      _updateControllers();
      _updateLocationData();
    }
  }

  void _initControllers() {
    _nguyenquanController =
        TextEditingController(text: widget.formData.dkxkldNguyenquan);
    _hokhauController =
        TextEditingController(text: widget.formData.dkxkldHokhauthuongtru);
    _diachitamtruController =
        TextEditingController(text: widget.formData.dkxkldDiachitamtru);
    _thonBuonController = TextEditingController(text: widget.formData.thonBuon);
    _dienthoailienheController =
        TextEditingController(text: widget.formData.dienthoailienhe);
    _dummyAddressController = TextEditingController();
  }

  void _updateControllers() {
    if (_nguyenquanController.text != widget.formData.dkxkldNguyenquan) {
      _nguyenquanController.text = widget.formData.dkxkldNguyenquan ?? '';
    }
    if (_hokhauController.text != widget.formData.dkxkldHokhauthuongtru) {
      _hokhauController.text = widget.formData.dkxkldHokhauthuongtru ?? '';
    }
    if (_diachitamtruController.text != widget.formData.dkxkldDiachitamtru) {
      _diachitamtruController.text = widget.formData.dkxkldDiachitamtru ?? '';
    }
    if (_thonBuonController.text != widget.formData.thonBuon) {
      _thonBuonController.text = widget.formData.thonBuon ?? '';
    }
    if (_dienthoailienheController.text != widget.formData.dienthoailienhe) {
      _dienthoailienheController.text = widget.formData.dienthoailienhe ?? '';
    }
  }

  void _initLocationData() {
    _selectedTinh = widget.formData.tinh;
    _selectedHuyen = widget.formData.huyenThiThanhPho;
    _selectedXa = widget.formData.xaPhuong;
  }

  void _updateLocationData() {
    setState(() {
      _selectedTinh = widget.formData.tinh;
      _selectedHuyen = widget.formData.huyenThiThanhPho;
      _selectedXa = widget.formData.xaPhuong;
    });
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

          CustomTextField(
            controller: _nguyenquanController,
            labelText: 'Nguyên quán *',
            hintText: 'Nhập nguyên quán',
            prefixIcon: const Icon(FontAwesomeIcons.house, size: 18),
            maxLines: 2,
            validator: 'not_empty',
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

          CustomTextField(
            controller: _hokhauController,
            labelText: 'Địa chỉ hộ khẩu thường trú *',
            hintText: 'Nhập địa chỉ hộ khẩu',
            prefixIcon: const Icon(FontAwesomeIcons.home, size: 18),
            maxLines: 2,
            validator: 'not_empty',
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Thôn/Buôn
          CustomTextField(
            controller: _thonBuonController,
            labelText: 'Thôn/Buôn/Ấp',
            hintText: 'Nhập thôn/buôn/ấp',
            prefixIcon: const Icon(FontAwesomeIcons.streetView, size: 18),
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Tỉnh/Thành phố - Quận/Huyện - Xã/Phường
          ModernCascadeLocationPicker(
            addressDetailController: _dummyAddressController,
            showAddressDetail: false,
            isNTD: false,
            initialTinh: widget.formData.tinh,
            initialHuyen: widget.formData.huyenThiThanhPho,
            initialXa: widget.formData.xaPhuong,
            onTinhChanged: (tinh) {
              setState(() {
                _selectedTinh = tinh?.id;
                _selectedHuyen = null;
                _selectedXa = null;
                _updateFormData();
              });
            },
            onHuyenChanged: (huyen) {
              setState(() {
                _selectedHuyen = huyen?.id;
                _selectedXa = null;
                _updateFormData();
              });
            },
            onXaChanged: (xa) {
              setState(() {
                _selectedXa = xa?.id;
                _updateFormData();
              });
            },
            validator: (value) {
              if (_selectedTinh == null) {
                return 'Vui lòng chọn Tỉnh/Thành phố';
              }
              return null;
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

          CustomTextField(
            controller: _diachitamtruController,
            labelText: 'Địa chỉ tạm trú',
            hintText: 'Nhập địa chỉ tạm trú (nếu khác hộ khẩu)',
            prefixIcon: const Icon(FontAwesomeIcons.locationPin, size: 18),
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

          CustomTextField(
            controller: _dienthoailienheController,
            labelText: 'Số điện thoại liên hệ khẩn cấp',
            hintText: 'Nhập số điện thoại người thân',
            prefixIcon: const Icon(FontAwesomeIcons.phoneVolume, size: 18),
            keyboardType: TextInputType.phone,
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Info card
          const SizedBox(height: 24),
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
    _dummyAddressController.dispose();
    super.dispose();
  }
}
