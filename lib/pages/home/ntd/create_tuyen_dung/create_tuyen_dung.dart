import 'package:flutter/material.dart';
import 'package:ttld/blocs/tuyendung/tuyendung_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/do_tuoi_model.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/models/kinh_nghiem_lam_viec.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
import 'package:ttld/widgets/field/custom_pick_datetime_grok.dart';
import 'package:ttld/widgets/field/custom_picker_grok.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/stepper_page.dart';

class CreateTuyenDungPage extends StatefulWidget {
  final Ntd? ntd;
  final NTDTuyenDung? tuyenDung;
  final bool isEdit;
  static const routePath = '/ntd_home/create_tuyen_dung';
  const CreateTuyenDungPage({
    super.key,
    this.ntd,
    this.tuyenDung,
    this.isEdit = false,
  });

  @override
  State<CreateTuyenDungPage> createState() => _CreateTuyenDungPageState();
}

class _CreateTuyenDungPageState extends State<CreateTuyenDungPage> {
  final Map<int, GlobalKey<FormState>> _formKeys = {
    0: GlobalKey<FormState>(),
    1: GlobalKey<FormState>(),
    2: GlobalKey<FormState>(),
  };
  final TextEditingController _nganhKhacController = TextEditingController();
  final TextEditingController _luongKhoiDiemController =
      TextEditingController();
  final TextEditingController _soLuongTuyenController = TextEditingController();
  final TextEditingController _quyenLoiController = TextEditingController();
  final TextEditingController _moTaCongViecController =
      TextEditingController(text: 'Làm việc đúng chuyên môn kỹ thuật');

  final TextEditingController _tdTieudeController = TextEditingController();
  final TextEditingController _tdChucDanhController = TextEditingController();
  final TextEditingController _tdNganhkhacController = TextEditingController();
  final TextEditingController _tdSoluongController = TextEditingController();
  final TextEditingController _tdMotacongviecController =
      TextEditingController();
  final TextEditingController _tdQuyenloiController = TextEditingController(
      text:
          'CHI TIẾT VUI LÒNG LIÊN HỆ Trung Tâm Dịch Vụ Việc Làm Bình Định - Số 215 Trần Hưng Đạo, TP. Quy Nhơn, tỉnh Bình Định. Điện Thoại: (0256) 3 646 509. Fax: (0256) 3 646 509. Email: pvl@vieclambinhdinh.gov.vn');
  final TextEditingController _tdGhichuController = TextEditingController(
      text:
          'Đơn xin việc, sơ yếu lý lịch, bản photo giấy khám sức khỏe, hộ khẩu, CMND, bằng cấp có liên quan và 1 ảnh (3x4): ghi thông tin: Họ tên, ngày tháng năm sinh, nơi sinh, trình độ … mặt sau ảnh.');
  final TextEditingController _tdLuongkhoidiemController =
      TextEditingController();
  final TextEditingController _tdNoinophosoController =
      TextEditingController(text: 'TRUNG TÂM DỊCH VỤ VIỆC LÀM BÌNH ĐỊNH');
  final TextEditingController _tdHosobaogomController = TextEditingController(
      text:
          'Đơn xin việc, sơ yếu lý lịch, bản photo giấy khám sức khỏe, hộ khẩu, CMND, bằng cấp có liên quan và 1 ảnh (3x4): ghi thông tin: Họ tên, ngày tháng năm sinh, nơi sinh, trình độ … mặt sau ảnh.');
  final TextEditingController _tdYeuCauChieuCaoController =
      TextEditingController();
  final TextEditingController _tdYeucauKinhnghiemController =
      TextEditingController();
  final TextEditingController _tdYeucauTuoiMinController =
      TextEditingController();
  final TextEditingController _tdYeucauTuoiMaxController =
      TextEditingController();
  final TextEditingController _doanhNghiepYeuCauController =
      TextEditingController();
  final TextEditingController _idKynangController = TextEditingController();
  final TextEditingController _idHinhthucLvController = TextEditingController();
  final TextEditingController _tdYeuCauNgoaiNguController =
      TextEditingController();
  final TextEditingController _tdMotayeucauController = TextEditingController();

