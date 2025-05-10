import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/do_tuoi_model.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/models/hinh_thuc_lam_viec_model.dart';
import 'package:ttld/models/hinh_thuc_loai_hinh_model.dart';
import 'package:ttld/models/hinh_thuc_tuyen_dung_model.dart';
import 'package:ttld/models/kcn/kcn_model.dart';
import 'package:ttld/models/kinh_nghiem_lam_viec.dart';
import 'package:ttld/models/ky_nang_mem_model.dart';
import 'package:ttld/models/loai_hop_dong_lao_dong_model.dart';
import 'package:ttld/models/m01tt11_model.dart';
import 'package:ttld/models/muc_dich_lam_viec_model.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nganh_nghe_chuyennganh.dart';
import 'package:ttld/models/nganh_nghe_model.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/models/ngoai_ngu_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/models/user/manv_name_model.dart';
import 'package:ttld/widgets/cascade_level_pick_grok.dart';
import 'package:ttld/widgets/cascade_location_picker_grok.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
import 'package:ttld/widgets/field/custom_pick_datetime_grok.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/widgets/reuseable_widgets/stepper_page.dart';

class M01TT11Page extends StatefulWidget {
  final M01TT11? m01tt11;
  final Ntd? ntd;
  M01TT11Page({super.key, this.ntd, this.m01tt11});

  @override
  State<M01TT11Page> createState() => _M01TT11PageState();
}

class _M01TT11PageState extends State<M01TT11Page> {
  TextEditingController madk = TextEditingController();
  TextEditingController idDoanhnghiep = TextEditingController();
  TextEditingController idDn = TextEditingController();
  TextEditingController tenDn = TextEditingController();
  TextEditingController tenGd = TextEditingController();
  TextEditingController idLhdn = TextEditingController();
  TextEditingController diachiDn = TextEditingController();
  TextEditingController idNkt = TextEditingController();
  TextEditingController tenCv = TextEditingController();
  TextEditingController motaCv = TextEditingController();
  TextEditingController idBacHoc = TextEditingController();
  TextEditingController trinhdok1 = TextEditingController();
  TextEditingController trinhdok2 = TextEditingController();
  TextEditingController trinhdoNghe = TextEditingController();
  TextEditingController idTdnn1 = TextEditingController();
  TextEditingController idTdnn2 = TextEditingController();
  TextEditingController idTdth = TextEditingController();
  TextEditingController idTinhockhac = TextEditingController();
  TextEditingController idKynang = TextEditingController();
  TextEditingController kynangkhac = TextEditingController();
  TextEditingController idKinhnghiem = TextEditingController();
  TextEditingController noiLvTinh = TextEditingController();
  TextEditingController idHinhthuc = TextEditingController();
  TextEditingController idMucdich = TextEditingController();
  TextEditingController phucloikhac = TextEditingController();
  TextEditingController tenLienhe = TextEditingController();
  TextEditingController chucvu = TextEditingController();
  TextEditingController dienthoai = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController hinhthuckhac = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController matinh = TextEditingController();
  TextEditingController mahuyen = TextEditingController();
  TextEditingController maxa = TextEditingController();
  TextEditingController idTuyenDung = TextEditingController();
  TextEditingController quyenloi = TextEditingController();
  TextEditingController tienPhucloiController =
      TextEditingController(); // Controller for meal support amount
  TextEditingController idHinhthucTd = TextEditingController();
  // Number fields
  TextEditingController? soluong;
  int? nganhId;
  int? level1;
  int? level2;
  int? level3;
  int? level4;
  int? idChucvu;
  int? idhocvan;
  int? idngheDt;
  TextEditingController? bacNghe;
  int? idNndt1;
  int? mucNn1;
  int? idNndt2;
  int? mucNn2;
  int? mucTh;
  int? mucThKhac;
  int? noiLvkcn;
  int? idCalamviec;
  int? idMucluong;
  int? idDoituong;
  int? idKhuCn;
  int? idDoTuoi;
  int? idYcgt;
  int? idLoaiDhld;

  // DateTime fields
  DateTime? ngaylap;
  DateTime? thoihanTd;

