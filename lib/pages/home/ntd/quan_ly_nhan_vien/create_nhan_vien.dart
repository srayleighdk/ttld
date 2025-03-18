import 'package:flutter/material.dart';
import 'package:ttld/bloc/tuyendung/tuyendung_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/nhanvien/nhanvien_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
import 'package:ttld/widgets/field/custom_pick_datetime_grok.dart';
import 'package:ttld/widgets/field/custom_picker_grok.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/stepper_page.dart';

class CreateNhanVien extends StatefulWidget {
  final NhanVien? nhanVien;
  final bool isEdit;
  static const String routePath = '/create_nhan_vien';

  const CreateNhanVien({super.key, this.nhanVien, this.isEdit = false});

  @override
  State<CreateNhanVien> createState() => _CreateNhanVienState();
}

class _CreateNhanVienState extends State<CreateNhanVien> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _hoTenController = TextEditingController();
  final TextEditingController _ngaySinhController = TextEditingController();
  final TextEditingController _soCmndController = TextEditingController();
  final TextEditingController _masoBhxhController = TextEditingController();
  final TextEditingController _mucluongchinhController = TextEditingController();
  final TextEditingController _mucluongBhtnController = TextEditingController();
  final TextEditingController _thoigianBhtnController = TextEditingController();
  final TextEditingController _ghichuController = TextEditingController();

  late NhanVien _nhanVienData = widget.nhanVien ?? NhanVien();

  @override
  void initState() {
    super.initState();
    _hoTenController.text = _nhanVienData.hoten ?? '';
    _soCmndController.text = _nhanVienData.soCmnd ?? '';
    _masoBhxhController.text = _nhanVienData.masoBhxh ?? '';
    _mucluongchinhController.text = _nhanVienData.mucluongchinh?.toString() ?? '';
    _mucluongBhtnController.text = _nhanVienData.mucluongBhtn?.toString() ?? '';
    _thoigianBhtnController.text = _nhanVienData.thoigianBhtn?.toString() ?? '';
    _ghichuController.text = _nhanVienData.ghichu ?? '';
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    _nhanVienData = _nhanVienData.copyWith(
      hoten: _hoTenController.text,
      soCmnd: _soCmndController.text,
      masoBhxh: _masoBhxhController.text,
      mucluongchinh: int.tryParse(_mucluongchinhController.text),
      mucluongBhtn: int.tryParse(_mucluongBhtnController.text),
      thoigianBhtn: int.tryParse(_thoigianBhtnController.text),
      ghichu: _ghichuController.text,
    );

    final bloc = locator<TuyenDungBloc>();
    if (widget.isEdit) {
      bloc.add(TuyenDungEvent.updateNhanVien(_nhanVienData));
    } else {
      bloc.add(TuyenDungEvent.createNhanVien(_nhanVienData));
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Chỉnh sửa nhân viên' : 'Thêm nhân viên mới'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Họ và tên',
                controller: _hoTenController,
                validator: (value) => value!.isEmpty ? 'Nhập họ tên' : null,
              ),
              CustomPickDateTimeGrok(
                labelText: 'Ngày sinh',
                onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                  ngaysinh: value,
                ),
              ),
              CustomPickerMap(
                label: const Text('Giới tính'),
                items: gioiTinhOptions,
                selectedItem: _nhanVienData.idGioitinh ?? -1,
                onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                  idGioitinh: value,
                ),
              ),
              CustomTextField(
                labelText: 'Số CMND',
                controller: _soCmndController,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                labelText: 'Mã số BHXH',
                controller: _masoBhxhController,
                keyboardType: TextInputType.number,
              ),
              CustomPickerGrok<TrinhDoHocVan>(
                label: const Text('Trình độ học vấn'),
                selectedItem: locator<List<TrinhDoHocVan>>().firstWhere(
                  (e) => e.id == _nhanVienData.idBacHoc,
                  orElse: () => TrinhDoHocVan(id: 0, tenTrinhdo: 'Chọn trình độ'),
                ),
                items: locator<List<TrinhDoHocVan>>(),
                onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                  idBacHoc: value?.id,
                ),
              ),
              CustomTextField.numberGrok(
                labelText: 'Mức lương chính',
                controller: _mucluongchinhController,
              ),
              CustomTextField.numberGrok(
                labelText: 'Mức lương BHTN',
                controller: _mucluongBhtnController,
              ),
              CustomTextField.numberGrok(
                labelText: 'Thời gian BHTN',
                controller: _thoigianBhtnController,
              ),
              CustomPickerGrok<TinhThanhModel>(
                label: const Text('Nơi làm việc'),
                selectedItem: locator<List<TinhThanhModel>>().firstWhere(
                  (e) => e.id == _nhanVienData.idDn,
                  orElse: () => TinhThanhModel(tpId: 0, tpTen: 'Chọn nơi làm việc'),
                ),
                items: locator<List<TinhThanhModel>>(),
                onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                  idDn: value?.id,
                ),
              ),
              CustomTextField.textArea(
                labelText: 'Ghi chú',
                controller: _ghichuController,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.isEdit ? 'Cập nhật' : 'Tạo mới'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