  late NTDTuyenDung _tuyenDungData = widget.tuyenDung ??
      NTDTuyenDung(
        idTuyenDung: null,
        tdTieude: '',
        tdChucDanh: 0,
        tdNganhkhac: '',
        tdSoluong: 0,
        tdMotacongviec: '',
        tdMotayeucau: '',
        tdQuyenloi: '',
        tdGhichu: '',
        tdLuongkhoidiem: 0,
        ngayNhanHoSo: '',
        ngayHetNhanHoSo: '',
        isDenKhiTuyenXong: true,
        tdNoinophoso: '',
        tdHosobaogom: '',
        tdYeuCauChieuCao: 0,
        tdYeucauKinhnghiem: 0,
        tdYeucauTuoiMin: 0,
        tdYeucauTuoiMax: 0,
        tdLanxem: 0,
        tdDuyet: false,
        createdDate: DateTime.now(),
        createdBy: '',
        modifiredDate: DateTime.now(),
        modifiredBy: '',
        tdId: null,
        tdIdDoanhnghiep: widget.ntd?.idDoanhNghiep ?? '',
        nguonThuThap: '',
        soLuongDat: 0,
        soLuongKhongDat: 0,
        soLuongChoKetQua: 0,
        idMucLuong: 0,
        idDoTuoi: 0,
        doanhNghiepYeuCau: '',
        idDoituongCs: 0,
        idphieut11: null,
        idDoanhNghiep: widget.ntd?.idDoanhNghiep ?? '',
        tdNoilamviec: 0,
        tdNganhnghe: 0,
        tdYeuCauHocVan: 0,
        tdThoigianlamviec: 0,
        idKinhnghiem: null,
        idBacHoc: null,
        idKynang: null,
        idHinhthucLv: null,
        tdYeuCauTinHoc: null,
        tdYeuCauNgoaiNgu: null,
        tdYeuCauGioiTinh: 0,
        maHoso: null,
        nguoiLienhe: '',
        soDienthoai: '',
        diaChiDn: '',
        tenDoanhNghiep: '',
        noiLamviec: '',
        tenNganhnghe: '',
        mucLuong: '',
      );

  List<String> steps = [
    'Thông tin\ntuyển dụng',
    'Yêu cầu\ntuyển dụng',
    'Thông tin\nhồ sơ',
  ];

