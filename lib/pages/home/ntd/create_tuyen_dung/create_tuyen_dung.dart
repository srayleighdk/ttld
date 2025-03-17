import 'package:flutter/material.dart';
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
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
import 'package:ttld/widgets/field/custom_pick_datetime_grok.dart';
import 'package:ttld/widgets/field/custom_picker_grok.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/stepper_page.dart';

class CreateTuyenDungPage extends StatefulWidget {
  final Ntd? ntd;
  static const routePath = '/ntd_home/create_tuyen_dung';
  const CreateTuyenDungPage({super.key, this.ntd});

  @override
  State<CreateTuyenDungPage> createState() => _CreateTuyenDungPageState();
}

class _CreateTuyenDungPageState extends State<CreateTuyenDungPage> {
  final TextEditingController _nganhKhacController = TextEditingController();
  final TextEditingController _luongKhoiDiemController =
      TextEditingController();
  final TextEditingController _soLuongTuyenController = TextEditingController();
  final TextEditingController _quyenLoiController = TextEditingController();
  final TextEditingController _moTaCongViecController =
      TextEditingController(text: 'Làm việc đúng chuyên môn kỹ thuật');
  final TextEditingController _tdYeuCauChieuCaoController =
      TextEditingController();
  final TextEditingController _tdMotayeucauController = TextEditingController();
  final TextEditingController _tdNoiNopHoSoController =
      TextEditingController(text: 'TRUNG TÂM DỊCH VỤ VIỆC LÀM BÌNH ĐỊNH');
  final TextEditingController _tdHoSoBaoGomController = TextEditingController(
      text:
          'Đơn xin việc, sơ yếu lý lịch, bản photo giấy khám sức khỏe, hộ khẩu, CMND, bằng cấp có liên quan và 1 ảnh (3x4): ghi thông tin: Họ tên, ngày tháng năm sinh, nơi sinh, trình độ … mặt sau ảnh.');
  final TextEditingController _tdGhiChuController = TextEditingController(
      text:
          'CHI TIẾT VUI LÒNG LIÊN HỆ Trung Tâm Dịch Vụ Việc Làm Bình Định - Số 215 Trần Hưng Đạo, TP. Quy Nhơn, tỉnh Bình Định. Điện Thoại: (0256) 3 646 509. Fax: (0256) 3 646 509. Email: pvl@vieclambinhdinh.gov.vn');
  late NTDTuyenDung _tuyenDungData = NTDTuyenDung(
    idTuyenDung: '',
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
    tdId: '',
    tdIdDoanhnghiep: '',
    nguonThuThap: '',
    soLuongDat: 0,
    soLuongKhongDat: 0,
    soLuongChoKetQua: 0,
    idMucLuong: 0,
    idDoTuoi: 0,
    doanhNghiepYeuCau: '',
    idDoituongCs: 0,
    idphieut11: '',
    idDoanhNghiep: '',
    tdNoilamviec: 0,
    tdNganhnghe: 0,
    tdYeuCauHocVan: 0,
    tdThoigianlamviec: 0,
    idKinhnghiem: '',
    idBacHoc: '',
    idKynang: '',
    idHinhthucLv: '',
    tdYeuCauTinHoc: '',
    tdYeuCauNgoaiNgu: '',
    tdYeuCauGioiTinh: 0,
    maHoso: '',
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm tuyển dụng mới'),
      ),
      body: StepperPage(
          steps: steps,
          stepContents: [_buildStep1(), _buildStep2(), _buildStep3()]),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomPickerGrok<NganhNgheTD>(
            label: Text('Ngành nghề tuyển dụng'),
            selectedItem: null,
            items: locator<List<NganhNgheTD>>(),
            onChanged: (NganhNgheTD? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                tdNganhnghe: value?.id,
              );
            },
            displayItemBuilder: (NganhNgheTD? value) {
              return '${value?.displayName}';
            },
            validator: (NganhNgheTD? value) {
              if (value == null) {
                return 'Chọn ngành nghề tuyển dụng';
              }
              return null;
            },
          ),
          CustomTextField(
            labelText: 'Ngành khác',
            hintText: 'Ngành khác',
            controller: _nganhKhacController,
          ),
          CustomPickerGrok<TinhThanhModel>(
            label: Text('Nơi làm việc'),
            selectedItem: null,
            items: locator<List<TinhThanhModel>>(),
            onChanged: (TinhThanhModel? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                tdNoilamviec: value?.id,
              );
            },
            displayItemBuilder: (TinhThanhModel? value) {
              return '${value?.displayName}';
            },
            validator: (TinhThanhModel? value) {
              if (value == null) {
                return 'Chọn tinh thần hồ';
              }
              return null;
            },
          ),
          CustomPickerGrok<ThoiGianLamViec>(
            label: Text('Thời gian làm việc'),
            selectedItem: null,
            items: locator<List<ThoiGianLamViec>>(),
            onChanged: (ThoiGianLamViec? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                tdThoigianlamviec: value!.id,
              );
            },
            displayItemBuilder: (ThoiGianLamViec? value) {
              return '${value?.displayName}';
            },
            validator: (ThoiGianLamViec? value) {
              if (value == null) {
                return 'Chọn thời gian';
              }
              return null;
            },
          ),
          CustomTextField.numberGrok(
            labelText: 'Lương khởi điểm',
            controller: _luongKhoiDiemController,
            hintText: 'Lương khởi điểm',
          ),
          CustomTextField.numberGrok(
            labelText: 'Số lượng tuyển',
            controller: _soLuongTuyenController,
            hintText: 'Số lượng tuyển',
          ),
          CustomTextField.textArea(
            labelText: 'Quyền lợi',
            hintText: 'Ví dụ: bảo hiểm, chế độ, phúc lợi',
            controller: _quyenLoiController,
          ),
          CustomTextField.textArea(
            labelText: 'Mô tả công việc',
            hintText: 'Ví dụ: bảo hiểm, chế độ, phúc lợi',
            controller: _moTaCongViecController,
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomPickerGrok<TrinhDoNgoaiNgu>(
            label: Text('Yêu cầu ngoại ngữ'),
            selectedItem: null,
            items: locator<List<TrinhDoNgoaiNgu>>(),
            onChanged: (TrinhDoNgoaiNgu? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                tdYeuCauNgoaiNgu: value?.id,
              );
            },
            displayItemBuilder: (TrinhDoNgoaiNgu? value) {
              return '${value?.displayName}';
            },
            validator: (TrinhDoNgoaiNgu? value) {
              if (value == null) {
                return 'Chọn ngoại ngữ';
              }
              return null;
            },
          ),
          CustomPickerGrok<TrinhDoHocVan>(
            label: Text('Yêu cầu trình độ văn hóa'),
            selectedItem: null,
            items: locator<List<TrinhDoHocVan>>(),
            onChanged: (TrinhDoHocVan? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                tdYeuCauHocVan: value?.id,
              );
            },
            displayItemBuilder: (TrinhDoHocVan? value) {
              return '${value?.displayName}';
            },
            validator: (TrinhDoHocVan? value) {
              if (value == null) {
                return 'Chọn trình độ văn hóa';
              }
              return null;
            },
          ),
          CustomPickerMap(
            label: Text('Giới tính'),
            items: gioiTinhOptions,
            selectedItem: -1,
            onChanged: (gioiTinh) {
              _tuyenDungData = _tuyenDungData.copyWith(
                tdYeuCauGioiTinh: gioiTinh!,
              );
            },
          ),
          CustomPickerGrok<TrinhDoTinHoc>(
            label: Text('Yêu cầu trình độ tin học'),
            selectedItem: null,
            items: locator<List<TrinhDoTinHoc>>(),
            onChanged: (TrinhDoTinHoc? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                tdYeuCauTinHoc: value?.id,
              );
            },
            displayItemBuilder: (TrinhDoTinHoc? value) {
              return '${value?.displayName}';
            },
            validator: (TrinhDoTinHoc? value) {
              if (value == null) {
                return 'Chọn trình độ tin học';
              }
              return null;
            },
          ),
          CustomPickerGrok<KinhNghiemLamViec>(
            label: Text('Yêu cầu kinh nghiệm'),
            selectedItem: null,
            items: locator<List<KinhNghiemLamViec>>(),
            onChanged: (KinhNghiemLamViec? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                idKinhnghiem: value?.id,
              );
            },
            displayItemBuilder: (KinhNghiemLamViec? value) {
              return '${value?.displayName}';
            },
            validator: (KinhNghiemLamViec? value) {
              if (value == null) {
                return 'Chọn kinh nghiệm';
              }
              return null;
            },
          ),
          CustomTextField.numberGrok(
            labelText: 'Chiều cao',
            controller: _tdYeuCauChieuCaoController,
            hintText: '(cm)',
          ),
          CustomPickerGrok<DoTuoi>(
            label: Text('Độ tuổi'),
            selectedItem: null,
            items: locator<List<DoTuoi>>(),
            onChanged: (DoTuoi? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                idDoTuoi: value?.id,
              );
            },
            displayItemBuilder: (DoTuoi? value) {
              return '${value?.displayName}';
            },
            validator: (DoTuoi? value) {
              if (value == null) {
                return 'Chọn độ tuổi';
              }
              return null;
            },
          ),
          CustomPickerGrok<NganhNgheBacHoc>(
            label: Text('Trình độ chuyên môn'),
            selectedItem: null,
            items: locator<List<NganhNgheBacHoc>>(),
            onChanged: (NganhNgheBacHoc? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                idBacHoc: value?.id,
              );
            },
            displayItemBuilder: (NganhNgheBacHoc? value) {
              return '${value?.displayName}';
            },
            validator: (NganhNgheBacHoc? value) {
              if (value == null) {
                return 'Chọn bảo hiểm';
              }
              return null;
            },
          ),
          CustomPickerGrok<KinhNghiemLamViec>(
            label: Text('Yêu cầu kinh nghiệm'),
            selectedItem: null,
            items: locator<List<KinhNghiemLamViec>>(),
            onChanged: (KinhNghiemLamViec? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                idKinhnghiem: value?.id,
              );
            },
            displayItemBuilder: (KinhNghiemLamViec? value) {
              return '${value?.displayName}';
            },
            validator: (KinhNghiemLamViec? value) {
              if (value == null) {
                return 'Chọn kinh nghiệm';
              }
              return null;
            },
          ),
          CustomPickerGrok<DoiTuong>(
            label: Text('Đối tượng chính sách'),
            selectedItem: null,
            items: locator<List<DoiTuong>>(),
            onChanged: (DoiTuong? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                idDoituongCs: value?.id,
              );
            },
            displayItemBuilder: (DoiTuong? value) {
              return '${value?.displayName}';
            },
            validator: (DoiTuong? value) {
              if (value == null) {
                return 'Chọn đối tượng';
              }
              return null;
            },
          ),
          CustomPickerGrok<MucLuongMM>(
            label: Text('Mức lương'),
            selectedItem: null,
            items: locator<List<MucLuongMM>>(),
            onChanged: (MucLuongMM? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                idMucLuong: value?.id,
              );
            },
            displayItemBuilder: (MucLuongMM? value) {
              return '${value?.displayName}';
            },
            validator: (MucLuongMM? value) {
              if (value == null) {
                return 'Chọn mức lương';
              }
              return null;
            },
          ),
          CustomTextField.textArea(
            labelText: 'Yêu cầu khác',
            hintText: 'Yêu cầu khác',
            controller: _tdMotayeucauController,
          )
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomPickDateTimeGrok(
            labelText: 'Ngày nhận hồ sơ',
            onChanged: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              ngayNhanHoSo: value!,
            ),
          ),
          CustomPickDateTimeGrok(
            labelText: 'Ngày hết hạn nhận hồ sơ',
            onChanged: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              ngayHetNhanHoSo: value!,
            ),
          ),
          CustomCheckbox(
            label: 'Đến khi tuyển xong',
            onChanged: (bool? value) {
              _tuyenDungData = _tuyenDungData.copyWith(
                isDenKhiTuyenXong: value!,
              );
            },
            value: _tuyenDungData.isDenKhiTuyenXong ?? true,
          ),
          CustomTextField(
            labelText: 'Nơi nộp hồ sơ',
            hintText: '',
            controller: _tdNoiNopHoSoController,
          ),
          CustomTextField.textArea(
            labelText: 'Hồ sơ bao gồm',
            hintText: '',
            controller: _tdHoSoBaoGomController,
          ),
          CustomTextField.textArea(
            labelText: 'Ghi Chú',
            controller: _tdGhiChuController,
          ),
          Text(
              'Lưu ý : Nhà tuyển dụng sau khi đăng ký thông tin tuyển dụng lao động, tuyển sinh đào tạo; Vui lòng đến trực tiếp tại Trung tâm để đăng ký thông tin; Có thể gửi (theo đường bưu điện, Email), hoặc Fax thông tin, để Trung tâm xác nhận thông tin của Nhà tuyển dụng.')
        ],
      ),
    );
  }
}
