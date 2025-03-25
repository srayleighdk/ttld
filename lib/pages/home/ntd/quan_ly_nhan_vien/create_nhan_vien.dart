import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttld/bloc/biendong/biendong_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/loai_hop_dong_lao_dong_model.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nhanvien/nhanvien_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/tinh_trang_hd_model.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
import 'package:ttld/widgets/field/custom_pick_date_range.dart';
import 'package:ttld/widgets/field/custom_pick_datetime_grok.dart';
import 'package:ttld/widgets/field/custom_picker_grok.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

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
  final TextEditingController _mucluongchinhController =
      TextEditingController();
  final TextEditingController _mucluongBhtnController = TextEditingController();
  final TextEditingController _thoigianBhtnController = TextEditingController();
  final TextEditingController _ghichuController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  late NhanVien _nhanVienData = widget.nhanVien ?? NhanVien();

  @override
  void initState() {
    super.initState();
    _hoTenController.text = _nhanVienData.hoten ?? '';
    _soCmndController.text = _nhanVienData.soCmnd ?? '';
    _masoBhxhController.text = _nhanVienData.masoBhxh ?? '';
    _mucluongchinhController.text =
        _nhanVienData.mucluongchinh?.toString() ?? '';
    _mucluongBhtnController.text = _nhanVienData.mucluongBhtn?.toString() ?? '';
    _thoigianBhtnController.text = _nhanVienData.thoigianBhtn?.toString() ?? '';
    _ghichuController.text = _nhanVienData.ghichu ?? '';
    _startDateController.text = DateFormat('dd/MM/yyyy')
        .format(_nhanVienData.startDate ?? DateTime.now());
    _endDateController.text = DateFormat('dd/MM/yyyy')
        .format(_nhanVienData.endDate ?? DateTime.now());
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

    final bloc = locator<BienDongBloc>();
    if (widget.isEdit) {
      bloc.add(BienDongEvent.update(_nhanVienData));
    } else {
      bloc.add(BienDongEvent.create(_nhanVienData));
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isEdit ? 'Chỉnh sửa nhân viên' : 'Thêm nhân viên mới'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                hintText: '',
                labelText: 'Họ và tên',
                controller: _hoTenController,
                validator: (value) => value!.isEmpty ? 'Nhập họ tên' : null,
              ),
              CustomCheckbox(
                  label: 'Nhân viên mới',
                  value: _nhanVienData.chkNhanvienmoi ?? false,
                  onChanged: (value) {
                    setState(() {
                      _nhanVienData = _nhanVienData.copyWith(
                        chkNhanvienmoi: value,
                      );
                    });
                  }),
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
                hintText: '',
                labelText: 'Số CMND',
                controller: _soCmndController,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                hintText: '',
                labelText: 'Mã số BHXH',
                controller: _masoBhxhController,
                keyboardType: TextInputType.number,
              ),
              CustomPickerGrok<NganhNgheBacHoc>(
                label: const Text('Trình độ học vấn'),
                selectedItem: locator<List<NganhNgheBacHoc>>().firstWhere(
                  (e) => e.id == _nhanVienData.idBacHoc,
                  orElse: () => NganhNgheBacHoc(id: 0, name: 'Chọn trình độ'),
                ),
                items: locator<List<NganhNgheBacHoc>>(),
                onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                  idBacHoc: value?.id,
                ),
                displayItemBuilder: (value) => value!.displayName,
              ),
              Text('Chứng chỉ & bằng cấp:'),
              CustomCheckbox(
                label: 'Không bằng cấp',
                value: _nhanVienData.chkCnktKhongBang ?? false,
                onChanged: (value) {
                  setState(() {
                    _nhanVienData = _nhanVienData.copyWith(
                      chkCnktKhongBang: value,
                    );
                  });
                },
              ),
              CustomCheckbox(
                label: 'Chứng chỉ < 3 tháng',
                value: _nhanVienData.chkCcn3thang ?? false,
                onChanged: (value) {
                  setState(() {
                    _nhanVienData = _nhanVienData.copyWith(
                      chkCcn3thang: value,
                    );
                  });
                },
              ),
              CustomCheckbox(
                label: 'Chứng chỉ nghề sơ cấp',
                value: _nhanVienData.chkCcnSocap ?? false,
                onChanged: (value) {
                  setState(() {
                    _nhanVienData = _nhanVienData.copyWith(
                      chkCcnSocap: value,
                    );
                  });
                },
              ),
              CustomCheckbox(
                label: 'Trung cấp',
                value: _nhanVienData.chkTrungcap ?? false,
                onChanged: (value) {
                  setState(() {
                    _nhanVienData = _nhanVienData.copyWith(
                      chkTrungcap: value,
                    );
                  });
                },
              ),
              CustomCheckbox(
                label: 'Cao đẳng',
                value: _nhanVienData.chkCaodang ?? false,
                onChanged: (value) {
                  setState(() {
                    _nhanVienData = _nhanVienData.copyWith(
                      chkCaodang: value,
                    );
                  });
                },
              ),
              CustomCheckbox(
                label: 'Đại học - sau ĐH',
                value: _nhanVienData.chkDaihocSdh ?? false,
                onChanged: (value) {
                  setState(() {
                    _nhanVienData = _nhanVienData.copyWith(
                      chkDaihocSdh: value,
                    );
                  });
                },
              ),
              CustomPickerGrok<ChucDanhModel>(
                label: const Text('Chuyên môn'),
                selectedItem: locator<List<ChucDanhModel>>().firstWhere(
                  (e) => e.id == _nhanVienData.idChucdanh,
                  orElse: () => ChucDanhModel(id: 0, name: 'Chọn chuyên môn'),
                ),
                items: locator<List<ChucDanhModel>>(),
                onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                  idChucdanh: value?.id,
                ),
                displayItemBuilder: (value) => value!.displayName,
              ),
              CustomPickerGrok<LoaiHopDongLaoDong>(
                label: const Text('Loại hợp đồng'),
                selectedItem: locator<List<LoaiHopDongLaoDong>>().firstWhere(
                  (e) => e.id == _nhanVienData.idLoaiDhld,
                  orElse: () =>
                      LoaiHopDongLaoDong(id: 0, ten: 'Chọn loại hợp đồng'),
                ),
                items: locator<List<LoaiHopDongLaoDong>>(),
                onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                  idLoaiDhld: value?.id,
                ),
                displayItemBuilder: (value) => value!.displayName,
              ),
              CustomPickDateTimeGrok(
                  labelText: 'Ngày HĐ',
                  initialValue: _nhanVienData.ngayHdld,
                  onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                        ngayHdld: value,
                      )),
              CustomPickDateTimeGrok(
                  labelText: 'Ngày HL',
                  initialValue: _nhanVienData.ngayHieuluc,
                  onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                        ngayHieuluc: value,
                      )),
              CustomPickerGrok<TinhTrangHdModel>(
                label: const Text('Tinh trạng HĐ'),
                selectedItem: locator<List<TinhTrangHdModel>>().firstWhere(
                  (e) => e.id == _nhanVienData.idTinhtrangHd,
                  orElse: () =>
                      TinhTrangHdModel(id: 0, name: 'Chọn tình trạng'),
                ),
                items: locator<List<TinhTrangHdModel>>(),
                onChanged: (TinhTrangHdModel? value) {
                  _nhanVienData = _nhanVienData.copyWith(
                    idTinhtrangHd: value?.id,
                  );
                },
                displayItemBuilder: (TinhTrangHdModel? value) {
                  return '${value?.displayName}';
                },
                validator: (TinhTrangHdModel? value) {
                  if (value == null) {
                    return 'Chọn tình trạng';
                  }
                  return null;
                },
              ),
              CustomPickerMap(
                label: const Text('Loại BH'),
                items: loaiBaoHiemOptions,
                selectedItem: _nhanVienData.idLoaiBh ?? 0,
                onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                  idLoaiBh: value,
                ),
              ),
              CustomPickDateTimeGrok(
                  labelText: 'Ngày BH',
                  initialValue: _nhanVienData.ngayBaohiem,
                  onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                        ngayBaohiem: value,
                      )),
              CustomTextField.numberGrok(
                labelText: 'Lương chính',
                controller: _mucluongchinhController,
              ),
              CustomTextField.numberGrok(
                labelText: 'Lương nộp BHTN',
                controller: _mucluongBhtnController,
              ),
              CustomTextField.numberGrok(
                labelText: 'Thời gian BHTN',
                controller: _thoigianBhtnController,
              ),
              CustomDateRangePicker(
                labelText: 'Hưởng BHTN từ ngày',
                initialFromDate: DateTime.now(),
                initialToDate: DateTime.now(),
                onFromDateChanged: (value) => _startDateController.text =
                    DateFormat('dd/MM/yyyy').format(value!),
                onToDateChanged: (value) => _endDateController.text =
                    DateFormat('dd/MM/yyyy').format(value!),
              ),
              CustomPickerGrok<TinhThanhModel>(
                label: const Text('Nơi làm việc'),
                selectedItem: locator<List<TinhThanhModel>>().firstWhere(
                  (e) => e.id == _nhanVienData.idDn,
                  orElse: () =>
                      TinhThanhModel(tpId: 0, tpTen: 'Chọn nơi làm việc'),
                ),
                items: locator<List<TinhThanhModel>>(),
                onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                  idDn: value?.id,
                ),
                displayItemBuilder: (value) => value!.displayName,
              ),
              CustomPickDateTimeGrok(
                  labelText: 'Ngày bắt đầu',
                  initialValue: _nhanVienData.ngayBatdau ?? DateTime.now(),
                  onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                        ngayBatdau: value,
                      )),
              CustomPickDateTimeGrok(
                  labelText: 'Ngày thôi việc',
                  initialValue: _nhanVienData.ngayThoiviec ?? DateTime.now(),
                  onChanged: (value) => _nhanVienData = _nhanVienData.copyWith(
                        ngayThoiviec: value,
                      )),
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
