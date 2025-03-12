import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/thoigianhoatdong_api_service.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/models/loai_hinh_model.dart';
import 'package:ttld/models/nganh_nghe_model.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';
import 'package:ttld/models/thoigian_hoatdong.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_repository.dart';
import 'package:ttld/repositories/loai_hinh/loai_hinh_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_repository.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';
import 'package:ttld/widgets/cascade_location_picker.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
import 'package:ttld/widgets/field/custom_pick_year.dart';
import 'package:ttld/widgets/field/custom_picker.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';
import 'package:ttld/widgets/reuseable_widgets/pick_quocgia.dart';

class UpdateNTDPage extends StatefulWidget {
  static const routePath = '/update_ntd';
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
  final _ntdDienthoaiController = TextEditingController();
  final _ntdFaxController = TextEditingController();
  final _ntdEmailController = TextEditingController();
  final _ntdWebsiteController = TextEditingController();

  bool _ntdDuyet = false;
  bool _ntdTopbloc = false;

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

  int? ntdLoai;
  final _nongThonThanhThiController = TextEditingController();
  String? idLoaiHinhDoanhNghiep;
  String? idNganhKinhTe;
  int? idStatus;
  int? displayOrder;
  int? ntdHinhthucdoanhnghiep;
  int? ntdChucvu;

  String? _selectedTinh;
  String? _selectedHuyen;
  String? _selectedXa;
  String? _selectedKCN;
  int? maTinh;
  String? maHuyen;
  String? maXa;
  int? maKCN;
  int? ntdQuocgia;

  List<ChucDanhModel> _chucDanhs = [];
  ChucDanhModel? chucDanh;

  List<HinhThucDoanhNghiep> _hinhthucDoanhNghieps = [];
  HinhThucDoanhNghiep? hinhthucDoanhNghiep;

  List<LoaiHinh> _loaihinhs = [];
  LoaiHinh? loaihinh;

  final _idDoanhNghiepController = TextEditingController();

  int? idThoiGianHoatDong;
  List<ThoiGianHoatDong> _thoigianhoatdongs = [];
  ThoiGianHoatDong? thoigianhoatdong;

  List<NganhNgheKT> _nganhNghes = [];
  NganhNgheKT? nganhNghe;

