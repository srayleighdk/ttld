import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/bloc/m03pli/m03pli_bloc.dart';
import 'package:ttld/bloc/m03pli/m03pli_state.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/models/m03pli_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

class DangKySuDungLaoDong03PLI extends StatefulWidget {
  final Ntd? ntd;
  static const routePath = '/dang-ky-su-dung-lao-dong-03pli';
  const DangKySuDungLaoDong03PLI({super.key, this.ntd});

  @override
  State<DangKySuDungLaoDong03PLI> createState() =>
      _DangKySuDungLaoDong03PLIState();
}

class _DangKySuDungLaoDong03PLIState extends State<DangKySuDungLaoDong03PLI> {
  late List<GlobalKey<FormState>?> _formKeys;

  M03PLIModel m03pli = M03PLIModel(
    idphieu: "2",
    ngaylap: DateTime.parse("2024-07-08T17:00:00.000Z"),
    madk: "1/240709144708",
    idDoanhnghiep: "1656",
    idDn: "4101562154",
    tenDn: "Công ty CP Wecare Group",
    tenGd: "Phạm Thị Ái Xuân",
    masothue: "4101562154",
    idLhdn: "TN",
    matinh: "52",
    mahuyen: "52001",
    maxa: "52001004",
    idKhuCn: 0,
    diachiDn:
        "Lô B39 KCN Phú Tài, phường Bùi Thị Xuân, Tp. Quy NHơn, Bình Định",
    idNkt: "BBL",
    chkNl: false,
    chkCn: false,
    chkSxpp: false,
    chkVtkb: false,
    chkTttt: false,
    chkBds: false,
    chkDvhc: false,
    chkYt: false,
    chkBbl: true,
    chkThue: false,
    chkKk: false,
    chkXd: false,
    chkCcn: false,
    chkDvlt: false,
    chkTcnh: false,
    chkKhcn: false,
    chkGd: false,
    chkNt: false,
    chkHdxh: false,
    chkDv: false,
    chkHdqt: false,
    idQuymo: 1,
    soluong: 10,
    ngaydky: DateTime.parse("2024-07-09T07:47:08.057Z"),
    chkTuvanCs: true,
    chkTuvanVl: false,
    chkTuvanDt: false,
    chkDKy03A: false,
    dKyKhac: "",
    tenLienhe: "Phạm Thị Ái Xuân",
    chucvu: "nhân viên",
    dienthoai: "0965167350",
    email: "",
    nhanSms: true,
    nhanEMail: true,
    hinhthuckhac: "",
    userName: "NDD",
    displayOrder: 1,
    createdDate: DateTime.parse("2024-07-09T07:47:08.057Z"),
    createdBy: "NDD",
    modifiredDate: DateTime.parse("2024-07-09T08:00:52.207Z"),
    modifiredBy: "NDD",
    status: true,
  );

  @override
  void initState() {
    super.initState();
    if (widget.ntd != null) {
      m03pli.idDoanhnghiep = widget.ntd!.idDoanhNghiep;
      m03pli.tenDn = widget.ntd!.ntdTen;
      m03pli.masothue = widget.ntd!.mst;
      m03pli.idLhdn = widget.ntd!.idLoaiHinhDoanhNghiep;
      m03pli.matinh = widget.ntd!.ntdDiachithanhpho.toString();
      m03pli.mahuyen = widget.ntd!.ntdDiachihuyen;
      m03pli.maxa = widget.ntd!.ntdDiachixaphuong;
      m03pli.idKhuCn = widget.ntd!.ntdThuockhucongnghiep;
      m03pli.diachiDn = widget.ntd!.ntdDiachichitiet;
      m03pli.idNkt = widget.ntd!.idNganhKinhTe;
      m03pli.tenLienhe = widget.ntd!.ntdNguoilienhe;
      m03pli.tenGd = widget.ntd!.ntdNguoilienhe;
      m03pli.dienthoai = widget.ntd!.ntdDienthoai;
      m03pli.email = widget.ntd!.ntdEmail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update NTV'),
      ),
      body: BlocListener<M03PLIBloc, M03PLIState>(
        listener: (context, state) {
          if (state is M03PLILoaded) {
            Navigator.pop(context);
          }
          if (state is M03PLIError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is M03PLIUpdated) {
            ToastUtils.showToastSuccess(
              context,
              message: 'Cập nhật thành công',
              description: 'Test',
            );
            context.go('/ntv_home');
          }
        },
        child: Column(
            // children: [
            //   Row(
            //     children: List.generate(
            //       steps.length,
            //       (index) => buildStepIndicator(
            //         index: index,
            //         currentStep: _currentStep,
            //         steps: steps,
            //       ),
            //     ),
            //   ),
            //   Expanded(
            //     child: buildStepContent(
            //       currentStep: _currentStep,
            //       stepWidgets: widget.stepContents,
            //     ),
            //   ),
            //   buildBottomNavigation(
            //     currentStep: _currentStep,
            //     steps: widget.steps,
            //     formKeys: _formKeys,
            //     onSubmit: _submitForm,
            //     onStepChanged: (newStep) => setState(() => _currentStep = newStep),
            //   ),
            // ],
            ),
      ),
    );
  }
}

const List<String> steps = [
  'Thông tin\ncá nhân',
  'Hiện thị\nthông tin',
  'Việc làm\nmong muốn',
  'Xác nhận',
];
final List<Widget> stepContents = [
  Step1Form(),
  Step2Form(),
  Step3Form(),
  ConfirmationForm(),
];

Widget Step1Form() {
  return Container();
}

Widget Step2Form() {
  return Container();
}

Widget Step3Form() {
  return Container();
}

Widget ConfirmationForm() {
  return Container();
}