  // Boolean fields
  bool chkNl = false;
  bool chkCn = false;
  bool chkSxpp = false;
  bool chkVtkb = false;
  bool chkTttt = false;
  bool chkBds = false;
  bool chkDvhc = false;
  bool chkYt = false;
  bool chkBbl = false;
  bool chkThue = false;
  bool chkKk = false;
  bool chkXd = false;
  bool chkCcn = false;
  bool chkDvlt = false;
  bool chkTcnh = false;
  bool chkKhcn = false;
  bool chkGd = false;
  bool chkNt = false;
  bool chkHdxh = false;
  bool chkDv = false;
  bool chkHdqt = false;
  bool chkGt = false;
  bool chkNs = false;
  bool chkNhom = false;
  bool chkGs = false;
  bool chkKhac = false;
  bool chkTtr = false;
  bool chkTh = false;
  bool chkDl = false;
  bool chkPb = false;
  bool chkQltg = false;
  bool chkTu = false;
  bool chkApl = false;
  bool chkPl01 = false;
  bool chkPl02 = false;
  bool chkPl03 = false;
  bool chkPl04 = false;
  bool chkPl05 = false;
  bool chkPl06 = false;
  bool chkPl07 = false;
  bool chkPl08 = false;
  bool chkPl09 = false;
  bool chkPl10 = false;
  bool chkPl11 = false;
  bool chkPl12 = false;
  bool chkPl13 = false;
  bool chkPl14 = false;
  bool chkPl15 = false;
  bool chkPl16 = false;
  bool chkPl17 = false;
  bool chkNl1 = false;
  bool chkNl2 = false;
  bool chkNl3 = false;
  bool chkTl1 = false;
  bool chkTl2 = false;
  bool chkTl3 = false;
  bool chkDl1 = false;
  bool chkDl2 = false;
  bool chkDl3 = false;
  bool chkNn1 = false;
  bool chkNn2 = false;
  bool chkNn3 = false;
  bool chkY01 = false;
  bool chkY02 = false;
  bool chkTy1 = false;
  bool chkTy2 = false;
  bool chkTy3 = false;
  bool chk2T1 = false;
  bool chk2T2 = false;
  bool chk2T3 = false;
  bool chk2T4 = false;
  bool chk2T5 = false;
  bool isDenKhiTuyenXong = false;
  bool nhanSms = false;
  bool nhanEMail = false;
  bool status = false;

