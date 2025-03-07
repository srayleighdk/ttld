// Step form widgets
import 'package:flutter/material.dart';
import 'package:ttld/models/m03pli_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class Step1Form extends StatefulWidget {
  TextEditingController? tenDnController;
  TextEditingController? masothueController;
  TextEditingController? daidienController;
  TextEditingController? diachiDnController;
  TextEditingController? dienthoaiController;
  TextEditingController? emailController;
  TextEditingController? tenCvController;
  TextEditingController? motaCvController;
  String? idLhdn;
  String? idNkt;
  String? matinh;
  String? mahuyen;
  String? maxa;
  String? idKhuCn;
  bool? chkNl;
  bool? chkCn;
  bool? chkSxpp;
  bool? chkVtkb;
  bool? chkTttt;
  bool? chkBds;
  bool? chkDvhc;
  bool? chkYt;
  bool? chkBbl;
  bool? chkThue;
  bool? chkKk;
  bool? chkXd;
  bool? chkCcn;
  bool? chkDvlt;
  bool? chkTcnh;
  bool? chkKhcn;
  bool? chkGd;
  bool? chkNt;
  bool? chkHdxh;
  bool? chkDv;
  bool? chkHdqt;

  Step1Form({
    required Key key,
    this.tenDnController,
    this.masothueController,
    this.diachiDnController,
    this.daidienController,
    this.dienthoaiController,
    this.emailController,
    this.tenCvController,
    this.motaCvController,
    this.idLhdn,
    this.idNkt,
    this.matinh,
    this.mahuyen,
    this.maxa,
    this.idKhuCn,
    this.chkNl,
    this.chkCn,
    this.chkSxpp,
    this.chkVtkb,
    this.chkTttt,
    this.chkBds,
    this.chkDvhc,
    this.chkYt,
    this.chkBbl,
    this.chkThue,
    this.chkKk,
    this.chkXd,
    this.chkCcn,
    this.chkDvlt,
    this.chkTcnh,
    this.chkKhcn,
    this.chkGd,
    this.chkNt,
    this.chkHdxh,
    this.chkDv,
    this.chkHdqt,
  }) : super(key: key);

  @override
  State<Step1Form> createState() => _Step1FormState();
}

class _Step1FormState extends State<Step1Form> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.key,
      child: Column(
        children: [
          CustomTextField(
            controller: widget.tenDnController,
            validator: (value) => value!.isEmpty ? 'Required' : null,
            hintText: '',
          ),
          CustomTextField(
            controller: widget.masothueController,
            hintText: 'Mã Số Thuế',
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          CustomTextField(
            controller: widget.daidienController,
            hintText: 'Địa Chỉ DN',
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          CustomTextField(
            controller: widget.diachiDnController,
            hintText: 'Đại Diện',
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          CustomTextField(
            controller: widget.dienthoaiController,
            hintText: 'Điện Thoại',
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          CustomTextField(
            controller: widget.emailController,
            hintText: 'Email',
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
        ],
      ),
    );
  }
}

class Step2Form extends StatelessWidget {
  final TextEditingController tenLienheController;
  final TextEditingController dienthoaiController;
  final TextEditingController emailController;

  const Step2Form({
    required Key key,
    required this.tenLienheController,
    required this.dienthoaiController,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        children: [
          TextFormField(
            controller: tenLienheController,
            decoration: InputDecoration(labelText: 'Tên Liên Hệ'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: dienthoaiController,
            decoration: InputDecoration(labelText: 'Điện Thoại'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
        ],
      ),
    );
  }
}

class Step3Form extends StatefulWidget {
  final M03PLIModel m03pli;

  const Step3Form({required Key key, required this.m03pli}) : super(key: key);

  @override
  _Step3FormState createState() => _Step3FormState();
}

class _Step3FormState extends State<Step3Form> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.key,
      child: Column(
        children: [
          CheckboxListTile(
            title: Text('Tư vấn CS'),
            value: widget.m03pli.chkTuvanCs,
            onChanged: (value) =>
                setState(() => widget.m03pli.chkTuvanCs = value ?? false),
          ),
          CheckboxListTile(
            title: Text('Tư vấn VL'),
            value: widget.m03pli.chkTuvanVl,
            onChanged: (value) =>
                setState(() => widget.m03pli.chkTuvanVl = value ?? false),
          ),
          CheckboxListTile(
            title: Text('Tư vấn DT'),
            value: widget.m03pli.chkTuvanDt,
            onChanged: (value) =>
                setState(() => widget.m03pli.chkTuvanDt = value ?? false),
          ),
        ],
      ),
    );
  }
}