  @override
  void initState() {
    super.initState();
    _loadChucDanh();
    _loadHinhThucDoanhNghiep();
    _loadLoaiHinh();
    _loadNganhNghe();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ntdBloc = locator<NTDBloc>();
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
        maTinh = int.tryParse(ntd.ntdDiachithanhpho ?? '');
        maHuyen = ntd.ntdDiachihuyen ?? '';
        maXa = ntd.ntdDiachixaphuong ?? '';
        maKCN = ntd.ntdThuockhucongnghiep;
        _mstController.text = ntd.mst ?? '';
        ntdChucvu = ntd.ntdChucvu;
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

        _ntdhtNlh = ntd.ntdhtNlh ?? false;
        _ntdhtTelephone = ntd.ntdhtTelephone ?? false;
        _ntdhtWeb = ntd.ntdhtWeb ?? false;
        _ntdhtFax = ntd.ntdhtFax ?? false;
        _ntdhtEmail = ntd.ntdhtEmail ?? false;
        _ntdhtAddress = ntd.ntdhtAddress ?? false;
        _newletterSubscription = ntd.newsletterSubscription ?? false;
        _jobsletterSubscription = ntd.jobsletterSubscription ?? false;
        idThoiGianHoatDong = ntd.idThoiGianHoatDong;
        idStatus = ntd.idStatus;
        idNganhKinhTe = ntd.idNganhKinhTe;
        idLoaiHinhDoanhNghiep = ntd.idLoaiHinhDoanhNghiep;
        ntdLoai = ntd.ntdLoai;
        ntdHinhthucdoanhnghiep = ntd.ntdHinhthucdoanhnghiep;
        ntdQuocgia = ntd.idQuocGia;
      }
    }
  }

  Future<void> _loadChucDanh() async {
    final chucDanhRepository = locator<ChucDanhRepository>();
    try {
      final chucDanhs = await chucDanhRepository.getChucDanhs();

      if (mounted) {
        setState(() {
          _chucDanhs = chucDanhs;
        });
        if (ntdChucvu != null) {
          ChucDanhModel? _chucDanh =
              chucDanhs.firstWhere((element) => element.id == ntdChucvu);
          if (_chucDanh != null) {
            setState(() {
              chucDanh = _chucDanh;
            });
          }
        }
      }
    } catch (e) {
      print("Error loading chuc danh: $e");
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
        if (ntdHinhthucdoanhnghiep != null) {
          HinhThucDoanhNghiep? _hinhthucDoanhNghiep = hinhthucDoanhNghieps
              .firstWhere((element) => element.id == ntdHinhthucdoanhnghiep);
          if (_hinhthucDoanhNghiep != null) {
            setState(() {
              hinhthucDoanhNghiep = _hinhthucDoanhNghiep;
            });
          }
        }
      }
    } catch (e) {
      print("Error loading hinh thuc doanh nghiep: $e");
    }
  }

  Future<void> _loadNganhNghe() async {
    final nganhNgheRepository = locator<NganhNgheRepository>();
    try {
      final nganhNghes = await nganhNgheRepository.getNganhNghes();

      if (mounted) {
        setState(() {
          _nganhNghes = nganhNghes;
        });
        if (idNganhKinhTe != null) {
          NganhNgheKT? _nganhNghe =
              _nganhNghes.firstWhere((element) => element.id == idNganhKinhTe);
          if (_nganhNghe != null) {
            setState(() {
              idNganhKinhTe = _nganhNghe?.id;
              nganhNghe = _nganhNghe;
            });
          }
        }
      }
    } catch (e) {
      print("Error loading nganh nghe: $e");
    }
  }

  Future<void> _loadLoaiHinh() async {
    final loaihinhRepository = locator<LoaiHinhRepository>();
    try {
      final loaihinhs = await loaihinhRepository.getLoaiHinhs();
      if (mounted) {
        setState(() {
          _loaihinhs = loaihinhs;
        });
        if (idLoaiHinhDoanhNghiep != null) {
          LoaiHinh? _loaihinh = loaihinhs
              .firstWhere((element) => element.id == idLoaiHinhDoanhNghiep);
          if (_loaihinh != null) {
            setState(() {
              idLoaiHinhDoanhNghiep = _loaihinh.id;
              loaihinh = _loaihinh;
            });
          }
        }
      }
    } catch (e) {
      print("Error loading loai hinh: $e");
    }
  }

  Future<void> _loadThoiGianHoatDong() async {
    try {
      final thoigianhoatdongs =
          await locator<ThoiGianHoatDongApiService>().getThoiGianHoatDongList();
      if (mounted) {
        setState(() {
          _thoigianhoatdongs = thoigianhoatdongs;
        });
      }
    } catch (e) {
      print("Error loading thoigianhoatdongs: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update NTD'),
      ),
      body: BlocListener<NTDBloc, NTDState>(
        // bloc: locator<NTDBloc>(),
        // listener: (context, state) {
        //   if (state is NTDLoaded) {
        //     Navigator.pop(context);
        //   }
        //   if (state is NTDError) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(content: Text(state.message)),
        //     );
        //   }
        // },
        bloc: locator<NTDBloc>(),
        listener: (context, state) {
          debugPrint('👂 NTD state: ${state.runtimeType}');
          if (state is NTDLoaded) {
            debugPrint('✅ NTD loaded, popping screen');
            Navigator.pop(context);
            debugPrint('🚪 Screen popped');
          }
          if (state is NTDError) {
            debugPrint('❌ NTD error: ${state.message}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is NTDSuccess) {
            ToastUtils.showToastSuccess(context,
                message: state.message, description: 'Cập nhật thành công');
            context.go('/ntd_home');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 10.0),
                Text("Thông tin tài khoản"),
                const SizedBox(height: 16.0),
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
                const Text("Thông tin của người liên hệ:"),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Tên người liên hệ",
                  controller: _ntdNguoilienheController,
                  hintText: 'Tên người liên hệ',
                ),
                const SizedBox(height: 16.0),
                CustomPicker<ChucDanhModel>(
                  label: const Text("Chức vụ người liên hệ"),
                  items: _chucDanhs,
                  selectedItem: chucDanh,
                  onChanged: (chucdanh) {
                    setState(() {
                      ntdChucvu = chucdanh?.id;
                    });
                  },
                  displayItemBuilder: (ChucDanhModel? item) => item?.displayName ?? '',
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
                CustomTextField(
                  labelText: "Tên viết tắt",
                  controller: _ntdTentatController,
                  hintText: 'Tên viết tắt',
                ),
                const SizedBox(height: 16.0),
                const SizedBox(height: 16.0),
                CustomPickerMap(
                  label: const Text("Loại doanh nghiệp"),
                  items: loaiDoanhNgiepOptions,
                  selectedItem: ntdLoai,
                  onChanged: (ntdLoai) {
                    setState(() {
                      this.ntdLoai = ntdLoai;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GenericPicker(
                  initialValue: idNganhKinhTe,
                  items: locator<List<NganhNgheKT>>(),
                  onChanged: (NganhNgheKT? value) {
                    idNganhKinhTe = value!.id.toString();
                  },
                  label: 'Ngành nghề chính',
                ),
                const SizedBox(height: 16.0),
                CustomPicker<int>(
                  label: const Text("Trạng thái"),
                  items: statusOptions.keys.toList(),
                  selectedItem: idStatus,
                  onChanged: (value) {
                    setState(() {
                      idStatus = value;
                    });
                  },
                  displayItemBuilder: (int? item) => statusOptions[item] ?? '',
                ),

                const SizedBox(height: 16.0),
                CustomPicker<int>(
                  label: const Text("Thời gian hoạt động"),
                  items: thoiGianHoatDongOptions.keys.toList(),
                  selectedItem: idThoiGianHoatDong,
                  onChanged: (value) {
                    setState(() {
                      idThoiGianHoatDong = value;
                    });
                  },
                  displayItemBuilder: (int? item) =>
                      thoiGianHoatDongOptions[item] ?? '',
                ),
                const SizedBox(height: 16.0),
                CustomPicker<HinhThucDoanhNghiep>(
                  label: const Text("Hình thức doanh nghiệp"),
                  items: _hinhthucDoanhNghieps,
                  selectedItem: hinhthucDoanhNghiep,
                  onChanged: (hinhthucdoanhnhiep) {
                    setState(() {
                      ntdHinhthucdoanhnghiep = hinhthucdoanhnhiep?.id;
                    });
                  },
                  displayItemBuilder: (HinhThucDoanhNghiep? item) =>
                      item?.name ?? '',
                ),

                const SizedBox(height: 16.0),
                CustomPicker<LoaiHinh>(
                  label: const Text("Loại hình doanh nghiệp"),
                  items: _loaihinhs,
                  selectedItem: loaihinh,
                  onChanged: (loaihinh) {
                    setState(() {
                      idLoaiHinhDoanhNghiep = loaihinh?.id;
                    });
                  },
                  displayItemBuilder: (LoaiHinh? item) => item?.name ?? '',
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Tổng nhân lực",
                  controller: _ntdSolaodongController,
                  hintText: 'Tổng nhân lực',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                // CustomPicker<QuocGia>(
                //   label: const Text("Quốc gia"),
                //   items: _quocGias,
                //   selectedItem: quocGia,
                //   onChanged: (quocgia) {
                //     setState(() {
                //       _selectedQuocgia = quocgia?.name;
                //     });
                //   },
                //   displayItemBuilder: (QuocGia? item) => item?.name ?? '',
                // ),
                // const SizedBox(height: 16.0),
                PickerQuocGia(
                  initialValue: ntdQuocgia,
                  onChanged: (value) {
                    setState(() {
                      ntdQuocgia = value?.id;
                    });
                  },
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
                CascadeLocationPicker(
                  isNTD: true,
                  initialTinh: maTinh.toString(),
                  initialHuyen: maHuyen,
                  initialXa: maXa,
                  initialKCN: maKCN.toString(),
                  addressDetailController: _ntdDiachichitietController,
                  onTinhChanged: (tinh) {
                    setState(() {
                      _selectedTinh = tinh?.tentinh;
                      maTinh = int.tryParse(tinh?.matinh ?? '');
                    });
                  },
                  onHuyenChanged: (huyen) {
                    setState(() {
                      _selectedHuyen = huyen?.tenhuyen;
                      maHuyen = huyen?.mahuyen;
                    });
                  },
                  onXaChanged: (xa) {
                    setState(() {
                      _selectedXa = xa?.tenxa;
                      maXa = xa?.maxa;
                    });
                  },
                  onKCNChanged: (kcn) {
                    setState(() {
                      _selectedKCN = kcn?.kcnTen;
                      maKCN = kcn?.kcnId;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Website",
                  controller: _ntdWebsiteController,
                  hintText: 'Website',
                ),
                const SizedBox(height: 16.0),
                CustomYearPicker(
                  selectedItem: int.tryParse(_ntdNamthanhlapController.text),
                  label: const Text("Năm tạo"),
                  onChanged: (year) {
                    setState(() {
                      _ntdNamthanhlapController.text = year.toString();
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
                        final ntdBloc = locator<NTDBloc>();

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
                              ntdThuockhucongnghiep: maKCN,
                              // ntdThuockhucongnghiep:
                              //     _ntdThuockhucongnghiepController.text,
                              ntdDiachithanhpho: maTinh.toString(),
                              ntdDiachihuyen: maHuyen,
                              ntdDiachixaphuong: maXa,
                              ntdDiachichitiet:
                                  _ntdDiachichitietController.text,
                              ntdNguoilienhe: _ntdNguoilienheController.text,
                              ntdChucvu: chucDanh?.id,
                              ntdDienthoai: _ntdDienthoaiController.text,
                              ntdFax: _ntdFaxController.text,
                              ntdEmail: _ntdEmailController.text,
                              ntdWebsite: _ntdWebsiteController.text,
                              ntdQuocgia: ntdQuocgia?.toString(),
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
                              ntdLoai: ntdLoai,
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
                            locator<NTDBloc>().add(NTDUpdate(updatedNtd));
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
    _ntdThuockhucongnghiepController.dispose();
    _ntdWebsiteController.dispose();
    _ntdFaxController.dispose();
    _ntdEmailController.dispose();

    super.dispose();
  }
}
