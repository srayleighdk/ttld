import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_repository.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';
import 'package:ttld/widgets/cascade_location_picker.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
import 'package:ttld/widgets/field/custom_pick_date.dart';
import 'package:ttld/widgets/field/custom_picker.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class UpdateNTDPage extends StatefulWidget {
  static const routePath = '/update-ntd';
  const UpdateNTDPage({super.key});

  @override
  _UpdateNTDPageState createState() => _UpdateNTDPageState();
}

class _UpdateNTDPageState extends State<UpdateNTDPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ntdMadnController = TextEditingController();
  final _ntdTentatController = TextEditingController();
  final _imagePathController = TextEditingController();
  final _ntdTenController = TextEditingController();
  final _mstController = TextEditingController();
  final _ntdSolaodongController = TextEditingController();
  final _ntdGioithieuController = TextEditingController();
  final _ntdThuockhucongnghiepController = TextEditingController();
  final _ntdDiachithanhphoController = TextEditingController();
  final _ntdDiachihuyenController = TextEditingController();
  final _ntdDiachixaphuongController = TextEditingController();
  final _ntdDiachichitietController = TextEditingController();
  final _ntdNguoilienheController = TextEditingController();
  final _ntdChucvuController = TextEditingController();
  final _ntdDienthoaiController = TextEditingController();
  final _ntdFaxController = TextEditingController();
  final _ntdEmailController = TextEditingController();
  final _ntdWebsiteController = TextEditingController();

  bool _ntdDuyet = false;
  bool _ntdTopbloc = false;
  String? _selectedQuocgia;

  final _ntdNamthanhlapController = TextEditingController();
  final _ntdLinhvuchoatdongController = TextEditingController();

  bool _ntdhtNlh = false;
  bool _ntdhtTelephone = false;
  bool _ntdhtWeb = false;
  bool _ntdhtFax = false;
  bool _ntdhtEmail = false;
  bool _ntdhtAddress = false;

  String? _ntdId = TextEditingController().text;

  bool _newletterSubscription = false;
  bool _jobsletterSubscription = false;

  String? ntdLoai;
  final _nongThonThanhThiController = TextEditingController();
  int? idLoaiHinhDoanhNghiep;
  int? idNganhKinhTe;
  int? idThoiGianHoatDong;
  int? idStatus;
  int? displayOrder;
  int? ntdHinhthucdoanhnghiep;

  String? _selectedTinh;
  String? _selectedHuyen;
  String? _selectedXa;
  String? _selectedKCN;

  List<QuocGia> _quocGias = [];
  QuocGia? quocGia;

  List<ChucDanhModel> _chucDanhs = [];
  ChucDanhModel? chucDanh;

  List<HinhThucDoanhNghiep> _hinhthucDoanhNghieps = [];
  HinhThucDoanhNghiep? hinhthucDoanhNghiep;

  final _idDoanhNghiepController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadQuocGias(); // Load data when the widget is initialized
    _loadChucDanh();
    _loadHinhThucDoanhNghiep();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ntdBloc = BlocProvider.of<NTDBloc>(context);
    if (ntdBloc.state is NTDLoadedById) {
      final ntd = (ntdBloc.state as NTDLoadedById).ntd;
      if (ntd != null) {
        _idDoanhNghiepController.text = ntd.idDoanhNghiep ?? '';
        _usernameController.text = ntd.username ?? '';
        _passwordController.text = ntd.password ?? '';
        _ntdMadnController.text = ntd.ntdMadn ?? '';
        _ntdTentatController.text = ntd.ntdTentat ?? '';
        _ntdTenController.text = ntd.ntdTen ?? '';
        _ntdEmailController.text = ntd.ntdEmail ?? '';
        _ntdSolaodongController.text = ntd.ntdSolaodong?.toString() ?? '';
        _ntdGioithieuController.text = ntd.ntdGioithieu ?? '';
        _ntdDiachithanhphoController.text = ntd.ntdDiachithanhpho ?? '';
        _ntdDiachihuyenController.text = ntd.ntdDiachihuyen ?? '';
        _ntdDiachixaphuongController.text = ntd.ntdDiachixaphuong ?? '';
        _ntdDiachichitietController.text = ntd.ntdDiachichitiet ?? '';
        _ntdNguoilienheController.text = ntd.ntdNguoilienhe ?? '';
        _ntdDienthoaiController.text = ntd.ntdDienthoai ?? '';
        _ntdFaxController.text = ntd.ntdFax ?? '';
        _ntdWebsiteController.text = ntd.ntdWebsite ?? '';
        _ntdNamthanhlapController.text = ntd.ntdNamthanhlap?.toString() ?? '';
        _ntdLinhvuchoatdongController.text = ntd.ntdLinhvuchoatdong ?? '';
        _nongThonThanhThiController.text = ntd.nongThonThanhThi ?? '';

        _selectedTinh = ntd.ntdTenTinh;
        _selectedHuyen = ntd.ntdTenHuyen;
        _selectedXa = ntd.ntdTenXa;
        _selectedQuocgia = ntd.ntdQuocgia;

        _ntdhtNlh = ntd.ntdhtNlh ?? false;
        _ntdhtTelephone = ntd.ntdhtTelephone ?? false;
        _ntdhtWeb = ntd.ntdhtWeb ?? false;
        _ntdhtFax = ntd.ntdhtFax ?? false;
        _ntdhtEmail = ntd.ntdhtEmail ?? false;
        _ntdhtAddress = ntd.ntdhtAddress ?? false;
        _newletterSubscription = ntd.newsletterSubscription ?? false;
        _jobsletterSubscription = ntd.jobsletterSubscription ?? false;
      }
    }
  }

  Future<void> _loadChucDanh() async {
    final chucDanhRepository = locator<ChucDanhRepository>();
    try {
      final chucDanhs = await chucDanhRepository.getChucDanhs();
      print("chucDanhs: ${chucDanhs[0].tenChucDanh}");
      if (mounted) {
        setState(() {
          _chucDanhs = chucDanhs;
        });
      }
    } catch (e) {
      // Handle error (e.g., show a snackbar)
      print("Error loading countries: $e");
    }
  }

  Future<void> _loadQuocGias() async {
    final quocGiaRepository = locator<QuocGiaRepository>();
    try {
      final quocGias = await quocGiaRepository.getQuocGias();
      if (mounted) {
        setState(() {
          _quocGias = quocGias;
        });
      }
    } catch (e) {
      // Handle error (e.g., show a snackbar)
      print("Error loading countries: $e");
    }
  }

  Future<void> _loadHinhThucDoanhNghiep() async {
    final hinhThucDoanhNghiepRepository =
        locator<HinhThucDoanhNghiepRepository>();
    try {
      final hinhthucDoanhNghieps =
          await hinhThucDoanhNghiepRepository.getHinhThucDoanhNghieps();
      if (mounted) {
        setState(() {
          _hinhthucDoanhNghieps = hinhthucDoanhNghieps;
        });
      }
    } catch (e) {
      // Handle error (e.g., show a snackbar)
      print("Error loading countries: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update NTD'),
      ),
      body: BlocListener<NTDBloc, NTDState>(
        listener: (context, state) {
          if (state is NTDLoaded) {
            Navigator.pop(context);
          }
          if (state is NTDError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                CustomTextField.email(
                  controller: _ntdEmailController,
                ),
                // const SizedBox(height: 16.0),
                // CustomTextField(
                //   labelText: "ID Doanh Nghiệp",
                //   controller: _idDoanhNghiepController,
                //   hintText: 'ID Doanh Nghiệp',
                // ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Mã số thuế",
                  controller: _mstController,
                  hintText: 'Mã số thuế',
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Username",
                  controller: _usernameController,
                  hintText: 'Username',
                ),
                const SizedBox(height: 16.0),
                CustomTextField.password(
                  controller: _passwordController,
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Mã NTD",
                  controller: _ntdMadnController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter NTD Madn';
                    }
                    return null;
                  },
                  hintText: 'Mã NTD',
                ),
                const SizedBox(height: 16.0),
                const Text("Thông tin của đơn vị, doanh nghiệp :"),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Tên nhà tuyển dụng",
                  controller: _ntdTenController,
                  hintText: 'Tên nhà tuyển dụng',
                ),
                const SizedBox(height: 16.0),
                CustomPicker<String>(
                  label: const Text("Loại hình"),
                  items: const [
                    "Doanh nghiệp nội tỉnh",
                    "Doanh nghiệp ngoại tỉnh",
                    "Doanh nghiệp XKLD",
                    "Khác"
                  ],
                  selectedItem: ntdLoai,
                  onChanged: (ntdLoai) {
                    setState(() {
                      this.ntdLoai = ntdLoai;
                    });
                  },
                  displayItemBuilder: (String? item) => item ?? '',
                ),
                const SizedBox(height: 16.0),
                CustomPicker<String>(
                  label: const Text("Thời gian hoạt động"),
                  items: const ["Sáng", "Chiều", "Tối"],
                  selectedItem: idThoiGianHoatDong as String?,
                  onChanged: (idThoiGianHoatDong) {
                    setState(() {
                      this.idThoiGianHoatDong = idThoiGianHoatDong as int?;
                    });
                  },
                  displayItemBuilder: (String? item) => item ?? '',
                ),
                const SizedBox(height: 16.0),
                CustomPicker<ChucDanhModel>(
                  label: const Text("Chức vụ"),
                  items: _chucDanhs,
                  selectedItem: chucDanh,
                  onChanged: (chucdanh) {
                    setState(() {
                      _ntdChucvuController.text = chucdanh?.tenChucDanh ?? '';
                    });
                  },
                  displayItemBuilder: (ChucDanhModel? item) =>
                      item?.tenChucDanh ?? '',
                ),
                const SizedBox(height: 16.0),
                CustomPicker<HinhThucDoanhNghiep>(
                  label: const Text("Hình thức doanh nghiệp"),
                  items: _hinhthucDoanhNghieps,
                  selectedItem: hinhthucDoanhNghiep,
                  onChanged: (hinhthucdoanhnhiep) {
                    setState(() {
                      _selectedQuocgia = hinhthucdoanhnhiep?.tenHinhthuc;
                    });
                  },
                  displayItemBuilder: (HinhThucDoanhNghiep? item) =>
                      item?.tenHinhthuc ?? '',
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Tổng nhân lực",
                  controller: _ntdSolaodongController,
                  hintText: 'Tổng nhân lực',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                CustomPicker<QuocGia>(
                  label: const Text("Quốc gia"),
                  items: _quocGias,
                  selectedItem: quocGia,
                  onChanged: (quocgia) {
                    setState(() {
                      _selectedQuocgia = quocgia?.name;
                    });
                  },
                  displayItemBuilder: (QuocGia? item) => item?.name ?? '',
                ),
                const SizedBox(height: 16.0),
                CustomPicker<String>(
                  label: const Text("Nông thôn/Thành thị"),
                  items: const ["Nông thôn", "Thành thị"],
                  selectedItem: _nongThonThanhThiController.text,
                  onChanged: (nongThonThanhThi) {
                    setState(() {
                      _nongThonThanhThiController.text = nongThonThanhThi ?? '';
                    });
                  },
                  displayItemBuilder: (String? item) => item ?? '',
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Tên viết tắt",
                  controller: _ntdTentatController,
                  hintText: 'Tên viết tắt',
                ),
                const SizedBox(height: 16.0),
                CascadeLocationPicker(
                  addressDetailController: _ntdDiachichitietController,
                  onTinhChanged: (tinh) {
                    setState(() {
                      _selectedTinh = tinh?.tentinh;
                    });
                  },
                  onHuyenChanged: (huyen) {
                    setState(() {
                      _selectedHuyen = huyen?.tenhuyen;
                    });
                  },
                  onXaChanged: (xa) {
                    setState(() {
                      _selectedXa = xa?.tenxa;
                    });
                  },
                  onKCNChanged: (kcn) {
                    setState(() {
                      _selectedKCN = kcn?.kcnTen;
                    });
                    _ntdThuockhucongnghiepController.text = kcn?.kcnTen ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Website",
                  controller: _ntdWebsiteController,
                  hintText: 'Website',
                ),
                const SizedBox(height: 16.0),
                CustomPickYear(
                  hintText: 'Năm thành lập',
                  selectedDate:
                      DateTime.tryParse(_ntdNamthanhlapController.text),
                  onChanged: (DateTime? dateTime) {
                    setState(() {
                      if (dateTime != null) {
                        _ntdNamthanhlapController.text = dateTime.toString();
                      }
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Fax",
                  controller: _ntdFaxController,
                  hintText: 'Fax',
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Điện thoại",
                  controller: _ntdDienthoaiController,
                  hintText: 'Điện thoại',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Lĩnh vực hoạt động",
                  controller: _ntdLinhvuchoatdongController,
                  hintText: 'Lĩnh vực hoạt động',
                ),
                const SizedBox(height: 16.0),
                const Text("Cho phép hiển thị các thông tin sau:"),
                CustomCheckbox(
                  label: "Người liên hệ",
                  value: _ntdhtNlh,
                  onChanged: (bool? value) {
                    setState(() {
                      _ntdhtNlh = value ?? false;
                    });
                  },
                ),
                CustomCheckbox(
                  label: "Số điện thoại",
                  value: _ntdhtTelephone,
                  onChanged: (bool? value) {
                    setState(() {
                      _ntdhtTelephone = value ?? false;
                    });
                  },
                ),
                CustomCheckbox(
                  label: "Website",
                  value: _ntdhtWeb,
                  onChanged: (bool? value) {
                    setState(() {
                      _ntdhtWeb = value ?? false;
                    });
                  },
                ),
                CustomCheckbox(
                  label: "Fax",
                  value: _ntdhtFax,
                  onChanged: (bool? value) {
                    setState(() {
                      _ntdhtFax = value ?? false;
                    });
                  },
                ),
                CustomCheckbox(
                  label: "Email",
                  value: _ntdhtEmail,
                  onChanged: (bool? value) {
                    setState(() {
                      _ntdhtEmail = value ?? false;
                    });
                  },
                ),
                CustomCheckbox(
                  label: "Địa chỉ",
                  value: _ntdhtAddress,
                  onChanged: (bool? value) {
                    setState(() {
                      _ntdhtAddress = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Text("Thông báo"),
                CustomCheckbox(
                  label: "Đăng ký nhận bản tin",
                  value: _newletterSubscription,
                  onChanged: (bool? value) {
                    setState(() {
                      _newletterSubscription = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 12.0),
                CustomCheckbox(
                  label: "Đăng ký nhận bản tin việc làm",
                  value: _jobsletterSubscription,
                  onChanged: (bool? value) {
                    setState(() {
                      _jobsletterSubscription = value ?? false;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final ntdBloc = BlocProvider.of<NTDBloc>(context);
                        if (ntdBloc.state is NTDLoadedById) {
                          final originalNtd =
                              (ntdBloc.state as NTDLoadedById).ntd;
                          if (originalNtd != null) {
                            final updatedNtd = originalNtd.copyWith(
                              username: _usernameController.text,
                              password: _passwordController.text,
                              ntdMadn: _ntdMadnController.text,
                              ntdTentat: _ntdTentatController.text,
                              ntdTen: _ntdTenController.text,
                              mst: _mstController.text,
                              ntdSolaodong:
                                  int.tryParse(_ntdSolaodongController.text),
                              ntdGioithieu: _ntdGioithieuController.text,
                              ntdThuockhucongnghiep: 0,
                              // ntdThuockhucongnghiep:
                              //     _ntdThuockhucongnghiepController.text,
                              ntdDiachithanhpho:
                                  _ntdDiachithanhphoController.text,
                              ntdDiachihuyen: _ntdDiachihuyenController.text,
                              ntdDiachixaphuong:
                                  _ntdDiachixaphuongController.text,
                              ntdDiachichitiet:
                                  _ntdDiachichitietController.text,
                              ntdNguoilienhe: _ntdNguoilienheController.text,
                              // ntdChucvu: _ntdChucvuController.text,
                              ntdDienthoai: _ntdDienthoaiController.text,
                              ntdFax: _ntdFaxController.text,
                              ntdEmail: _ntdEmailController.text,
                              ntdWebsite: _ntdWebsiteController.text,
                              ntdQuocgia: _selectedQuocgia,
                              ntdNamthanhlap:
                                  int.tryParse(_ntdNamthanhlapController.text),
                              ntdLinhvuchoatdong:
                                  _ntdLinhvuchoatdongController.text,
                              ntdhtNlh: _ntdhtNlh,
                              ntdhtTelephone: _ntdhtTelephone,
                              ntdhtWeb: _ntdhtWeb,
                              ntdhtFax: _ntdhtFax,
                              ntdhtEmail: _ntdhtEmail,
                              ntdhtAddress: _ntdhtAddress,
                              ntdId: _ntdId,
                              newsletterSubscription: _newletterSubscription,
                              jobsletterSubscription: _jobsletterSubscription,
                              // ntdLoai: _selectedLoai,
                              nongThonThanhThi:
                                  _nongThonThanhThiController.text,
                              idLoaiHinhDoanhNghiep: idLoaiHinhDoanhNghiep,
                              idNganhKinhTe: idNganhKinhTe,
                              idThoiGianHoatDong: idThoiGianHoatDong,
                              ntdHinhthucdoanhnghiep: ntdHinhthucdoanhnghiep,

                              ntdTenTinh: _selectedTinh,
                              ntdTenHuyen: _selectedHuyen,
                              ntdTenXa: _selectedXa,
                            );
                            context.read<NTDBloc>().add(NTDUpdate(updatedNtd));
                          }
                        }
                      }
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idDoanhNghiepController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _mstController.dispose();
    _ntdMadnController.dispose();
    _ntdTentatController.dispose();
    _ntdTenController.dispose();
    _ntdEmailController.dispose();
    _ntdSolaodongController.dispose();
    _ntdGioithieuController.dispose();
    _ntdDiachithanhphoController.dispose();
    _ntdDiachihuyenController.dispose();
    _ntdDiachixaphuongController.dispose();
    _ntdDiachichitietController.dispose();
    _ntdNguoilienheController.dispose();
    _ntdDienthoaiController.dispose();
    _ntdFaxController.dispose();
    _ntdWebsiteController.dispose();
    _ntdNamthanhlapController.dispose();
    _ntdLinhvuchoatdongController.dispose();
    _nongThonThanhThiController.dispose();
    _ntdSolaodongController.dispose();
    _ntdChucvuController.dispose();
    _ntdThuockhucongnghiepController.dispose();
    _ntdWebsiteController.dispose();
    _ntdFaxController.dispose();
    _ntdEmailController.dispose();
    super.dispose();
  }
}