  @override
  void initState() {
    super.initState();
    print('CreateTuyenDungPage initState');
    print('Received NTD: ${widget.ntd?.idDoanhNghiep} - ${widget.ntd?.ntdTen}');

    final idDoanhNghiep = widget.ntd?.idDoanhNghiep;
    print('idDoanhNghiep: $idDoanhNghiep');

    if (widget.ntd == null || idDoanhNghiep == null || idDoanhNghiep.isEmpty) {
      print('Invalid NTD data in CreateTuyenDungPage');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng đăng nhập lại để tạo bài tuyển dụng.'),
            backgroundColor: Colors.red,
          ),
        );
      });
      return;
    }

    if (widget.tuyenDung != null) {
      print('Initializing from existing tuyenDung data');
      _tuyenDungData = widget.tuyenDung!;
      _initializeControllersFromData();
    } else {
      print(
          'Initializing new tuyenDung data with idDoanhNghiep: $idDoanhNghiep');
    }
  }

  void _initializeControllersFromData() {
    _tdTieudeController.text = _tuyenDungData.tdTieude ?? '';
    _tdChucDanhController.text = _tuyenDungData.tdChucDanh?.toString() ?? '';
    _tdNganhkhacController.text = _tuyenDungData.tdNganhkhac ?? '';
    _tdSoluongController.text = _tuyenDungData.tdSoluong?.toString() ?? '';
    _tdMotacongviecController.text = _tuyenDungData.tdMotacongviec ?? '';
    _tdMotayeucauController.text = _tuyenDungData.tdMotayeucau ?? '';
    _tdQuyenloiController.text = _tuyenDungData.tdQuyenloi ?? '';
    _tdGhichuController.text = _tuyenDungData.tdGhichu ?? '';
    _tdLuongkhoidiemController.text =
        _tuyenDungData.tdLuongkhoidiem?.toString() ?? '';
    _tdNoinophosoController.text = _tuyenDungData.tdNoinophoso ?? '';
    _tdHosobaogomController.text = _tuyenDungData.tdHosobaogom ?? '';
    _tdYeuCauChieuCaoController.text =
        _tuyenDungData.tdYeuCauChieuCao?.toString() ?? '';
    _tdYeucauKinhnghiemController.text =
        _tuyenDungData.tdYeucauKinhnghiem?.toString() ?? '';
    _tdYeucauTuoiMinController.text =
        _tuyenDungData.tdYeucauTuoiMin?.toString() ?? '';
    _tdYeucauTuoiMaxController.text =
        _tuyenDungData.tdYeucauTuoiMax?.toString() ?? '';
    _doanhNghiepYeuCauController.text = _tuyenDungData.doanhNghiepYeuCau ?? '';
    _idKynangController.text = _tuyenDungData.idKynang ?? '';
    _idHinhthucLvController.text = _tuyenDungData.idHinhthucLv ?? '';
    _tdYeuCauNgoaiNguController.text = _tuyenDungData.tdYeuCauNgoaiNgu ?? '';
  }

  void _updateTuyenDungData() {
    _tuyenDungData = _tuyenDungData.copyWith(
      tdTieude: _tdTieudeController.text,
      tdChucDanh: int.tryParse(_tdChucDanhController.text) ?? 0,
      tdNganhkhac: _tdNganhkhacController.text,
      tdSoluong: int.tryParse(_tdSoluongController.text) ?? 0,
      tdMotacongviec: _tdMotacongviecController.text,
      tdMotayeucau: _tdMotayeucauController.text,
      tdQuyenloi: _tdQuyenloiController.text,
      tdGhichu: _tdGhichuController.text,
      tdLuongkhoidiem: int.tryParse(_tdLuongkhoidiemController.text) ?? 0,
      tdNoinophoso: _tdNoinophosoController.text,
      tdHosobaogom: _tdHosobaogomController.text,
      tdYeuCauChieuCao: int.tryParse(_tdYeuCauChieuCaoController.text) ?? 0,
      tdYeucauKinhnghiem: int.tryParse(_tdYeucauKinhnghiemController.text) ?? 0,
      tdYeucauTuoiMin: int.tryParse(_tdYeucauTuoiMinController.text) ?? 0,
      tdYeucauTuoiMax: int.tryParse(_tdYeucauTuoiMaxController.text) ?? 0,
      doanhNghiepYeuCau: _doanhNghiepYeuCauController.text,
      idKynang:
          _idKynangController.text.isEmpty ? null : _idKynangController.text,
      idHinhthucLv: _idHinhthucLvController.text.isEmpty
          ? null
          : _idHinhthucLvController.text,
      tdYeuCauNgoaiNgu: _tdYeuCauNgoaiNguController.text.isEmpty
          ? null
          : _tdYeuCauNgoaiNguController.text,
      idDoanhNghiep: widget.ntd?.idDoanhNghiep ?? '',
      tdIdDoanhnghiep: widget.ntd?.idDoanhNghiep ?? '',
      createdDate: DateTime.now(),
      modifiredDate: DateTime.now(),
      tdDuyet: false,
      tdLanxem: 0,
      ngayNhanHoSo: DateTime.now().toIso8601String(),
      ngayHetNhanHoSo:
          DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      isDenKhiTuyenXong: true,
    );
  }

  bool _validateForms() {
    bool isValid = true;
    List<String> missingFields = [];

    // Validate each form that is currently built
    for (var entry in _formKeys.entries) {
      final formKey = entry.value;
      if (formKey.currentState == null) {
        print('Form ${entry.key} is not built yet');
        continue;
      }

      if (!formKey.currentState!.validate()) {
        print('Form ${entry.key} validation failed');
        isValid = false;
      }
    }

    // Check text fields
    if (_tdTieudeController.text.isEmpty)
      missingFields.add('Tiêu đề tuyển dụng');
    if (_tdChucDanhController.text.isEmpty)
      missingFields.add('Vị trí tuyển dụng');
    if (_tdSoluongController.text.isEmpty) missingFields.add('Số lượng tuyển');
    if (_tdLuongkhoidiemController.text.isEmpty)
      missingFields.add('Lương khởi điểm');
    if (_tdMotacongviecController.text.isEmpty)
      missingFields.add('Mô tả công việc');
    if (_tdQuyenloiController.text.isEmpty) missingFields.add('Quyền lợi');
    if (_tdNoinophosoController.text.isEmpty)
      missingFields.add('Nơi nộp hồ sơ');
    if (_tdHosobaogomController.text.isEmpty)
      missingFields.add('Hồ sơ bao gồm');

    // Check picker fields
    if (_tuyenDungData.tdNganhnghe == null || _tuyenDungData.tdNganhnghe == 0) {
      missingFields.add('Ngành nghề');
    }
    if (_tuyenDungData.tdNoilamviec == null ||
        _tuyenDungData.tdNoilamviec == 0) {
      missingFields.add('Nơi làm việc');
    }
    if (_tuyenDungData.tdThoigianlamviec == null ||
        _tuyenDungData.tdThoigianlamviec == 0) {
      missingFields.add('Thời gian làm việc');
    }
    if (_tuyenDungData.tdYeuCauHocVan == null ||
        _tuyenDungData.tdYeuCauHocVan == 0) {
      missingFields.add('Trình độ học vấn');
    }
    if (_tuyenDungData.idBacHoc == null || _tuyenDungData.idBacHoc == '') {
      missingFields.add('Trình độ chuyên môn');
    }
    if (_tuyenDungData.tdYeuCauTinHoc == null ||
        _tuyenDungData.tdYeuCauTinHoc == '') {
      missingFields.add('Trình độ tin học');
    }
    if (_tuyenDungData.idKinhnghiem == null ||
        _tuyenDungData.idKinhnghiem == '') {
      missingFields.add('Kinh nghiệm làm việc');
    }

    if (missingFields.isNotEmpty) {
      print('Missing fields: ${missingFields.join(', ')}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Vui lòng điền đầy đủ thông tin: ${missingFields.join(', ')}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      isValid = false;
    }

    return isValid;
  }

  void _submitForm() {
    print('Submitting form...');
    print('Title: ${_tdTieudeController.text}');
    print('Position: ${_tdChucDanhController.text}');
    print('Industry: ${_tuyenDungData.tdNganhnghe}');
    print('Location: ${_tuyenDungData.tdNoilamviec}');
    print('Working time: ${_tuyenDungData.tdThoigianlamviec}');
    print('Education: ${_tuyenDungData.tdYeuCauHocVan}');
    print('Professional level: ${_tuyenDungData.idBacHoc}');
    print('IT skills: ${_tuyenDungData.tdYeuCauTinHoc}');
    print('Work experience: ${_tuyenDungData.idKinhnghiem}');
    print('Skills: ${_tuyenDungData.idKynang}');
    print('Work form: ${_tuyenDungData.idHinhthucLv}');
    print('Employer ID: ${widget.ntd?.idDoanhNghiep}');

    if (!_validateForms()) {
      return;
    }

    _updateTuyenDungData();

    final bloc = locator<TuyenDungBloc>();
    if (widget.isEdit) {
      bloc.add(TuyenDungEvent.update(_tuyenDungData));
    } else {
      bloc.add(TuyenDungEvent.create(_tuyenDungData));
    }

    // Wait for the creation to complete and refresh the list
    Future.delayed(const Duration(milliseconds: 500), () {
      bloc.add(TuyenDungEvent.fetchList(widget.ntd?.idDoanhNghiep));
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Chỉnh sửa tuyển dụng' : 'Thêm tuyển dụng mới',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: theme.colorScheme.surface,
        scrolledUnderElevation: 1.0,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withAlpha(100),
              theme.colorScheme.surface.withOpacity(0.8),
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: StepperPage(
            steps: steps,
            stepContents: [_buildStep1(), _buildStep2(), _buildStep3()],
            onSubmit: _submitForm,
            submitButtonText: widget.isEdit ? 'Cập nhật' : 'Tạo mới',
            backgroundColor: Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    final theme = Theme.of(context);
    return Form(
      key: _formKeys[0],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormSection(
            theme,
            'Thông tin cơ bản',
            [
              CustomTextField(
                labelText: 'Tiêu đề tuyển dụng',
                controller: _tdTieudeController,
                hintText: 'Nhập tiêu đề tuyển dụng',
                validator: 'not_empty',
                onChanged: (value) => _updateTuyenDungData(),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Vị trí tuyển dụng',
                controller: _tdChucDanhController,
                hintText: 'Nhập vị trí tuyển dụng',
                validator: 'not_empty',
                onChanged: (value) => _updateTuyenDungData(),
              ),
              const SizedBox(height: 16),
              CustomPickerGrok<NganhNgheTD>(
                label: Text('Ngành nghề tuyển dụng *'),
                selectedItem: () {
                  try {
                    final nganhNgheList = locator<List<NganhNgheTD>>();
                    return nganhNgheList.firstWhere(
                      (e) => e.id == _tuyenDungData.tdNganhnghe,
                      orElse: () => NganhNgheTD(id: 0, name: 'Chọn ngành nghề'),
                    );
                  } catch (e) {
                    return NganhNgheTD(id: 0, name: 'Chọn ngành nghề');
                  }
                }(),
                items: () {
                  try {
                    return locator<List<NganhNgheTD>>();
                  } catch (e) {
                    return <NganhNgheTD>[];
                  }
                }(),
                onChanged: (NganhNgheTD? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    tdNganhnghe: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (NganhNgheTD? value) =>
                    '${value?.displayName}',
                validator: (NganhNgheTD? value) {
                  if (value == null || value.id == 0)
                    return 'Chọn ngành nghề tuyển dụng';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Ngành khác',
                controller: _tdNganhkhacController,
                hintText: 'Nhập ngành khác nếu có',
                onChanged: (value) => _updateTuyenDungData(),
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Địa điểm và thời gian',
            [
              CustomPickerGrok<TinhThanhModel>(
                label: Text('Nơi làm việc *'),
                selectedItem: locator<List<TinhThanhModel>>().firstWhere(
                  (e) => e.id == _tuyenDungData.tdNoilamviec,
                  orElse: () =>
                      TinhThanhModel(tpId: 0, tpTen: 'Chọn nơi làm việc'),
                ),
                items: locator<List<TinhThanhModel>>(),
                onChanged: (TinhThanhModel? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    tdNoilamviec: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (TinhThanhModel? value) =>
                    '${value?.displayName}',
                validator: (TinhThanhModel? value) {
                  if (value == null || value.id == 0)
                    return 'Chọn nơi làm việc';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomPickerGrok<ThoiGianLamViec>(
                label: Text('Thời gian làm việc *'),
                selectedItem: locator<List<ThoiGianLamViec>>().firstWhere(
                  (e) => e.id == _tuyenDungData.tdThoigianlamviec,
                  orElse: () => ThoiGianLamViec(
                    id: 0,
                    name: 'Chọn thời gian',
                    idhinhthuclamviec: '0',
                    displayOrder: 0,
                    status: true,
                  ),
                ),
                items: locator<List<ThoiGianLamViec>>(),
                onChanged: (ThoiGianLamViec? value) {
                  if (value == null) return;
                  _tuyenDungData = _tuyenDungData.copyWith(
                    tdThoigianlamviec: value.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (ThoiGianLamViec? value) =>
                    '${value?.displayName}',
                validator: (ThoiGianLamViec? value) {
                  if (value == null || value.id == 0) return 'Chọn thời gian';
                  return null;
                },
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thông tin lương và số lượng',
            [
              CustomTextField.numberGrok(
                labelText: 'Lương khởi điểm',
                controller: _tdLuongkhoidiemController,
                hintText: 'Lương khởi điểm',
                validator: 'not_empty',
                onChanged: (value) => _updateTuyenDungData(),
              ),
              const SizedBox(height: 16),
              CustomTextField.numberGrok(
                labelText: 'Số lượng tuyển',
                controller: _tdSoluongController,
                hintText: 'Số lượng tuyển',
                validator: 'not_empty',
                onChanged: (value) => _updateTuyenDungData(),
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Mô tả và quyền lợi',
            [
              CustomTextField.textArea(
                labelText: 'Quyền lợi',
                hintText: 'Ví dụ: bảo hiểm, chế độ, phúc lợi',
                controller: _tdQuyenloiController,
                validator: 'not_empty',
                onChanged: (value) => _updateTuyenDungData(),
              ),
              const SizedBox(height: 16),
              CustomTextField.textArea(
                labelText: 'Mô tả công việc',
                controller: _tdMotacongviecController,
                validator: 'not_empty',
                onChanged: (value) => _updateTuyenDungData(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    final theme = Theme.of(context);
    return Form(
      key: _formKeys[1],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormSection(
            theme,
            'Yêu cầu học vấn',
            [
              CustomPickerGrok<TrinhDoHocVan>(
                label: Text('Trình độ văn hóa'),
                selectedItem: null,
                items: locator<List<TrinhDoHocVan>>(),
                onChanged: (TrinhDoHocVan? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    tdYeuCauHocVan: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (TrinhDoHocVan? value) =>
                    '${value?.displayName}',
                validator: (TrinhDoHocVan? value) {
                  if (value == null) return 'Chọn trình độ văn hóa';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomPickerGrok<TrinhDoChuyenMon>(
                label: Text('Trình độ chuyên môn'),
                selectedItem: null,
                items: locator<List<TrinhDoChuyenMon>>(),
                onChanged: (TrinhDoChuyenMon? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    idBacHoc: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (TrinhDoChuyenMon? value) =>
                    '${value?.displayName}',
                validator: (TrinhDoChuyenMon? value) {
                  if (value == null) return 'Chọn trình độ chuyên môn';
                  return null;
                },
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Yêu cầu kỹ năng',
            [
              CustomPickerGrok<TrinhDoTinHoc>(
                label: Text('Trình độ tin học'),
                selectedItem: null,
                items: locator<List<TrinhDoTinHoc>>(),
                onChanged: (TrinhDoTinHoc? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    tdYeuCauTinHoc: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (TrinhDoTinHoc? value) =>
                    '${value?.displayName}',
                validator: (TrinhDoTinHoc? value) {
                  if (value == null) return 'Chọn trình độ tin học';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomPickerGrok<KinhNghiemLamViec>(
                label: Text('Kinh nghiệm làm việc'),
                selectedItem: null,
                items: locator<List<KinhNghiemLamViec>>(),
                onChanged: (KinhNghiemLamViec? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    idKinhnghiem: value?.id.toString(),
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (KinhNghiemLamViec? value) =>
                    '${value?.displayName}',
                validator: (KinhNghiemLamViec? value) {
                  if (value == null) return 'Chọn kinh nghiệm';
                  return null;
                },
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Yêu cầu cá nhân',
            [
              CustomPickerMap(
                label: Text('Giới tính'),
                items: gioiTinhOptions,
                selectedItem: -1,
                onChanged: (gioiTinh) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    tdYeuCauGioiTinh: gioiTinh!,
                  );
                  _updateTuyenDungData();
                },
              ),
              const SizedBox(height: 16),
              CustomTextField.numberGrok(
                labelText: 'Chiều cao (cm)',
                controller: _tdYeuCauChieuCaoController,
                hintText: 'Nhập chiều cao yêu cầu',
                onChanged: (value) => _updateTuyenDungData(),
              ),
              const SizedBox(height: 16),
              CustomPickerGrok<DoTuoi>(
                label: Text('Độ tuổi'),
                selectedItem: null,
                items: locator<List<DoTuoi>>(),
                onChanged: (DoTuoi? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    idDoTuoi: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (DoTuoi? value) => '${value?.displayName}',
                validator: (DoTuoi? value) {
                  if (value == null) return 'Chọn độ tuổi';
                  return null;
                },
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thông tin bổ sung',
            [
              CustomPickerGrok<DoiTuong>(
                label: Text('Đối tượng chính sách'),
                selectedItem: null,
                items: locator<List<DoiTuong>>(),
                onChanged: (DoiTuong? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    idDoituongCs: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (DoiTuong? value) =>
                    '${value?.displayName}',
                validator: (DoiTuong? value) {
                  if (value == null) return 'Chọn đối tượng';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomPickerGrok<MucLuongMM>(
                label: Text('Mức lương'),
                selectedItem: null,
                items: locator<List<MucLuongMM>>(),
                onChanged: (MucLuongMM? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    idMucLuong: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (MucLuongMM? value) =>
                    '${value?.displayName}',
                validator: (MucLuongMM? value) {
                  if (value == null) return 'Chọn mức lương';
                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    final theme = Theme.of(context);
    return Form(
      key: _formKeys[2],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormSection(
            theme,
            'Thời gian nhận hồ sơ',
            [
              CustomPickDateTimeGrok(
                labelText: 'Ngày bắt đầu nhận hồ sơ',
                onChanged: (value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    ngayNhanHoSo: value!,
                  );
                  _updateTuyenDungData();
                },
              ),
              const SizedBox(height: 16),
              CustomPickDateTimeGrok(
                labelText: 'Ngày kết thúc nhận hồ sơ',
                onChanged: (value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    ngayHetNhanHoSo: value!,
                  );
                  _updateTuyenDungData();
                },
              ),
              const SizedBox(height: 16),
              CustomCheckbox(
                label: 'Đến khi tuyển xong',
                onChanged: (bool? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    isDenKhiTuyenXong: value!,
                  );
                  _updateTuyenDungData();
                },
                value: _tuyenDungData.isDenKhiTuyenXong ?? true,
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thông tin nộp hồ sơ',
            [
              CustomTextField(
                labelText: 'Nơi nộp hồ sơ',
                hintText: 'Địa chỉ nộp hồ sơ',
                controller: _tdNoinophosoController,
                validator: 'not_empty',
                onChanged: (value) => _updateTuyenDungData(),
              ),
              const SizedBox(height: 16),
              CustomTextField.textArea(
                labelText: 'Hồ sơ bao gồm',
                hintText: 'Danh sách hồ sơ cần nộp',
                controller: _tdHosobaogomController,
                validator: 'not_empty',
                onChanged: (value) => _updateTuyenDungData(),
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Ghi chú bổ sung',
            [
              CustomTextField.textArea(
                labelText: 'Ghi chú',
                hintText: 'Ghi chú bổ sung',
                controller: _tdGhichuController,
                onChanged: (value) => _updateTuyenDungData(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(
      ThemeData theme, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader(theme, title),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
