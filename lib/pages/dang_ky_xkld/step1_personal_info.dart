import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';
import 'package:ttld/models/dan_toc_model.dart';
import 'package:ttld/models/ton_giao_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/models/ngoai_ngu_model.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/field/custom_pick_datetime_grok.dart';
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
  late TextEditingController _soCmndController;
  late TextEditingController _noicapController;
  late TextEditingController _sohochieuController;

  int? _selectedGioitinh;
  int? _selectedTrinhdohocvan;
  int? _selectedNgoaingudaotao;
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

    _selectedGioitinh = widget.formData.dkxkldGioitinh;
    _selectedTrinhdohocvan = widget.formData.dkxklddmTrinhdohocvan;
    _selectedNgoaingudaotao = widget.formData.dkxklddmNgoaingudaotao;
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
      dkxklddmTrinhdohocvan: _selectedTrinhdohocvan,
      dkxklddmNgoaingudaotao: _selectedNgoaingudaotao,
      dkxkldDantoc: _selectedDantoc,
      dkxkldTongiao: _selectedTongiao,
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
          CustomTextField(
            controller: _hotenController,
            labelText: 'Họ và tên *',
            hintText: 'Nhập họ và tên đầy đủ',
            prefixIcon: const Icon(FontAwesomeIcons.user, size: 18),
            validator: 'not_empty',
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Ngày sinh
          CustomPickDateTimeGrok(
            labelText: 'Ngày sinh *',
            hintText: 'Chọn ngày sinh',
            prefixIcon: const Icon(FontAwesomeIcons.calendar, size: 18),
            initialValue: widget.formData.dkxkldNgaysinh,
            validator: (value) {
              if (value == null) {
                return 'Vui lòng chọn ngày sinh';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _selectedNgaysinh = DateTime.parse(value);
                } else {
                  _selectedNgaysinh = null;
                }
                _updateFormData();
              });
            },
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
          // DropdownButtonFormField<int>(
          //   value: _selectedGioitinh,
          //   decoration: InputDecoration(
          //     labelText: 'Giới tính *',
          //     prefixIcon: const Icon(FontAwesomeIcons.venusMars, size: 18),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
          //   items: const [
          //     DropdownMenuItem(value: 0, child: Text('Nữ')),
          //     DropdownMenuItem(value: 1, child: Text('Nam')),
          //   ],
          //   onChanged: (value) {
          //     setState(() {
          //       _selectedGioitinh = value;
          //       _updateFormData();
          //     });
          //   },
          //   validator: (value) {
          //     if (value == null) {
          //       return 'Vui lòng chọn giới tính';
          //     }
          //     return null;
          //   },
          // ),
          const SizedBox(height: 16),

          // Trình độ học vấn
          GenericPicker<TrinhDoHocVan>(
            label: 'Trình độ học vấn',
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

          // Ngoại ngữ
          GenericPicker<NgoaiNgu>(
            label: 'Ngoại ngữ',
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

          // Email
          CustomTextField(
            controller: _emailController,
            labelText: 'Email *',
            hintText: 'Nhập địa chỉ email',
            prefixIcon: const Icon(FontAwesomeIcons.envelope, size: 18),
            keyboardType: TextInputType.emailAddress,
            validator: 'email',
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Số điện thoại
          CustomTextField(
            controller: _dienthoaiController,
            labelText: 'Số điện thoại *',
            hintText: 'Nhập số điện thoại',
            prefixIcon: const Icon(FontAwesomeIcons.phone, size: 18),
            keyboardType: TextInputType.phone,
            validator: 'phone',
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
          CustomTextField(
            controller: _soCmndController,
            labelText: 'Số CMND/CCCD *',
            hintText: 'Nhập số CMND hoặc CCCD',
            prefixIcon: const Icon(FontAwesomeIcons.idCard, size: 18),
            keyboardType: TextInputType.number,
            validator: 'not_empty',
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Ngày cấp
          CustomPickDateTimeGrok(
            labelText: 'Ngày cấp',
            hintText: 'Chọn ngày cấp',
            prefixIcon: const Icon(FontAwesomeIcons.calendar, size: 18),
            initialValue: widget.formData.dkxkldNgaycap,
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _selectedNgaycap = DateTime.parse(value);
                } else {
                  _selectedNgaycap = null;
                }
                _updateFormData();
              });
            },
          ),
          const SizedBox(height: 16),

          // Nơi cấp
          CustomTextField(
            controller: _noicapController,
            labelText: 'Nơi cấp',
            hintText: 'Nhập nơi cấp CMND/CCCD',
            prefixIcon: const Icon(FontAwesomeIcons.locationDot, size: 18),
            onChanged: (_) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Số hộ chiếu
          CustomTextField(
            controller: _sohochieuController,
            labelText: 'Số hộ chiếu',
            hintText: 'Nhập số hộ chiếu (nếu có)',
            prefixIcon: const Icon(FontAwesomeIcons.passport, size: 18),
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
                ? locator<List<DanToc>>()
                    .firstWhere(
                      (item) => item.displayName == _selectedDantoc,
                      orElse: () => locator<List<DanToc>>().first,
                    )
                    .id
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
                ? locator<List<TonGiao>>()
                    .firstWhere(
                      (item) => item.displayName == _selectedTongiao,
                      orElse: () => locator<List<TonGiao>>().first,
                    )
                    .id
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
    _soCmndController.dispose();
    _noicapController.dispose();
    _sohochieuController.dispose();
    super.dispose();
  }
}
