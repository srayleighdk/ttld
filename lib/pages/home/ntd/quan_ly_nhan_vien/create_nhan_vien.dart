import 'package:flutter/material.dart';

class CreateNhanVien extends StatefulWidget {
  const CreateNhanVien({super.key});

  static const String routePath = '/create_nhan_vien';

  @override
  State<CreateNhanVien> createState() => _CreateNhanVienState();
}

class _CreateNhanVienState extends State<CreateNhanVien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo Nhà Văn'),
      ),
      body: Center(
        child: Text('Tạo Nhà Văn'),
      ),
    );
  }
}
