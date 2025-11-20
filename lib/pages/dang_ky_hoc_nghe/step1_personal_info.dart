import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/hoso_dtn/hoso_dtn_model.dart';
import 'package:ttld/models/dan_toc_model.dart';
import 'package:ttld/models/ton_giao_model.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/core/di/injection.dart';

class VTStep1PersonalInfo extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final HosoDTN formData;
  final Function(HosoDTN) onDataChanged;

  const VTStep1PersonalInfo({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _VTStep1PersonalInfoState createState() => _VTStep1PersonalInfoState();
}

class _VTStep1PersonalInfoState extends State<VTStep1PersonalInfo> {
  late TextEditingController _hotenController;
  late TextEditingController _emailController;
  late TextEditingController _dienthoaiController;
  late TextEditingController _ngaysinhController;
  late TextEditingController _chuyenmonController;
  late TextEditingController _hokhauController;
  late TextEditingController _soNhaDuongController;

  int? _selectedGioitinh;
  int? _selectedDantoc;
  int? _selectedTongiao;
  DateTime? _selectedNgaysinh;

  @override
  void initState() {
    super.initState();
    _hotenController = TextEditingController(text: widget.formData.dkdtnHoten);
    _emailController = TextEditingController(text: widget.formData.dkdtnEmail);
    _dienthoaiController =
        TextEditingController(text: widget.formData.dkdtnDienthoai);
    _ngaysinhController = TextEditingController(
      text: widget.formData.dkdtnNgaysinh != null
          ? DateFormat('dd/MM/yyyy').format(widget.formData.dkdtnNgaysinh!)
          : '',
    );
    _chuyenmonController =
        TextEditingController(text: widget.formData.dkdtnChuyenmon);
    _hokhauController =
        TextEditingController(text: widget.formData.dkdtnHokhauthuongtru);
    _soNhaDuongController =
        TextEditingController(text: widget.formData.soNhaDuong);

    _selectedGioitinh = widget.formData.dkdtnGioitinh;
    _selectedDantoc = widget.formData.dkdtnDantoc;
    _selectedTongiao = widget.formData.dkdtnTongiao;
    _selectedNgaysinh = widget.formData.dkdtnNgaysinh;
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      dkdtnHoten: _hotenController.text,
      dkdtnEmail: _emailController.text,
      dkdtnDienthoai: _dienthoaiController.text,
      dkdtnNgaysinh: _selectedNgaysinh,
      dkdtnChuyenmon: _chuyenmonController.text,
      dkdtnHokhauthuongtru: _hokhauController.text,
      soNhaDuong: _soNhaDuongController.text,
      dkdtnGioitinh: _selectedGioitinh,
      dkdtnDantoc: _selectedDantoc,
      dkdtnTongiao: _selectedTongiao,
    );
    widget.onDataChanged(updatedData);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedNgaysinh ?? DateTime(1990),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedNgaysinh) {
      setState(() {
        _selectedNgaysinh = picked;
        _ngaysinhController.text = DateFormat('dd/MM/yyyy').format(picked);
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
            'Vui lòng điền đầy đủ thông tin cá nhân của bạn',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Họ tên
          CustomTextField(
            labelText: 'Họ và tên *',
            hintText: 'Nhập họ và tên đầy đủ',
            controller: _hotenController,
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
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: CustomTextField(
                labelText: 'Ngày sinh',
                hintText: 'Chọn ngày sinh',
                controller: _ngaysinhController,
                readOnly: true,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Giới tính

          CustomPickerMap(
              label: const Text('Giới tính *'),
              items: gioiTinhOptions,
              selectedItem: _selectedGioitinh,
              onChanged: (value) {
                setState(() {
                  _selectedGioitinh = value;
                  _updateFormData();
                });
              }),
          const SizedBox(height: 16),

          // Email
          CustomTextField(
            labelText: 'Email',
            hintText: 'Nhập địa chỉ email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Email không hợp lệ';
                }
              }
              return null;
            },
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Số điện thoại
          CustomTextField(
            labelText: 'Số điện thoại *',
            hintText: 'Nhập số điện thoại',
            controller: _dienthoaiController,
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
          const SizedBox(height: 16),

          // Chuyên môn hiện tại
          CustomTextField(
            labelText: 'Chuyên môn hiện tại',
            hintText: 'Nhập chuyên môn đã học/làm',
            controller: _chuyenmonController,
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Dân tộc
          GenericPicker<DanToc>(
            label: 'Dân tộc',
            hintText: 'Chọn dân tộc',
            items: locator<List<DanToc>>(),
            initialValue: _selectedDantoc,
            onChanged: (value) {
              setState(() {
                _selectedDantoc = value?.id is int
                    ? value?.id
                    : int.tryParse(value?.id?.toString() ?? '');
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
            initialValue: _selectedTongiao,
            onChanged: (value) {
              setState(() {
                _selectedTongiao = value?.id is int
                    ? value?.id
                    : int.tryParse(value?.id?.toString() ?? '');
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 24),

          // Địa chỉ section
          Text(
            'Địa chỉ',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Hộ khẩu thường trú
          CustomTextField(
            labelText: 'Hộ khẩu thường trú *',
            hintText: 'Nhập địa chỉ hộ khẩu',
            controller: _hokhauController,
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

          // Số nhà đường
          CustomTextField(
            labelText: 'Số nhà, đường',
            hintText: 'Nhập số nhà, đường',
            controller: _soNhaDuongController,
            onChanged: (_) => _updateFormData(),
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
    _chuyenmonController.dispose();
    _hokhauController.dispose();
    _soNhaDuongController.dispose();
    super.dispose();
  }
}
