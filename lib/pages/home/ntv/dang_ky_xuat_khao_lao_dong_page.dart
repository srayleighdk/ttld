import 'package:flutter/material.dart';
import 'package:ttld/pages/dang_ky_xkld/dang_ky_xkld_form.dart';

class DangKyXuatKhaoLaoDongPage extends StatelessWidget {
  const DangKyXuatKhaoLaoDongPage({super.key});

  static const String routePath = '/ntv_home/dang-ky-xuat-khao-lao-dong';

  @override
  Widget build(BuildContext context) {
    // Redirect to the new multi-step XKLD registration form
    return const DangKyXKLDForm();
  }
}
