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
  late NTDTuyenDung _tuyenDungData = NTDTuyenDung(
    idTuyenDung: '',
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: _buildStepIndicator(),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: PageController(),
                onPageChanged: (index) => setState(() => _currentStep = index),
                children: [
                  _buildStep1(),
                  _buildStep2(),
                  _buildStep3(),
                ],
              ),
            ),
            // const SizedBox(height: 16),
            // _buildStepIndicator(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep != 0)
                    TextButton(
                      onPressed: _cancel,
                      child: const Text('QUAY LẠI'),
                    ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _continue,
                    child: Text(_currentStep == 2 ? 'HOÀN THÀNH' : 'TIẾP TỤC'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double lineWidth = (constraints.maxWidth - 48) / 3;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepCircle(0, "Thông tin", isActive: _currentStep >= 0),
            _buildStepLine(lineWidth, isActive: _currentStep >= 1),
            _buildStepCircle(1, "Yêu cầu", isActive: _currentStep >= 1),
            _buildStepLine(lineWidth, isActive: _currentStep >= 2),
            _buildStepCircle(2, "Hồ sơ", isActive: _currentStep >= 2),
          ],
        );
      },
    );
  }

  Widget _buildStepCircle(int stepNumber, String label,
      {bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${stepNumber + 1}',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(double width, {bool isActive = false}) {
    return Container(
      width: width,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            label: 'Tiêu đề tuyển dụng *',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              tdTieude: value!,
            ),
            validator: (value) =>
                value!.isEmpty ? 'Vui lòng nhập tiêu đề' : null,
          ),
          _buildNumberField(
            label: 'Số lượng cần tuyển *',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              tdSoluong: int.parse(value!),
            ),
          ),
          _buildDatePicker(
            context,
            label: 'Ngày nhận hồ sơ',
            initialDate: _tuyenDungData.ngayNhanHoSo,
            onDateChanged: (date) => _tuyenDungData = _tuyenDungData.copyWith(
              ngayNhanHoSo: date,
            ),
          ),
          _buildDatePicker(
            context,
            label: 'Ngày hết hạn',
            initialDate: _tuyenDungData.ngayHetNhanHoSo,
            onDateChanged: (date) => _tuyenDungData = _tuyenDungData.copyWith(
              ngayHetNhanHoSo: date,
            ),
          ),
          _buildTextField(
            label: 'Ghi chú',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              tdGhichu: value,
            ),
            maxLines: 3,
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
          _buildNumberField(
            label: 'Yêu cầu chiều cao (cm)',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              tdYeuCauChieuCao: int.tryParse(value ?? '0') ?? 0,
            ),
          ),
          _buildNumberField(
            label: 'Kinh nghiệm (năm)',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              tdYeucauKinhnghiem: int.tryParse(value ?? '0') ?? 0,
            ),
          ),
          _buildNumberField(
            label: 'Tuổi tối thiểu',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              tdYeucauTuoiMin: int.tryParse(value ?? '0') ?? 0,
            ),
          ),
          _buildNumberField(
            label: 'Tuổi tối đa',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              tdYeucauTuoiMax: int.tryParse(value ?? '0') ?? 0,
            ),
          ),
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
          _buildTextField(
            label: 'Mã hồ sơ *',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              maHoso: value!,
            ),
          ),
          _buildTextField(
            label: 'Loại hình làm việc',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              idHinhthucLv: value ?? '',
            ),
          ),
          _buildTextField(
            label: 'Yêu cầu học vấn',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              tdYeuCauHocVan: int.tryParse(value ?? '0') ?? 0,
            ),
          ),
          _buildTextField(
            label: 'Mức lương *',
            onSaved: (value) => _tuyenDungData = _tuyenDungData.copyWith(
              mucLuong: value!,
            ),
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