  // Big integer fields
  TextEditingController tienluong = TextEditingController();
  BigInt tienPhucloi = BigInt.from(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.ntd != null && widget.m01tt11 == null) {
      tenDn.text = widget.ntd!.ntdTen ?? '';
      idDn.text = widget.ntd!.ntdMadn ?? '';
      tenGd.text = widget.ntd!.ntdNguoilienhe ?? '';
      diachiDn.text = widget.ntd!.ntdDiachichitiet ?? '';
      dienthoai.text = widget.ntd!.ntdDienthoai ?? '';
      email.text = widget.ntd!.ntdEmail ?? '';
      idLhdn.text = widget.ntd!.idLoaiHinhDoanhNghiep ?? '';
      idNkt.text = widget.ntd!.idNganhKinhTe ?? '';
      matinh.text = widget.ntd!.ntdDiachithanhpho.toString() ?? '';
      mahuyen.text = widget.ntd!.ntdDiachihuyen ?? '';
      maxa.text = widget.ntd!.ntdDiachixaphuong ?? '';
      idKhuCn = widget.ntd!.ntdThuockhucongnghiep;
    }
  }

  int currentStep = 0;

  final List<String> steps = [
    'Thông tin\nDoanh nghiệp',
    'Thông tin\ntuyển dụng',
    'Thông tin liên hệ\n Nhật ký tuyển dụng ',
  ];

  Widget get stepContent {
    switch (currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget get bottomNavigation {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentStep > 0)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentStep--;
                });
              },
              child: const Text('Quay lại'),
            ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              if (currentStep < steps.length - 1) {
                setState(() {
                  currentStep++;
                });
              } else {
                // Handle form submission
                _handleSubmit();
              }
            },
            child: Text(
                currentStep < steps.length - 1 ? 'Tiếp tục' : 'Hoàn thành'),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Information Section
        _buildSectionHeader(theme, 'Thông tin doanh nghiệp'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: tenDn,
                labelText: 'Tên doanh nghiệp',
                hintText: 'Nhập tên doanh nghiệp',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: idDn,
                labelText: 'Mã doanh nghiệp',
                hintText: 'Nhập mã doanh nghiệp',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: tenGd,
                labelText: 'Tên người liên hệ',
                hintText: 'Nhập tên người liên hệ',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: diachiDn,
                labelText: 'Địa chỉ doanh nghiệp',
                hintText: 'Nhập địa chỉ doanh nghiệp',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: dienthoai,
                labelText: 'Điện thoại',
                hintText: 'Nhập điện thoại',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: email,
                labelText: 'Email',
                hintText: 'Nhập email',
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Business Type Section
        _buildSectionHeader(theme, 'Loại hình doanh nghiệp'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GenericPicker<HinhThucLoaiHinh>(
                label: 'Loại hình doanh nghiệp',
                items: locator<List<HinhThucLoaiHinh>>(),
                initialValue: widget.ntd?.idLoaiHinhDoanhNghiep,
                onChanged: (value) {
                  setState(() {
                    idLhdn.text = value?.displayName ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<NganhNgheKT>(
                label: 'Ngành nghề',
                items: locator<List<NganhNgheKT>>(),
                initialValue: widget.ntd?.idNganhKinhTe,
                onChanged: (value) {
                  setState(() {
                    idNkt.text = value?.displayName ?? '';
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Location Section
        _buildSectionHeader(theme, 'Địa chỉ'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: CascadeLocationPickerGrok(
            isNTD: true,
            initialTinh: matinh.toString(),
            initialHuyen: mahuyen.toString(),
            initialXa: maxa.toString(),
            initialKCN: idKhuCn.toString(),
            addressDetailController: diachiDn,
            onTinhChanged: (tinh) {
              setState(() {
                matinh.text = tinh?.matinh ?? '';
              });
            },
            onHuyenChanged: (huyen) {
              setState(() {
                mahuyen.text = huyen?.tenhuyen ?? '';
              });
            },
            onXaChanged: (xa) {
              setState(() {
                maxa.text = xa?.tenxa ?? '';
              });
            },
            onKCNChanged: (kcn) {
              setState(() {
                idKhuCn = kcn?.id;
              });
            },
          ),
        ),
        const SizedBox(height: 32),

        // Business Fields Section
        _buildSectionHeader(theme, 'Lĩnh vực sản xuất kinh doanh'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCheckbox(
                  label: 'Nông, lâm nghiệp và thủy sản',
                  value: chkNl,
                  onChanged: (bool? value) {
                    setState(() {
                      chkNl = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Khai khoáng',
                  value: chkKk,
                  onChanged: (bool? value) {
                    setState(() {
                      chkKk = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label:
                      'SX và phân phối điện, khí đốt, hơi nước và điều hòa không khí',
                  value: chkSxpp,
                  onChanged: (bool? value) {
                    setState(() {
                      chkSxpp = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Công nghiệp, chế biến, chế tạo',
                  value: chkCn,
                  onChanged: (bool? value) {
                    setState(() {
                      chkCn = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Xây dựng',
                  value: chkXd,
                  onChanged: (bool? value) {
                    setState(() {
                      chkXd = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Vận tải, kho bãi',
                  value: chkVtkb,
                  onChanged: (bool? value) {
                    setState(() {
                      chkVtkb = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Dịch vụ lưu trú và ăn uống',
                  value: chkDvlt,
                  onChanged: (bool? value) {
                    setState(() {
                      chkDvlt = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Thông tin truyền thông',
                  value: chkTttt,
                  onChanged: (bool? value) {
                    setState(() {
                      chkTttt = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label:
                      'Cung cấp nước, hoạt đông quản lý và xử lý nước thải,rác thải',
                  value: chkCcn,
                  onChanged: (bool? value) {
                    setState(() {
                      chkCcn = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Hoạt động kinh doanh bất động sản',
                  value: chkBds,
                  onChanged: (bool? value) {
                    setState(() {
                      chkBds = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Hoạt động tài chính, ngân hàng và bảo hiểm',
                  value: chkTcnh,
                  onChanged: (bool? value) {
                    setState(() {
                      chkSxpp = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Hoạt động chuyên môn, khoa học và công nghệ',
                  value: chkKhcn,
                  onChanged: (bool? value) {
                    setState(() {
                      chkKhcn = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Y tế và hoạt động trợ giúp xã hội',
                  value: chkYt,
                  onChanged: (bool? value) {
                    setState(() {
                      chkYt = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Nghệ thuật, vui chơi giải trí',
                  value: chkNt,
                  onChanged: (bool? value) {
                    setState(() {
                      chkNt = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Hoạt dộng hành chính và dịch vụ hỗ trợ',
                  value: chkDvhc,
                  onChanged: (bool? value) {
                    setState(() {
                      chkDvhc = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Giáo dục và đào tạo',
                  value: chkGd,
                  onChanged: (bool? value) {
                    setState(() {
                      chkGd = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Bán buôn, bán lẻ',
                  value: chkBbl,
                  onChanged: (bool? value) {
                    setState(() {
                      chkKhcn = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label:
                      'Hoạt động làm thuê và các công việc trong hộ gia đình',
                  value: chkThue,
                  onChanged: (bool? value) {
                    setState(() {
                      chkYt = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label:
                      'Hoạt động của ĐCS, tổ chức CT-XH, QLNN, ANQP, BĐXH bắt buộc',
                  value: chkHdxh,
                  onChanged: (bool? value) {
                    setState(() {
                      chkNt = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Hoạt động quốc tế',
                  value: chkHdqt,
                  onChanged: (bool? value) {
                    setState(() {
                      chkHdqt = value ?? false;
                    });
                  }),
              CustomCheckbox(
                  label: 'Hoạt động, dịch vụ khác',
                  value: chkDv,
                  onChanged: (bool? value) {
                    setState(() {
                      chkDv = value ?? false;
                    });
                  }),
            ],
          ),
        ),
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

  Widget _buildStep2() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Basic Job Information Section
        _buildSectionHeader(theme, 'Thông tin cơ bản công việc'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                hintText: 'Tên công việc',
                labelText: 'Tên công việc',
                controller: tenCv,
              ),
              const SizedBox(height: 16),
              CustomTextField.number(
                hintText: 'Số lượng tuyển',
                labelText: 'Số lượng tuyển',
                controller: soluong,
              ),
              const SizedBox(height: 16),
              CustomTextField.textArea(
                hintText: 'Mô tả công việc',
                labelText: 'Mô tả công việc',
                controller: motaCv,
                maxLines: 5,
                minLines: 3,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Job Requirements Section
        _buildSectionHeader(theme, 'Yêu cầu công việc'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GenericPicker<NganhNgheTD>(
                onChanged: (NganhNgheTD? value) {
                  setState(() {
                    nganhId = value?.id;
                  });
                },
                label: 'Ngành nghề tuyển dụng',
                items: locator<List<NganhNgheTD>>(),
              ),
              const SizedBox(height: 16),
              GenericPicker<ChucDanhModel>(
                onChanged: (ChucDanhModel? value) {
                  setState(() {
                    idChucvu = value?.id;
                  });
                },
                label: 'Chức vụ',
                items: locator<List<ChucDanhModel>>(),
              ),
              const SizedBox(height: 16),
              NganhNgheCapDoPicker(),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Education Requirements Section
        _buildSectionHeader(theme, 'Yêu cầu học vấn'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GenericPicker<TrinhDoHocVan>(
                onChanged: (TrinhDoHocVan? value) {
                  setState(() {
                    idTdnn1 = value?.id;
                  });
                },
                label: 'Trình độ học vấn',
                items: locator<List<TrinhDoHocVan>>(),
              ),
              const SizedBox(height: 16),
              GenericPicker<TrinhDoChuyenMon>(
                onChanged: (TrinhDoChuyenMon? value) {
                  setState(() {
                    idTdnn2 = value?.id;
                  });
                },
                label: 'Trình độ CMKT',
                items: locator<List<TrinhDoChuyenMon>>(),
              ),
              const SizedBox(height: 16),
              GenericPicker<NganhNgheChuyenNganh>(
                onChanged: (NganhNgheChuyenNganh? value) {
                  setState(() {
                    idTdth = value?.id;
                  });
                },
                label: 'Chuyên ngành đào tạo',
                items: locator<List<NganhNgheChuyenNganh>>(),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Trình độ khác 1',
                hintText: '',
                controller: trinhdok1,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Trình độ khác 2',
                hintText: 'Ngành nghề',
                controller: trinhdok2,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Trình độ kỹ năng nghề',
                hintText: 'Ngành nghề tuyển dụng',
                controller: trinhdoNghe,
              ),
              const SizedBox(height: 16),
              CustomTextField.numberGrok(
                labelText: 'Bậc',
                hintText: 'Ngành nghề',
                controller: bacNghe,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Language Skills Section
        _buildSectionHeader(theme, 'Kỹ năng ngoại ngữ'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ngoại ngữ 1',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GenericPicker<NgoaiNgu>(
                label: 'Chọn ngoại ngữ',
                items: locator<List<NgoaiNgu>>(),
                onChanged: (NgoaiNgu? value) {
                  setState(() {
                    idNndt1 = value?.id;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<TrinhDoNgoaiNgu>(
                label: 'Trình độ',
                items: locator<List<TrinhDoNgoaiNgu>>(),
                onChanged: (TrinhDoNgoaiNgu? value) {
                  setState(() {
                    idTdnn1 = value?.id;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomPickerMap(
                label: Text('Mức độ yêu cầu'),
                items: mucDoOptions,
                selectedItem: -1,
                onChanged: (mucDo) {
                  setState(() {
                    mucNn1 = mucDo;
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Ngoại ngữ 2',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GenericPicker<NgoaiNgu>(
                label: 'Chọn ngoại ngữ',
                items: locator<List<NgoaiNgu>>(),
                onChanged: (NgoaiNgu? value) {
                  setState(() {
                    idNndt2 = value?.id;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<TrinhDoNgoaiNgu>(
                label: 'Trình độ',
                items: locator<List<TrinhDoNgoaiNgu>>(),
                onChanged: (TrinhDoNgoaiNgu? value) {
                  setState(() {
                    idTdnn2 = value?.id;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomPickerMap(
                label: Text('Mức độ yêu cầu'),
                items: mucDoOptions,
                selectedItem: -1,
                onChanged: (mucDo) {
                  setState(() {
                    mucNn2 = mucDo;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Computer Skills Section
        _buildSectionHeader(theme, 'Kỹ năng tin học'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tin học văn phòng',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GenericPicker<TrinhDoTinHoc>(
                label: 'Trình độ tin học',
                items: locator<List<TrinhDoTinHoc>>(),
                onChanged: (TrinhDoTinHoc? value) {
                  setState(() {
                    idTdth = value?.id;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomPickerMap(
                label: Text('Mức độ yêu cầu'),
                items: mucDoOptions,
                selectedItem: -1,
                onChanged: (mucDo) {
                  setState(() {
                    mucTh = mucDo;
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Phần mềm khác',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GenericPicker<TrinhDoTinHoc>(
                label: 'Trình độ tin học',
                items: locator<List<TrinhDoTinHoc>>(),
                onChanged: (TrinhDoTinHoc? value) {
                  setState(() {
                    idTinhockhac = value?.id;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomPickerMap(
                label: Text('Mức độ yêu cầu'),
                items: mucDoOptions,
                selectedItem: -1,
                onChanged: (mucDo) {
                  setState(() {
                    mucThKhac = mucDo;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Working Conditions Section
        _buildSectionHeader(theme, 'Điều kiện việc làm'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nơi làm việc',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomCheckbox(
                label: 'Trong nhà',
                value: chkNl1,
                onChanged: (bool? value) {
                  setState(() {
                    chkNl1 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Ngoài trời',
                value: chkNl2,
                onChanged: (bool? value) {
                  setState(() {
                    chkNl2 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Hỗn hợp',
                value: chkNl3,
                onChanged: (bool? value) {
                  setState(() {
                    chkNl3 = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Trọng lượng nâng',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomCheckbox(
                label: 'Dưới 5kg',
                value: chkTl1,
                onChanged: (bool? value) {
                  setState(() {
                    chkTl1 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: '5-20kg',
                value: chkTl2,
                onChanged: (bool? value) {
                  setState(() {
                    chkTl2 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Trên 20kg',
                value: chkTl3,
                onChanged: (bool? value) {
                  setState(() {
                    chkTl3 = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Đứng/đi lại',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomCheckbox(
                label: 'Không có',
                value: chkDl1,
                onChanged: (bool? value) {
                  setState(() {
                    chkDl1 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Trung bình',
                value: chkDl2,
                onChanged: (bool? value) {
                  setState(() {
                    chkDl2 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Cần đứng đi lại nhiều',
                value: chkDl3,
                onChanged: (bool? value) {
                  setState(() {
                    chkDl3 = value ?? false;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Physical Requirements Section
        _buildSectionHeader(theme, 'Yêu cầu thể chất'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nghe/nói',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomCheckbox(
                label: 'Không cần thiết',
                value: chkNn1,
                onChanged: (bool? value) {
                  setState(() {
                    chkNn1 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Cơ bản',
                value: chkNn2,
                onChanged: (bool? value) {
                  setState(() {
                    chkNn2 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Quan trọng',
                value: chkNn3,
                onChanged: (bool? value) {
                  setState(() {
                    chkNn3 = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Thị lực',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomCheckbox(
                label: 'Mức bình thường',
                value: chkY01,
                onChanged: (bool? value) {
                  setState(() {
                    chkY01 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Nhìn được vật chi tiết nhỏ',
                value: chkY02,
                onChanged: (bool? value) {
                  setState(() {
                    chkY02 = value ?? false;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Hand Usage Section
        _buildSectionHeader(theme, 'Yêu cầu sử dụng tay'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thao tác bằng tay',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomCheckbox(
                label: 'Lắp ráp đồ vật lớn',
                value: chkTy1,
                onChanged: (bool? value) {
                  setState(() {
                    chkTy1 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Lắp ráp đồ vật nhỏ',
                value: chkTy2,
                onChanged: (bool? value) {
                  setState(() {
                    chkTy2 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Lắp ráp đồ vật rất nhỏ',
                value: chkTy3,
                onChanged: (bool? value) {
                  setState(() {
                    chkTy3 = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Dùng 2 tay',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomCheckbox(
                label: 'Cần 2 tay',
                value: chk2T1,
                onChanged: (bool? value) {
                  setState(() {
                    chk2T1 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Đôi khi cần 2 tay',
                value: chk2T2,
                onChanged: (bool? value) {
                  setState(() {
                    chk2T2 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Chỉ cần 1 tay',
                value: chk2T3,
                onChanged: (bool? value) {
                  setState(() {
                    chk2T3 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Tay trái',
                value: chk2T4,
                onChanged: (bool? value) {
                  setState(() {
                    chk2T4 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Tay phải',
                value: chk2T5,
                onChanged: (bool? value) {
                  setState(() {
                    chk2T5 = value ?? false;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Soft Skills Section
        _buildSectionHeader(theme, 'Kỹ năng mềm'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GenericPicker<KyNangMemModel>(
                label: 'Kỹ năng mềm',
                items: locator<List<KyNangMemModel>>(),
                onChanged: (KyNangMemModel? value) {
                  setState(() {
                    idKynang.text = value?.id.toString() ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomCheckbox(
                label: 'Giao tiếp',
                value: chkGt,
                onChanged: (bool? value) {
                  setState(() {
                    chkGt = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Thuyết trình',
                value: chkTtr,
                onChanged: (bool? value) {
                  setState(() {
                    chkTtr = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Quản lý thời gian',
                value: chkQltg,
                onChanged: (bool? value) {
                  setState(() {
                    chkQltg = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Quản lý nhân sự',
                value: chkNs,
                onChanged: (bool? value) {
                  setState(() {
                    chkNs = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Tổng hợp báo cáo',
                value: chkTh,
                onChanged: (bool? value) {
                  setState(() {
                    chkTh = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Thích ứng',
                value: chkTu,
                onChanged: (bool? value) {
                  setState(() {
                    chkTu = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Làm việc nhóm',
                value: chkNhom,
                onChanged: (bool? value) {
                  setState(() {
                    chkNhom = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Làm việc độc lập',
                value: chkDl,
                onChanged: (bool? value) {
                  setState(() {
                    chkDl = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Chịu được áp lực công việc',
                value: chkApl,
                onChanged: (bool? value) {
                  setState(() {
                    chkApl = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Kỹ năng khác',
                value: chkKhac,
                onChanged: (bool? value) {
                  setState(() {
                    chkKhac = value ?? false;
                  });
                },
              ),
              if (chkKhac)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 8.0),
                  child: CustomTextField(
                    controller: kynangkhac,
                    labelText: 'Nhập kỹ năng khác',
                    hintText: 'Mô tả kỹ năng khác...',
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Benefits Section
        _buildSectionHeader(theme, 'Chế độ phúc lợi'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hỗ trợ ăn',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomCheckbox(
                label: '1 bữa',
                value: chkPl01,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl01 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: '2 bữa',
                value: chkPl02,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl02 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: '3 bữa',
                value: chkPl03,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl03 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Tiền',
                value: chkPl04,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl04 = value ?? false;
                  });
                },
              ),
              if (chkPl04)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 8.0),
                  child: CustomTextField.number(
                    controller: tienPhucloiController,
                    labelText: 'Nhập số tiền hỗ trợ',
                    hintText: 'Số tiền...',
                  ),
                ),
              CustomCheckbox(
                label: 'Không hỗ trợ',
                value: chkPl05,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl05 = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Các phúc lợi khác',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomCheckbox(
                label: 'BHXH/BHTN/BHYT',
                value: chkPl06,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl06 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'BH Nhân thọ',
                value: chkPl07,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl07 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Trợ cấp thôi việc',
                value: chkPl08,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl08 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Nhà trẻ',
                value: chkPl09,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl09 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Xe đưa đón',
                value: chkPl10,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl10 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Hỗ trợ đi lại',
                value: chkPl11,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl11 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Kí túc xá',
                value: chkPl12,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl12 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Hỗ trợ nhà ở',
                value: chkPl13,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl13 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Đào tạo',
                value: chkPl14,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl14 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Thiết bị hỗ trợ người khuyết tật',
                value: chkPl15,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl15 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Cơ hội thăng tiến',
                value: chkPl16,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl16 = value ?? false;
                  });
                },
              ),
              CustomCheckbox(
                label: 'Phúc lợi khác',
                value: chkPl17,
                onChanged: (bool? value) {
                  setState(() {
                    chkPl17 = value ?? false;
                  });
                },
              ),
              if (chkPl17)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 8.0),
                  child: CustomTextField(
                    controller: phucloikhac,
                    labelText: 'Nhập phúc lợi khác',
                    hintText: 'Mô tả phúc lợi khác...',
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Job Details Section
        _buildSectionHeader(theme, 'Chi tiết công việc'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GenericPicker<KinhNghiemLamViec>(
                label: 'Kinh nghiệm',
                items: locator<List<KinhNghiemLamViec>>(),
                onChanged: (KinhNghiemLamViec? value) {
                  setState(() {
                    idKinhnghiem.text = value?.id.toString() ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<TinhThanhModel>(
                label: 'Nơi làm việc dự kiến',
                items: locator<List<TinhThanhModel>>(),
                onChanged: (TinhThanhModel? value) {
                  setState(() {
                    noiLvTinh.text = value?.matinh ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<LoaiHopDongLaoDong>(
                label: 'Loại hợp đồng lao động',
                items: locator<List<LoaiHopDongLaoDong>>(),
                onChanged: (LoaiHopDongLaoDong? value) {
                  setState(() {
                    idLoaiDhld = value?.id;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<HinhThucTuyenDung>(
                label: 'Hình thức tuyển dụng',
                items: locator<List<HinhThucTuyenDung>>(),
                onChanged: (HinhThucTuyenDung? value) {
                  setState(() {
                    idHinhthucTd.text = value?.id.toString() ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<HinhThucLamViecModel>(
                label: 'Hình thức làm việc',
                items: locator<List<HinhThucLamViecModel>>(),
                onChanged: (HinhThucLamViecModel? value) {
                  setState(() {
                    idHinhthuc.text = value?.id.toString() ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<MucDichLamViec>(
                label: 'Mục đích làm việc',
                items: locator<List<MucDichLamViec>>(),
                onChanged: (MucDichLamViec? value) {
                  setState(() {
                    idMucdich.text = value?.id.toString() ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<MucLuongMM>(
                label: 'Mức lương',
                items: locator<List<MucLuongMM>>(),
                onChanged: (MucLuongMM? value) {
                  setState(() {
                    idMucluong = value?.id;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextField.numberGrok(
                controller: tienluong,
                labelText: 'Mức lương',
                hintText: 'Nhập mức lương',
              ),
              const SizedBox(height: 16),
              GenericPicker<DoiTuong>(
                label: 'Đối tượng tuyển dụng',
                items: locator<List<DoiTuong>>(),
                onChanged: (DoiTuong? value) {
                  setState(() {
                    idDoituong = value?.id;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<DoTuoi>(
                label: 'Độ tuổi',
                items: locator<List<DoTuoi>>(),
                onChanged: (DoTuoi? value) {
                  setState(() {
                    idDoTuoi = value?.id;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomPickerMap(
                label: Text('Giới tính'),
                items: gioiTinhOptions,
                selectedItem: -1,
                onChanged: (dynamic value) {
                  setState(() {
                    idYcgt = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomPickDateTimeGrok(
                labelText: 'Thời hạn tuyển',
                onChanged: (value) {
                  setState(() {
                    thoihanTd = DateTime.parse(value!);
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomCheckbox(
                label: 'Tuyển dụng nội bộ',
                value: isDenKhiTuyenXong,
                onChanged: (bool? value) {
                  setState(() {
                    isDenKhiTuyenXong = value ?? false;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Information Section
        _buildSectionHeader(theme, 'Thông tin liên hệ'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: tenLienhe,
                labelText: 'Tên liên hệ',
                hintText: 'Nhập tên liên hệ',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: dienthoai,
                labelText: 'Điện thoại',
                hintText: 'Nhập điện thoại',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: email,
                labelText: 'Email',
                hintText: 'Nhập email',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: chucvu,
                labelText: 'Chức vụ',
                hintText: 'Nhập chức vụ',
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Additional Information Section
        _buildSectionHeader(theme, 'Thông tin bổ sung'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: hinhthuckhac,
                labelText: 'Hình thức khác',
                hintText: 'Nhập hình thức khác',
              ),
              const SizedBox(height: 16),
              GenericPicker<ManvNameModel>(
                label: 'Người liên hệ',
                items: locator<List<ManvNameModel>>(),
                onChanged: (ManvNameModel? value) {
                  setState(() {
                    userName = value?.id;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Notification Preferences Section
        _buildSectionHeader(theme, 'Tùy chọn thông báo'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCheckbox(
                label: 'Nhận thông báo qua SMS',
                value: nhanSms,
                onChanged: (bool? value) {
                  setState(() {
                    nhanSms = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 8),
              CustomCheckbox(
                label: 'Nhận thông báo qua Email',
                value: nhanEMail,
                onChanged: (bool? value) {
                  setState(() {
                    nhanEMail = value ?? false;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleSubmit() {
    // TODO: Implement form submission logic
    print('Submitting form...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('M01TT11'),
        ),
        body: StepperPage(
          steps: steps,
          stepContents: [_buildStep1(), _buildStep2(), _buildStep3()],
        ));
  }

  @override
  void dispose() {
    madk.dispose();
    idDoanhnghiep.dispose();
    idDn.dispose();
    tenDn.dispose();
    tenGd.dispose();
    idLhdn.dispose();
    diachiDn.dispose();
    idNkt.dispose();
    tenCv.dispose();
    motaCv.dispose();
    idBacHoc.dispose();
    trinhdok1.dispose();
    trinhdok2.dispose();
    trinhdoNghe.dispose();
    idTdnn1.dispose();
    idTdnn2.dispose();
    idTdth.dispose();
    idTinhockhac.dispose();
    idKynang.dispose();
    kynangkhac.dispose();
    idKinhnghiem.dispose();
    noiLvTinh.dispose();
    idHinhthuc.dispose();
    idMucdich.dispose();
    phucloikhac.dispose();
    tenLienhe.dispose();
    chucvu.dispose();
    dienthoai.dispose();
    email.dispose();
    hinhthuckhac.dispose();
    userName.dispose();
    matinh.dispose();
    mahuyen.dispose();
    maxa.dispose();
    idTuyenDung.dispose();
    quyenloi.dispose();
    tienPhucloiController.dispose(); // Dispose the new controller
    idHinhthucTd.dispose();
    tienluong.dispose();
  }
}
