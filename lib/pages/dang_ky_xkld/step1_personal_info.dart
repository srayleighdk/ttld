import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';
import 'package:ttld/models/dan_toc_model.dart';
import 'package:ttld/models/ton_giao_model.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/core/di/injection.dart';

class XKLDStep1PersonalInfo extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final HosoXKLDModel formData;
  final Function(HosoXKLDModel) onDataChanged;

  const XKLDStep1PersonalInfo({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _XKLDStep1PersonalInfoState createState() => _XKLDStep1PersonalInfoState();
}

class _XKLDStep1PersonalInfoState extends State<XKLDStep1PersonalInfo> {
  late TextEditingController _hotenController;
  late TextEditingController _emailController;
  late TextEditingController _dienthoaiController;
  late TextEditingController _ngaysinhController;
  late TextEditingController _soCmndController;
  late TextEditingController _ngaycapController;
  late TextEditingController _noicapController;
  late TextEditingController _sohochieuController;

  int? _selectedGioitinh;
  String? _selectedDantoc;
  String? _selectedTongiao;
  DateTime? _selectedNgaysinh;
  DateTime? _selectedNgaycap;

  @override
  void initState() {
    super.initState();
    _hotenController = TextEditingController(text: widget.formData.dkxkldHoten);
    _emailController = TextEditingController(text: widget.formData.dkxkldEmail);
    _dienthoaiController =
        TextEditingController(text: widget.formData.dkxkldDienthoai);
    _soCmndController =
        TextEditingController(text: widget.formData.dkxkldSoCmnd);
    _noicapController =
        TextEditingController(text: widget.formData.dkxkldNoicap);
    _sohochieuController =
        TextEditingController(text: widget.formData.dkxkldSohochieu);

    _ngaysinhController = TextEditingController(
      text: widget.formData.dkxkldNgaysinh != null
          ? DateFormat('dd/MM/yyyy').format(
              DateTime.parse(widget.formData.dkxkldNgaysinh!),
            )
          : '',
    );
    _ngaycapController = TextEditingController(
      text: widget.formData.dkxkldNgaycap != null
          ? DateFormat('dd/MM/yyyy').format(
              DateTime.parse(widget.formData.dkxkldNgaycap!),
            )
          : '',
    );

    _selectedGioitinh = widget.formData.dkxkldGioitinh;
    _selectedDantoc = widget.formData.dkxkldDantoc;
    _selectedTongiao = widget.formData.dkxkldTongiao;

    if (widget.formData.dkxkldNgaysinh != null) {
      _selectedNgaysinh = DateTime.parse(widget.formData.dkxkldNgaysinh!);
    }
    if (widget.formData.dkxkldNgaycap != null) {
      _selectedNgaycap = DateTime.parse(widget.formData.dkxkldNgaycap!);
    }
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      dkxkldHoten: _hotenController.text,
      dkxkldEmail: _emailController.text,
      dkxkldDienthoai: _dienthoaiController.text,
      dkxkldNgaysinh: _selectedNgaysinh?.toIso8601String(),
      dkxkldSoCmnd: _soCmndController.text,
      dkxkldNgaycap: _selectedNgaycap?.toIso8601String(),
      dkxkldNoicap: _noicapController.text,
      dkxkldSohochieu: _sohochieuController.text,
      dkxkldGioitinh: _selectedGioitinh,
      dkxkldDantoc: _selectedDantoc,
      dkxkldTongiao: _selectedTongiao,
    );
    widget.onDataChanged(updatedData);
  }

  Future<void> _selectDate(BuildContext context, bool isBirthDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isBirthDate
          ? (_selectedNgaysinh ?? DateTime(1990))
          : (_selectedNgaycap ?? DateTime.now()),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isBirthDate) {
          _selectedNgaysinh = picked;
          _ngaysinhController.text = DateFormat('dd/MM/yyyy').format(picked);
        } else {
          _selectedNgaycap = picked;
          _ngaycapController.text = DateFormat('dd/MM/yyyy').format(picked);
        }
        _updateFormData();
      });
    }
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
            'Thông tin cá nhân',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vui lòng điền đầy đủ thông tin cá nhân để đăng ký xuất khẩu lao động',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Họ tên
          TextFormField(
            controller: _hotenController,
            decoration: InputDecoration(
              labelText: 'Họ và tên *',
              hintText: 'Nhập họ và tên đầy đủ',
              prefixIcon: const Icon(FontAwesomeIcons.user, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập họ và tên';
              }
              return null;
            },
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Ngày sinh
          TextFormField(
            controller: _ngaysinhController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Ngày sinh *',
              hintText: 'Chọn ngày sinh',
              prefixIcon: const Icon(FontAwesomeIcons.calendar, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng chọn ngày sinh';
              }
              return null;
            },
            onTap: () => _selectDate(context, true),
          ),
          const SizedBox(height: 16),

          // Giới tính
          DropdownButtonFormField<int>(
            value: _selectedGioitinh,
            decoration: InputDecoration(
              labelText: 'Giới tính *',
              prefixIcon: const Icon(FontAwesomeIcons.venusMars, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 0, child: Text('Nữ')),
              DropdownMenuItem(value: 1, child: Text('Nam')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedGioitinh = value;
                _updateFormData();
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Vui lòng chọn giới tính';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Email
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email *',
              hintText: 'Nhập địa chỉ email',
              prefixIcon: const Icon(FontAwesomeIcons.envelope, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Email không hợp lệ';
              }
              return null;
            },
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Số điện thoại
          TextFormField(
            controller: _dienthoaiController,
            decoration: InputDecoration(
              labelText: 'Số điện thoại *',
              hintText: 'Nhập số điện thoại',
              prefixIcon: const Icon(FontAwesomeIcons.phone, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập số điện thoại';
              }
              if (value.length < 10) {
                return 'Số điện thoại không hợp lệ';
              }
              return null;
            },
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // ID Document section
          Text(
            'Giấy tờ tùy thân',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Số CMND/CCCD
          TextFormField(
            controller: _soCmndController,
            decoration: InputDecoration(
              labelText: 'Số CMND/CCCD *',
              hintText: 'Nhập số CMND hoặc CCCD',
              prefixIcon: const Icon(FontAwesomeIcons.idCard, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập số CMND/CCCD';
              }
              return null;
            },
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Ngày cấp
          TextFormField(
            controller: _ngaycapController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Ngày cấp',
              hintText: 'Chọn ngày cấp',
              prefixIcon: const Icon(FontAwesomeIcons.calendar, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onTap: () => _selectDate(context, false),
          ),
          const SizedBox(height: 16),

          // Nơi cấp
          TextFormField(
            controller: _noicapController,
            decoration: InputDecoration(
              labelText: 'Nơi cấp',
              hintText: 'Nhập nơi cấp CMND/CCCD',
              prefixIcon: const Icon(FontAwesomeIcons.locationDot, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Số hộ chiếu
          TextFormField(
            controller: _sohochieuController,
            decoration: InputDecoration(
              labelText: 'Số hộ chiếu',
              hintText: 'Nhập số hộ chiếu (nếu có)',
              prefixIcon: const Icon(FontAwesomeIcons.passport, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 24),

          // Additional info section
          Text(
            'Thông tin bổ sung',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Dân tộc
          GenericPicker<DanToc>(
            label: 'Dân tộc',
            hintText: 'Chọn dân tộc',
            items: locator<List<DanToc>>(),
            initialValue: _selectedDantoc != null
                ? locator<List<DanToc>>().firstWhere(
                    (item) => item.displayName == _selectedDantoc,
                    orElse: () => locator<List<DanToc>>().first,
                  ).id
                : null,
            onChanged: (value) {
              setState(() {
                _selectedDantoc = value?.displayName;
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          // Tôn giáo
          GenericPicker<TonGiao>(
            label: 'Tôn giáo',
            hintText: 'Chọn tôn giáo',
            items: locator<List<TonGiao>>(),
            initialValue: _selectedTongiao != null
                ? locator<List<TonGiao>>().firstWhere(
                    (item) => item.displayName == _selectedTongiao,
                    orElse: () => locator<List<TonGiao>>().first,
                  ).id
                : null,
            onChanged: (value) {
              setState(() {
                _selectedTongiao = value?.displayName;
                _updateFormData();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hotenController.dispose();
    _emailController.dispose();
    _dienthoaiController.dispose();
    _ngaysinhController.dispose();
    _soCmndController.dispose();
    _ngaycapController.dispose();
    _noicapController.dispose();
    _sohochieuController.dispose();
    super.dispose();
  }
}
