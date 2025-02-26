import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/ntv/ntv_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_repository.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';
import 'package:ttld/widgets/cascade_location_picker.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
import 'package:ttld/widgets/field/custom_pick_date.dart';
import 'package:ttld/widgets/field/custom_pick_year.dart';
import 'package:ttld/widgets/field/custom_picker.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class UpdateNTVPage extends StatefulWidget {
  static const routePath = '/update_ntv';
  const UpdateNTVPage({super.key});

  @override
  _UpdateNTVPageState createState() => _UpdateNTVPageState();
}

class _UpdateNTVPageState extends State<UpdateNTVPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  // Add controllers for NTV specific fields here

  bool _newletterSubscription = false;
  bool _jobsletterSubscription = false;

  String? _selectedTinh;
  String? _selectedHuyen;
  String? _selectedXa;

  List<QuocGia> _quocGias = [];
  QuocGia? quocGia;

  List<ChucDanhModel> _chucDanhs = [];
  ChucDanhModel? chucDanh;

  List<HinhThucDoanhNghiep> _hinhthucDoanhNghieps = [];
  HinhThucDoanhNghiep? hinhthucDoanhNghiep;

  @override
  void initState() {
    super.initState();
    _loadChucDanh();
  }

  Future<void> _loadChucDanh() async {
    final chucDanhRepository = locator<ChucDanhRepository>();
    try {
      final chucDanhs = await chucDanhRepository.getChucDanhs();

      if (mounted) {
        setState(() {
          _chucDanhs = chucDanhs;
        });
      }
    } catch (e, stackTrace) {
      // Added stackTrace
      print("Error loading chuc danh: $e");
    }
  }

  Future<void> _loadQuocGias(int? maQuocGia) async {
    final quocGiaRepository = locator<QuocGiaRepository>();
    try {
      final quocGias = await quocGiaRepository.getQuocGias();
      if (mounted) {
        setState(() {
          _quocGias = quocGias;
        });
      }
    } catch (e) {
      // Handle error (e.g., show a snackbar)
      print("Error loading countries: $e");
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
      }
    } catch (e) {
      // Handle error (e.g., show a snackbar)
      print("Error loading countries: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update NTV'),
      ),
      body: BlocListener<NtvBloc, NtvState>(
        listener: (context, state) {
          if (state is NtvLoaded) {
            Navigator.pop(context);
          }
          if (state is NtvError) {
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
                const SizedBox(height: 10.0),
                Text("Thông tin tài khoản"),
                const SizedBox(height: 16.0),
                CustomTextField.email(
                  // controller: _ntdEmailController, // Replace with NTV email controller
                  labelText: "Email",
                  hintText: 'Email',
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  labelText: "Username",
                  // controller: _usernameController, // Replace with NTV username controller
                  hintText: 'Username',
                ),
                const SizedBox(height: 16.0),
                CustomTextField.password(
                  // controller: _passwordController, // Replace with NTV password controller
                ),
                const SizedBox(height: 16.0),
                // Add more NTV specific fields here
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // final ntvBloc = BlocProvider.of<NtvBloc>(context);
                        // if (ntvBloc.state is NtvLoadedById) {
                        //   final originalNtv =
                        //       (ntvBloc.state as NtvLoadedById).ntv;
                        //   if (originalNtv != null) {
                        //     final updatedNtv = originalNtv.copyWith(
                        //       // Update NTV fields here
                        //     );
                        //     context.read<NtvBloc>().add(NtvUpdate(updatedNtv));
                        //   }
                        // }
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
    _usernameController.dispose();
    _passwordController.dispose();
    // Dispose of NTV specific controllers here
    super.dispose();
  }
}
