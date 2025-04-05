import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/hinh_thuc_loai_hinh_model.dart';
import 'package:ttld/models/m01tt11_model.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nganh_nghe_chuyennganh.dart';
import 'package:ttld/models/nganh_nghe_model.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/models/ngoai_ngu_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/widgets/cascade_level_pick_grok.dart';
import 'package:ttld/widgets/cascade_location_picker_grok.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
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
  BigInt tienluong = BigInt.from(0);
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
      matinh.text = widget.ntd!.ntdDiachithanhpho ?? '';
      mahuyen.text = widget.ntd!.ntdDiachihuyen ?? '';
      maxa.text = widget.ntd!.ntdDiachixaphuong ?? '';
      idKhuCn = widget.ntd!.ntdThuockhucongnghiep;
    }
  }

  int currentStep = 0;

  final List<String> steps = [
    'Thông tin\nDoanh nghiệp',
    'Thông tin\ntuyển dụng',
    // 'Thông tin\nliên hệ',
    // 'Nhật ký\ntuyển dụng',
  ];

  Widget get stepContent {
    switch (currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add your form fields for step 1
        const Text('Step 1 Content'),
        // Example form fields:
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
        const SizedBox(
          height: 16,
        ),
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
        const SizedBox(
          height: 16,
        ),
        CascadeLocationPickerGrok(
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
              idKhuCn = kcn?.kcnId;
            });
          },
        ),
        const SizedBox(height: 16),
        Text('Lĩnh vực sản xuất kinh doanh kèm theo:'),
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
            label: 'Công nghiệp, chế  biến, chế tạo',
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
            label: 'Hoạt động làm thuê và các công việc trong hộ gia đình',
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
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add your form fields for step 2
        const Text('Step 2 Content'),
        // Example confirmation details:
        CustomTextField(
          hintText: 'Tên công việc',
          labelText: 'Tên công việc',
          controller: tenCv,
        ),
        const SizedBox(
          height: 14,
        ),
        CustomTextField.number(
          hintText: 'Số lượng tuyển',
          labelText: 'Số lượng tuyển',
          controller: soluong,
        ),
        const SizedBox(
          height: 14,
        ),
        CustomTextField.textArea(
          hintText: 'Mô tả công việc',
          labelText: 'Mô tả công việc',
          controller: motaCv,
          maxLines: 5,
          minLines: 3,
        ),
        GenericPicker<NganhNgheTD>(
          onChanged: (NganhNgheTD? value) {
            setState(() {
              nganhId = value?.id;
            });
          },
          label: 'Ngành nghề tuyển dụng',
          items: locator<List<NganhNgheTD>>(),
        ),
        GenericPicker<ChucDanhModel>(
          onChanged: (ChucDanhModel? value) {
            setState(() {
              idChucvu = value?.id;
            });
          },
          label: 'Chức vụ',
          items: locator<List<ChucDanhModel>>(),
        ),
        NganhNgheCapDoPicker(),
        GenericPicker<TrinhDoHocVan>(
          onChanged: (TrinhDoHocVan? value) {
            setState(() {
              idTdnn1 = value?.id;
            });
          },
          label: 'Trình độ học vấn',
          items: locator<List<TrinhDoHocVan>>(),
        ),
        GenericPicker<TrinhDoChuyenMon>(
          onChanged: (TrinhDoChuyenMon? value) {
            setState(() {
              idTdnn2 = value?.id;
            });
          },
          label: 'Trình độ CMKT',
          items: locator<List<TrinhDoChuyenMon>>(),
        ),
        GenericPicker<NganhNgheChuyenNganh>(
          onChanged: (NganhNgheChuyenNganh? value) {
            setState(() {
              idTdth = value?.id;
            });
          },
          label: 'Chuyên ngành đào tạo',
          items: locator<List<NganhNgheChuyenNganh>>(),
        ),
        CustomTextField(
          labelText: 'Trình độ khác 1',
          hintText: '',
          controller: trinhdok1,
        ),
        CustomTextField(
          labelText: 'Trình độ khác 2',
          hintText: 'Ngành nghề',
          controller: trinhdok2,
        ),
        CustomTextField(
          labelText: 'Trình độ kỹ năng nghề',
          hintText: 'Ngành nghề tuyển dụng',
          controller: trinhdoNghe,
        ),
        CustomTextField.numberGrok(
          labelText: 'Bậc',
          hintText: 'Ngành nghề',
          controller: bacNghe,
        ),
        GenericPicker<NgoaiNgu>(
          label: 'Ngoại ngữ 1',
          items: locator<List<NgoaiNgu>>(),
          onChanged: (NgoaiNgu? value) {
            setState(() {
              idNndt1 = value?.id;
            });
          },
        ),
        GenericPicker<TrinhDoNgoaiNgu>(
          label: 'Ngoại ngữ 2',
          items: locator<List<TrinhDoNgoaiNgu>>(),
          onChanged: (TrinhDoNgoaiNgu? value) {
            setState(() {
              idTdnn1 = value?.id;
            });
          },
        ),
        CustomPickerMap(
          label: Text('Mức độ 1'),
          items: mucDoOptions,
          selectedItem: -1,
          onChanged: (mucDo) {
            setState(() {
              mucNn1 = mucDo;
            });
          },
        ),

        GenericPicker<NgoaiNgu>(
          label: 'Ngoại ngữ 2',
          items: locator<List<NgoaiNgu>>(),
          onChanged: (NgoaiNgu? value) {
            setState(() {
              idNndt2 = value?.id;
            });
          },
        ),
        GenericPicker<TrinhDoNgoaiNgu>(
          label: 'Ngoại ngữ 2',
          items: locator<List<TrinhDoNgoaiNgu>>(),
          onChanged: (TrinhDoNgoaiNgu? value) {
            setState(() {
              idTdnn2 = value?.id;
            });
          },
        ),
        CustomPickerMap(
          label: Text('Mức độ 1'),
          items: mucDoOptions,
          selectedItem: -1,
          onChanged: (mucDo) {
            setState(() {
              mucNn2 = mucDo;
            });
          },
        ),
        GenericPicker<TrinhDoTinHoc>(
          label: 'Trình độ tin học',
          items: locator<List<TrinhDoTinHoc>>(),
          onChanged: (TrinhDoTinHoc? value) {
            setState(() {
              idTdth = value?.id;
            });
          },
        ),
        CustomPickerMap(
          label: Text('Mức độ 1'),
          items: mucDoOptions,
          selectedItem: -1,
          onChanged: (mucDo) {
            setState(() {
              mucTh = mucDo;
            });
          },
        ),

        GenericPicker<TrinhDoTinHoc>(
          label: 'Trình độ tin học',
          items: locator<List<TrinhDoTinHoc>>(),
          onChanged: (TrinhDoTinHoc? value) {
            setState(() {
              idTinhockhac = value?.id;
            });
          },
        ),
        CustomPickerMap(
          label: Text('Mức độ 1'),
          items: mucDoOptions,
          selectedItem: -1,
          onChanged: (mucDo) {
            setState(() {
              mucThKhac = mucDo;
            });
          },
        ),
        const SizedBox(height: 16),
        const Text('Điều kiện việc làm:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Nơi làm việc:',
            style: TextStyle(fontWeight: FontWeight.w500)),
        CustomCheckbox(
            label: 'Trong nhà',
            value: chkNl1,
            onChanged: (bool? value) {
              setState(() {
                chkNl1 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Ngoài trời',
            value: chkNl2,
            onChanged: (bool? value) {
              setState(() {
                chkNl2 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Hỗn hợp',
            value: chkNl3,
            onChanged: (bool? value) {
              setState(() {
                chkNl3 = value ?? false;
              });
            }),
        const SizedBox(height: 8),
        const Text('Trọng lượng nâng:',
            style: TextStyle(fontWeight: FontWeight.w500)),
        CustomCheckbox(
            label: 'Dưới 5kg',
            value: chkTl1,
            onChanged: (bool? value) {
              setState(() {
                chkTl1 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: '5-20kg',
            value: chkTl2,
            onChanged: (bool? value) {
              setState(() {
                chkTl2 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Trên 20kg',
            value: chkTl3,
            onChanged: (bool? value) {
              setState(() {
                chkTl3 = value ?? false;
              });
            }),
        const SizedBox(height: 8),
        const Text('Đứng/đi lại:',
            style: TextStyle(fontWeight: FontWeight.w500)),
        CustomCheckbox(
            label: 'Không có',
            value: chkDl1,
            onChanged: (bool? value) {
              setState(() {
                chkDl1 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Trung bình',
            value: chkDl2,
            onChanged: (bool? value) {
              setState(() {
                chkDl2 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Cần đứng đi lại nhiều',
            value: chkDl3,
            onChanged: (bool? value) {
              setState(() {
                chkDl3 = value ?? false;
              });
            }),
        const SizedBox(height: 8),
        const Text('Nghe/nói:', style: TextStyle(fontWeight: FontWeight.w500)),
        CustomCheckbox(
            label: 'Không cần thiết',
            value: chkNn1,
            onChanged: (bool? value) {
              setState(() {
                chkNn1 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Cơ bản',
            value: chkNn2,
            onChanged: (bool? value) {
              setState(() {
                chkNn2 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Quan trọng',
            value: chkNn3,
            onChanged: (bool? value) {
              setState(() {
                chkNn3 = value ?? false;
              });
            }),
        const SizedBox(height: 8),
        const Text('Thị lực:', style: TextStyle(fontWeight: FontWeight.w500)),
        CustomCheckbox(
            label: 'Mức bình thường',
            value: chkY01, // Assuming chkY01 corresponds to 'Mức bình thường'
            onChanged: (bool? value) {
              setState(() {
                chkY01 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Nhìn được vật chi tiết nhỏ',
            value:
                chkY02, // Assuming chkY02 corresponds to 'Nhìn được vật chi tiết nhỏ'
            onChanged: (bool? value) {
              setState(() {
                chkY02 = value ?? false;
              });
            }),
        const SizedBox(height: 8),
        const Text('Thao tác bằng tay:',
            style: TextStyle(fontWeight: FontWeight.w500)),
        CustomCheckbox(
            label: 'Lắp ráp đồ vật lớn',
            value: chkTy1,
            onChanged: (bool? value) {
              setState(() {
                chkTy1 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Lắp ráp đồ vật nhỏ',
            value: chkTy2,
            onChanged: (bool? value) {
              setState(() {
                chkTy2 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Lắp ráp đồ vật rất nhỏ',
            value: chkTy3,
            onChanged: (bool? value) {
              setState(() {
                chkTy3 = value ?? false;
              });
            }),
        const SizedBox(height: 8),
        const Text('Dùng 2 tay:',
            style: TextStyle(fontWeight: FontWeight.w500)),
        CustomCheckbox(
            label: 'Cần 2 tay',
            value: chk2T1,
            onChanged: (bool? value) {
              setState(() {
                chk2T1 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Đôi khi cần 2 tay',
            value: chk2T2,
            onChanged: (bool? value) {
              setState(() {
                chk2T2 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Chỉ cần 1 tay',
            value: chk2T3,
            onChanged: (bool? value) {
              setState(() {
                chk2T3 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Tay trái',
            value: chk2T4,
            onChanged: (bool? value) {
              setState(() {
                chk2T4 = value ?? false;
              });
            }),
        CustomCheckbox(
            label: 'Tay phải',
            value: chk2T5,
            onChanged: (bool? value) {
              setState(() {
                chk2T5 = value ?? false;
              });
            }),
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
          stepContents: [_buildStep1(), _buildStep2()],
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
  }
}
