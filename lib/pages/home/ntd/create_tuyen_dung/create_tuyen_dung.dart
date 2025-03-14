import 'package:flutter/material.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

class CreateTuyenDungPage extends StatefulWidget {
  final Ntd? ntd;
  static const routePath = '/ntd_home/create_tuyen_dung';
  const CreateTuyenDungPage({super.key, this.ntd});

  @override
  State<CreateTuyenDungPage> createState() => _CreateTuyenDungPageState();
}

class _CreateTuyenDungPageState extends State<CreateTuyenDungPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  final NTDTuyenDung _tuyenDungData = NTDTuyenDung(
    tdTieude: '',
    tdChucDanh: 0,
    tdSoluong: 0,
    tdLuongkhoidiem: 0,
    ngayNhanHoSo: DateTime.now(),
    ngayHetNhanHoSo: DateTime.now(),
    isDenKhiTuyenXong: false,
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
    tdIdDoanhnghiep: '',
    nguonThuThap: '',
    soLuongDat: 0,
    soLuongKhongDat: 0,
    soLuongChoKetQua: 0,
    idMucLuong: 0,
    idDoTuoi: 0,
    idDoituongCs: 0,
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

  void _continue() {
    if (_formKey.currentState!.validate()) {
      if (_currentStep < 2) {
        setState(() => _currentStep += 1);
      } else {
        // Submit logic here
        _submitForm();
      }
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    } else {
      Navigator.pop(context);
    }
  }

  void _submitForm() {
    // TODO: Implement submit logic
    print(_tuyenDungData.toJson());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm tuyển dụng mới'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.blue),
        ),
        child: Form(
          key: _formKey,
          child: Stepper(
            currentStep: _currentStep,
            controlsBuilder: (context, details) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    if (_currentStep != 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('QUAY LẠI'),
                      ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(_currentStep == 2 ? 'HOÀN THÀNH' : 'TIẾP TỤC'),
                    ),
                  ],
                ),
              );
            },
            steps: [
              _buildStep1(),
              _buildStep2(),
              _buildStep3(),
            ],
          ),
        ),
      ),
    );
  }

  Step _buildStep1() {
    return Step(
      title: const Text('Thông tin tuyển dụng'),
      content: Column(
        children: [
          _buildTextField(
            label: 'Tiêu đề tuyển dụng *',
            onSaved: (value) => _tuyenDungData.tdTieude = value!,
            validator: (value) => value!.isEmpty ? 'Vui lòng nhập tiêu đề' : null,
          ),
          _buildNumberField(
            label: 'Số lượng cần tuyển *',
            onSaved: (value) => _tuyenDungData.tdSoluong = int.parse(value!),
          ),
          _buildDatePicker(
            context,
            label: 'Ngày nhận hồ sơ',
            initialDate: _tuyenDungData.ngayNhanHoSo,
            onDateChanged: (date) => _tuyenDungData.ngayNhanHoSo = date,
          ),
          _buildDatePicker(
            context,
            label: 'Ngày hết hạn',
            initialDate: _tuyenDungData.ngayHetNhanHoSo,
            onDateChanged: (date) => _tuyenDungData.ngayHetNhanHoSo = date,
          ),
          _buildTextField(
            label: 'Ghi chú',
            onSaved: (value) => _tuyenDungData.tdGhichu = value,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Step _buildStep2() {
    return Step(
      title: const Text('Yêu cầu tuyển dụng'),
      content: Column(
        children: [
          _buildNumberField(
            label: 'Yêu cầu chiều cao (cm)',
            onSaved: (value) => _tuyenDungData.tdYeuCauChieuCao = int.tryParse(value ?? '0') ?? 0,
          ),
          _buildNumberField(
            label: 'Kinh nghiệm (năm)',
            onSaved: (value) => _tuyenDungData.tdYeucauKinhnghiem = int.tryParse(value ?? '0') ?? 0,
          ),
          _buildNumberField(
            label: 'Tuổi tối thiểu',
            onSaved: (value) => _tuyenDungData.tdYeucauTuoiMin = int.tryParse(value ?? '0') ?? 0,
          ),
          _buildNumberField(
            label: 'Tuổi tối đa',
            onSaved: (value) => _tuyenDungData.tdYeucauTuoiMax = int.tryParse(value ?? '0') ?? 0,
          ),
        ],
      ),
    );
  }

  Step _buildStep3() {
    return Step(
      title: const Text('Thông tin hồ sơ'),
      content: Column(
        children: [
          _buildTextField(
            label: 'Mã hồ sơ *',
            onSaved: (value) => _tuyenDungData.maHoso = value!,
            validator: (value) => value!.isEmpty ? 'Vui lòng nhập mã hồ sơ' : null,
          ),
          _buildTextField(
            label: 'Loại hình làm việc',
            onSaved: (value) => _tuyenDungData.idHinhthucLv = value ?? '',
          ),
          _buildTextField(
            label: 'Yêu cầu học vấn',
            onSaved: (value) => _tuyenDungData.tdYeuCauHocVan = int.tryParse(value ?? '0') ?? 0,
          ),
          _buildTextField(
            label: 'Mức lương *',
            onSaved: (value) => _tuyenDungData.mucLuong = value!,
            validator: (value) => value!.isEmpty ? 'Vui lòng nhập mức lương' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String?> onSaved,
    FormFieldValidator<String>? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          isDense: true,
        ),
        maxLines: maxLines,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required FormFieldSetter<String?> onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          isDense: true,
        ),
        keyboardType: TextInputType.number,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildDatePicker(
    BuildContext context, {
    required String label,
    required DateTime initialDate,
    required ValueChanged<DateTime> onDateChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            onDateChanged(pickedDate);
            setState(() {});
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            filled: true,
            isDense: true,
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          child: Text(
            '${initialDate.day}/${initialDate.month}/${initialDate.year}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
