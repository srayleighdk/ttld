import 'package:flutter/material.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

class CreateTuyenDungPage extends StatelessWidget {
  final Ntd? ntd;
  static const routePath = '/ntd_home/create_tuyen_dung';
  const CreateTuyenDungPage({super.key, this.ntd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm tuyển dụng mới'),
      ),
      body: Center(
        child: Text('Thêm tuyển dụng mới'),
      ),
    );
  }
}
