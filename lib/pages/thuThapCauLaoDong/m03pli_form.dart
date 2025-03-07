import 'package:flutter/material.dart';

class Step1Form extends StatelessWidget {
  final TextEditingController tenDnController;
  final TextEditingController masothueController;
  final TextEditingController diachiDnController;

  const Step1Form({
    required Key key,
    required this.tenDnController,
    required this.masothueController,
    required this.diachiDnController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        children: [
          TextFormField(
            controller: tenDnController,
            decoration: InputDecoration(labelText: 'Tên Doanh Nghiệp'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: masothueController,
            decoration: InputDecoration(labelText: 'Mã Số Thuế'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: diachiDnController,
            decoration: InputDecoration(labelText: 'Địa Chỉ DN'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
        ],
      ),
    );
  }
}
