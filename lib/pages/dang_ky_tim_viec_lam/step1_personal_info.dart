import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttld/models/m02tt11/m02tt11_model.dart';
import 'package:ttld/pages/dang_ky_tim_viec_lam/step1_widgets/basic_info_section.dart';
import 'package:ttld/pages/dang_ky_tim_viec_lam/step1_widgets/address_section.dart';
import 'package:ttld/pages/dang_ky_tim_viec_lam/step1_widgets/personal_details_section.dart';
import 'package:ttld/pages/dang_ky_tim_viec_lam/step1_widgets/contact_section.dart';
import 'package:ttld/pages/dang_ky_tim_viec_lam/step1_widgets/consultation_section.dart';

class Step1PersonalInfo extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final M02TT11 formData;
  final Function(M02TT11) onDataChanged;

  const Step1PersonalInfo({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _Step1PersonalInfoState createState() => _Step1PersonalInfoState();
}

class _Step1PersonalInfoState extends State<Step1PersonalInfo> {
  // Basic Info Controllers
  late TextEditingController _iduvController;
  late TextEditingController _hotenController;
  late TextEditingController _soCmndController;
  late TextEditingController _ngaycapController;
  late TextEditingController _noicapController;
  late TextEditingController _ngaysinhController;

  // Personal Details Controllers
  late TextEditingController _masoBhxhController;
  late TextEditingController _mahoGdController;
  late TextEditingController _mahoGiaDinhController;
  late TextEditingController _suckhoeController;
  late TextEditingController _caoController;
  late TextEditingController _nangController;
  late TextEditingController _congViecHienTaiController;

  // Address Controllers
  late TextEditingController _thonHkController;
  late TextEditingController _diachiHkController;
  late TextEditingController _thonTtController;
  late TextEditingController _diachiTtController;

  // Contact Controllers
  late TextEditingController _dienthoaiController;
  late TextEditingController _emailController;
  late TextEditingController _nguoiLienHeController;
  late TextEditingController _hotenNguoiLienHeController;

  // Basic Info State
  int? _selectedGioitinh;
  int? _selectedDantoc;
  int? _selectedTongiao;
  int? _selectedDoituong;
  int? _selectedStatusVieclam;
  bool _xacnhan = false;
  DateTime? _selectedNgaysinh;
  DateTime? _selectedNgaycap;

  // Personal Details State
  bool? _idTtHonNhan;
  int? _idTantat;

  // Address State
  String? _matinhHk;
  String? _mahuyenHk;
  String? _maxaHk;
  int? _idTinhHk;
  int? _idXaHk;
  String? _matinhTt;
  String? _mahuyenTt;
  String? _maxaTt;
  int? _idTinhTt;
  int? _idXaTt;

  // Contact State
  bool _nhanMail = false;
  bool _sms = false;

  // Consultation State (Đăng ký tư vấn)
  bool _chkTuvanCs = false;      // Phúc lợi
  bool _chkTuvanVl = false;      // Việc làm
  bool _chkTuvanDt = false;      // Đào tạo
  bool _chkTuvanBhtn = false;    // BHTN
  bool _chkTuvankhac = false;    // Khác
  late TextEditingController _dKyKhacController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeState();
  }

  void _initializeControllers() {
    // Basic Info
    _iduvController = TextEditingController(text: widget.formData.iduv?.toString() ?? '');
    _hotenController = TextEditingController(text: widget.formData.hoten);
    _soCmndController = TextEditingController(text: widget.formData.soCmnd);
    _ngaycapController = TextEditingController(
      text: widget.formData.ngaycap != null
          ? DateFormat('dd/MM/yyyy').format(widget.formData.ngaycap!)
          : '',
    );
    _noicapController = TextEditingController(text: widget.formData.noicap);
    _ngaysinhController = TextEditingController(
      text: widget.formData.ngaysinh != null
          ? DateFormat('dd/MM/yyyy').format(widget.formData.ngaysinh!)
          : '',
    );

    // Personal Details
    _masoBhxhController = TextEditingController(text: widget.formData.masoBhxh);
    _mahoGdController = TextEditingController(text: widget.formData.mahoGd);
    _mahoGiaDinhController = TextEditingController(text: widget.formData.mahoGd); // Using mahoGd as there's no separate mahoGiaDinh field
    _suckhoeController = TextEditingController(text: widget.formData.suckhoe);
    _caoController = TextEditingController(text: widget.formData.cao?.toString() ?? '');
    _nangController = TextEditingController(text: widget.formData.nang?.toString() ?? '');
    _congViecHienTaiController = TextEditingController(text: widget.formData.congviechientai);

    // Address
    _thonHkController = TextEditingController(text: widget.formData.thonHk);
    _diachiHkController = TextEditingController(text: widget.formData.diachiHk);
    _thonTtController = TextEditingController(text: widget.formData.thonTt);
    _diachiTtController = TextEditingController(text: widget.formData.diachiTt);

    // Contact
    _dienthoaiController = TextEditingController(text: widget.formData.dienthoai);
    _emailController = TextEditingController(text: widget.formData.email);
    _nguoiLienHeController = TextEditingController(text: widget.formData.tenLienhe);
    _hotenNguoiLienHeController = TextEditingController(text: widget.formData.lienHeTimViec);

    // Consultation
    _dKyKhacController = TextEditingController(text: widget.formData.dKyKhac);
  }

  void _initializeState() {
    // Basic Info
    _selectedGioitinh = widget.formData.idGioitinh;
    _selectedDantoc = widget.formData.idDantoc;
    _selectedTongiao = widget.formData.idTongiao;
    _selectedDoituong = widget.formData.idDoituongCs;
    _selectedStatusVieclam = widget.formData.idStatusVieclam;
    _xacnhan = false; // No xacnhan field in model
    _selectedNgaysinh = widget.formData.ngaysinh;
    _selectedNgaycap = widget.formData.ngaycap;

    // Personal Details
    _idTtHonNhan = widget.formData.idTtHonNhan;
    _idTantat = widget.formData.idTantat;

    // Address
    _matinhHk = widget.formData.matinhHk;
    _mahuyenHk = widget.formData.mahuyenHk;
    _maxaHk = widget.formData.maxaHk;
    _idTinhHk = widget.formData.idTinhHk;
    _idXaHk = widget.formData.idXaHk;
    _matinhTt = widget.formData.matinhTt;
    _mahuyenTt = widget.formData.mahuyenTt;
    _maxaTt = widget.formData.maxaTt;
    _idTinhTt = widget.formData.idTinhTt;
    _idXaTt = widget.formData.idXaTt;

    // Contact
    _nhanMail = widget.formData.nhanEMail ?? false;
    _sms = widget.formData.nhanSms ?? false;

    // Consultation
    _chkTuvanCs = widget.formData.chkTuvanCs ?? false;
    _chkTuvanVl = widget.formData.chkTuvanVl ?? false;
    _chkTuvanDt = widget.formData.chkTuvanDt ?? false;
    _chkTuvanBhtn = widget.formData.chkTuvanBhtn ?? false;
    _chkTuvankhac = widget.formData.chkTuvankhac ?? false;
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      // Basic Info
      iduv: _iduvController.text,
      hoten: _hotenController.text,
      soCmnd: _soCmndController.text,
      ngaycap: _selectedNgaycap,
      noicap: _noicapController.text,
      ngaysinh: _selectedNgaysinh,
      idGioitinh: _selectedGioitinh,
      idDantoc: _selectedDantoc,
      idTongiao: _selectedTongiao,
      idDoituongCs: _selectedDoituong,
      idStatusVieclam: _selectedStatusVieclam,

      // Personal Details
      masoBhxh: _masoBhxhController.text,
      mahoGd: _mahoGdController.text,
      suckhoe: _suckhoeController.text,
      cao: int.tryParse(_caoController.text),
      nang: double.tryParse(_nangController.text),
      congviechientai: _congViecHienTaiController.text,
      idTtHonNhan: _idTtHonNhan,
      idTantat: _idTantat,

      // Address
      matinhHk: _matinhHk,
      mahuyenHk: _mahuyenHk,
      maxaHk: _maxaHk,
      idTinhHk: _idTinhHk,
      idXaHk: _idXaHk,
      thonHk: _thonHkController.text,
      diachiHk: _diachiHkController.text,
      matinhTt: _matinhTt,
      mahuyenTt: _mahuyenTt,
      maxaTt: _maxaTt,
      idTinhTt: _idTinhTt,
      idXaTt: _idXaTt,
      thonTt: _thonTtController.text,
      diachiTt: _diachiTtController.text,

      // Contact
      dienthoai: _dienthoaiController.text,
      email: _emailController.text,
      tenLienhe: _nguoiLienHeController.text,
      lienHeTimViec: _hotenNguoiLienHeController.text,
      nhanEMail: _nhanMail,
      nhanSms: _sms,

      // Consultation
      chkTuvanCs: _chkTuvanCs,
      chkTuvanVl: _chkTuvanVl,
      chkTuvanDt: _chkTuvanDt,
      chkTuvanBhtn: _chkTuvanBhtn,
      chkTuvankhac: _chkTuvankhac,
      dKyKhac: _dKyKhacController.text.isEmpty ? null : _dKyKhacController.text,
    );
    widget.onDataChanged(updatedData);
  }

  Future<void> _selectDate(BuildContext context, bool isNgaysinh) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (isNgaysinh ? _selectedNgaysinh : _selectedNgaycap) ?? DateTime(1990),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isNgaysinh) {
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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

              // Basic Info Section
              BasicInfoSection(
                iduvController: _iduvController,
                hotenController: _hotenController,
                soCmndController: _soCmndController,
                ngaycapController: _ngaycapController,
                noicapController: _noicapController,
                ngaysinhController: _ngaysinhController,
                selectedGioitinh: _selectedGioitinh,
                selectedDantoc: _selectedDantoc,
                selectedTongiao: _selectedTongiao,
                selectedDoituong: _selectedDoituong,
                selectedStatusVieclam: _selectedStatusVieclam,
                xacnhan: _xacnhan,
                onGioitinhChanged: (value) {
                  setState(() {
                    _selectedGioitinh = value;
                    _updateFormData();
                  });
                },
                onDantocChanged: (value) {
                  setState(() {
                    _selectedDantoc = value;
                    _updateFormData();
                  });
                },
                onTongiaoChanged: (value) {
                  setState(() {
                    _selectedTongiao = value;
                    _updateFormData();
                  });
                },
                onDoituongChanged: (value) {
                  setState(() {
                    _selectedDoituong = value;
                    _updateFormData();
                  });
                },
                onStatusVieclamChanged: (value) {
                  setState(() {
                    _selectedStatusVieclam = value;
                    _updateFormData();
                  });
                },
                onXacnhanChanged: (value) {
                  setState(() {
                    _xacnhan = value ?? false;
                    _updateFormData();
                  });
                },
                onNgaysinhTap: () => _selectDate(context, true),
                onNgaycapTap: () => _selectDate(context, false),
                onUpdate: _updateFormData,
              ),
              const SizedBox(height: 24),

              // Personal Details Section
              PersonalDetailsSection(
                masoBhxhController: _masoBhxhController,
                mahoGdController: _mahoGdController,
                mahoGiaDinhController: _mahoGiaDinhController,
                suckhoeController: _suckhoeController,
                caoController: _caoController,
                nangController: _nangController,
                congViecHienTaiController: _congViecHienTaiController,
                idTtHonNhan: _idTtHonNhan,
                idTantat: _idTantat,
                onHonNhanChanged: (value) {
                  setState(() {
                    _idTtHonNhan = value;
                    _updateFormData();
                  });
                },
                onTantatChanged: (value) {
                  setState(() {
                    _idTantat = value;
                    _updateFormData();
                  });
                },
                onUpdate: _updateFormData,
              ),
              const SizedBox(height: 24),

              // Address Section
              AddressSection(
                matinhHk: _matinhHk,
                mahuyenHk: _mahuyenHk,
                maxaHk: _maxaHk,
                idTinhHk: _idTinhHk,
                idXaHk: _idXaHk,
                thonHkController: _thonHkController,
                diachiHkController: _diachiHkController,
                matinhTt: _matinhTt,
                mahuyenTt: _mahuyenTt,
                maxaTt: _maxaTt,
                idTinhTt: _idTinhTt,
                idXaTt: _idXaTt,
                thonTtController: _thonTtController,
                diachiTtController: _diachiTtController,
                onPermanentAddressChanged: (tinh, huyen, xa) {
                  setState(() {
                    _matinhHk = tinh;
                    _mahuyenHk = huyen;
                    _maxaHk = xa;
                    _updateFormData();
                  });
                },
                onPermanentAddressNewChanged: (idTinh, idXa) {
                  setState(() {
                    _idTinhHk = idTinh;
                    _idXaHk = idXa;
                    _updateFormData();
                  });
                },
                onTemporaryAddressChanged: (tinh, huyen, xa) {
                  setState(() {
                    _matinhTt = tinh;
                    _mahuyenTt = huyen;
                    _maxaTt = xa;
                    _updateFormData();
                  });
                },
                onTemporaryAddressNewChanged: (idTinh, idXa) {
                  setState(() {
                    _idTinhTt = idTinh;
                    _idXaTt = idXa;
                    _updateFormData();
                  });
                },
                onUpdate: _updateFormData,
              ),
              const SizedBox(height: 24),

              // Contact Section
              ContactSection(
                dienthoaiController: _dienthoaiController,
                emailController: _emailController,
                nguoiLienHeController: _nguoiLienHeController,
                hotenNguoiLienHeController: _hotenNguoiLienHeController,
                nhanMail: _nhanMail,
                sms: _sms,
                onNhanMailChanged: (value) {
                  setState(() {
                    _nhanMail = value ?? false;
                    _updateFormData();
                  });
                },
                onSmsChanged: (value) {
                  setState(() {
                    _sms = value ?? false;
                    _updateFormData();
                  });
                },
                onUpdate: _updateFormData,
              ),
              const SizedBox(height: 24),

              // Consultation Section
              ConsultationSection(
                chkTuvanCs: _chkTuvanCs,
                chkTuvanVl: _chkTuvanVl,
                chkTuvanDt: _chkTuvanDt,
                chkTuvanBhtn: _chkTuvanBhtn,
                chkTuvankhac: _chkTuvankhac,
                dKyKhac: _dKyKhacController.text,
                onChkTuvanCsChanged: (value) {
                  setState(() {
                    _chkTuvanCs = value ?? false;
                    _updateFormData();
                  });
                },
                onChkTuvanVlChanged: (value) {
                  setState(() {
                    _chkTuvanVl = value ?? false;
                    _updateFormData();
                  });
                },
                onChkTuvanDtChanged: (value) {
                  setState(() {
                    _chkTuvanDt = value ?? false;
                    _updateFormData();
                  });
                },
                onChkTuvanBhtnChanged: (value) {
                  setState(() {
                    _chkTuvanBhtn = value ?? false;
                    _updateFormData();
                  });
                },
                onChkTuvankhacChanged: (value) {
                  setState(() {
                    _chkTuvankhac = value ?? false;
                    _updateFormData();
                  });
                },
                onDKyKhacChanged: (value) {
                  _dKyKhacController.text = value;
                  _updateFormData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Basic Info
    _iduvController.dispose();
    _hotenController.dispose();
    _soCmndController.dispose();
    _ngaycapController.dispose();
    _noicapController.dispose();
    _ngaysinhController.dispose();

    // Personal Details
    _masoBhxhController.dispose();
    _mahoGdController.dispose();
    _mahoGiaDinhController.dispose();
    _suckhoeController.dispose();
    _caoController.dispose();
    _nangController.dispose();
    _congViecHienTaiController.dispose();

    // Address
    _thonHkController.dispose();
    _diachiHkController.dispose();
    _thonTtController.dispose();
    _diachiTtController.dispose();

    // Contact
    _dienthoaiController.dispose();
    _emailController.dispose();
    _nguoiLienHeController.dispose();
    _hotenNguoiLienHeController.dispose();

    // Consultation
    _dKyKhacController.dispose();

    super.dispose();
  }
}
