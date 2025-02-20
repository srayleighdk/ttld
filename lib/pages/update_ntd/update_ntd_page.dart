import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

class UpdateNTDPage extends StatefulWidget {
  static const routePath = '/update-ntd';
  const UpdateNTDPage({Key? key}) : super(key: key);

  @override
  _UpdateNTDPageState createState() => _UpdateNTDPageState();
}

class _UpdateNTDPageState extends State<UpdateNTDPage> {
  final _formKey = GlobalKey<FormState>();
  final _idDoanhNghiepController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ntdMadnController = TextEditingController();
  final _ntdTentatController = TextEditingController();
  final _ntdTenController = TextEditingController();
  final _ntdEmailController = TextEditingController();

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
      }
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
                TextFormField(
                  controller: _idDoanhNghiepController,
                  decoration: const InputDecoration(labelText: 'ID Doanh Nghiep'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ID Doanh Nghiep';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                TextFormField(
                  controller: _ntdMadnController,
                  decoration: const InputDecoration(labelText: 'NTD Madn'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter NTD Madn';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ntdTentatController,
                  decoration: const InputDecoration(labelText: 'NTD Tentat'),
                ),
                TextFormField(
                  controller: _ntdTenController,
                  decoration: const InputDecoration(labelText: 'NTD Ten'),
                ),
                TextFormField(
                  controller: _ntdEmailController,
                  decoration: const InputDecoration(labelText: 'NTD Email'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final ntdBloc = BlocProvider.of<NTDBloc>(context);
                        if (ntdBloc.state is NTDLoadedById) {
                          final originalNtd = (ntdBloc.state as NTDLoadedById).ntd;
                          if (originalNtd != null) {
                            final updatedNtd = originalNtd.copyWith(
                              idDoanhNghiep: _idDoanhNghiepController.text,
                              username: _usernameController.text,
                              password: _passwordController.text,
                              ntdMadn: _ntdMadnController.text,
                              ntdTentat: _ntdTentatController.text,
                              ntdTen: _ntdTenController.text,
                              ntdEmail: _ntdEmailController.text,
                            );
                            context.read<NTDBloc>().add(NTDUpdate(ntd: updatedNtd));
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
    _ntdMadnController.dispose();
    _ntdTentatController.dispose();
    _ntdTenController.dispose();
    _ntdEmailController.dispose();
    super.dispose();
  }
}
