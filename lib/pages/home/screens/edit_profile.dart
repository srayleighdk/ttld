import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/ds-ld/bloc/ld_bloc.dart';
import 'package:ttld/features/ds-ld/models/ld.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  final String? profileId;
  const EditProfileScreen({super.key, this.profileId});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final Map<String, TextEditingController> _controllers = {
    'maphieu': TextEditingController(),
    'hoten': TextEditingController(),
    'soCmnd': TextEditingController(),
    'masoBhxh': TextEditingController(),
    'diachiHk': TextEditingController(),
    'diachiTt': TextEditingController(),
    'viecdanglam': TextEditingController(),
    'noilamviec': TextEditingController(),
    'diachiNoilamviec': TextEditingController(),
    'ghichu': TextEditingController(),
    'tenNguoiViet': TextEditingController(),
    'dienthoai': TextEditingController(),
    'email': TextEditingController(),
  };

  // @override
  // void initState() {
  //   super.initState();
  //   _loadLd();
  //   if (widget.profileId != null) {
  //     _loadLd();
  //   } else {
  //     final userId = context.read<AuthBloc>().state.userId;
  //     if (userId != null) {
  //       context.read<LdBloc>().add(InitializeNewLd(userId: userId));
  //     } else {
  //       ToastUtils.showToastDanger(
  //         context,
  //         description: 'User ID not found',
  //       );
  //       context.pop(); // Navigate back if no user ID
  //     }
  //   }
  // }

  void _loadLd() {
    context.read<LdBloc>().add(LoadLd(id: widget.profileId));
  }

  void _updateControllers(LdModel ld) {
    _controllers['maphieu']?.text = ld.maphieu;
    _controllers['hoten']?.text = ld.hoten;
    _controllers['soCmnd']?.text = ld.soCMND ?? '';
    _controllers['masoBhxh']?.text = ld.masoBHXH ?? '';
    _controllers['diachiHk']?.text = ld.diachiHK ?? '';
    _controllers['diachiTt']?.text = ld.diachiTT ?? '';
    _controllers['viecdanglam']?.text = ld.viecdanglam;
    _controllers['noilamviec']?.text = ld.noilamviec ?? '';
    _controllers['diachiNoilamviec']?.text = ld.diachiNoilamviec ?? '';
    _controllers['ghichu']?.text = ld.ghichu ?? '';
    _controllers['tenNguoiViet']?.text = ld.tenNguoiViet ?? '';
    _controllers['dienthoai']?.text = ld.dienthoai ?? '';
    _controllers['email']?.text = ld.email ?? '';
  }

  void _saveLd(LdLoaded state) {
    if (!_formKey.currentState!.validate()) {
      ToastUtils.showToastWarning(
        context,
        description: 'Please fill in all required fields correctly',
      );
      return;
    }

    try {
      final updatedLd = state.ld.copyWith(
        maphieu:
            state.isNewLd ? _controllers['maphieu']!.text : state.ld.maphieu,
        hoten: _controllers['hoten']!.text,
        soCMND: _controllers['soCMND']!.text,
        masoBHXH: _controllers['masoBHXH']!.text,
        diachiHK: _controllers['diachiHK']!.text,
        diachiTT: _controllers['diachiTT']!.text,
        viecdanglam: _controllers['viecdanglam']!.text,
        noilamviec: _controllers['noilamviec']!.text,
        diachiNoilamviec: _controllers['diachiNoilamviec']!.text,
        ghichu: _controllers['ghichu']!.text,
        tenNguoiViet: _controllers['tenNguoiViet']!.text,
        dienthoai: _controllers['dienthoai']!.text,
        email: _controllers['email']!.text,
      );

      context.read<LdBloc>().add(
            SaveLd(
              ld: updatedLd,
              isNewLd: state.isNewLd,
            ),
          );
    } catch (e) {
      ToastUtils.showToastDanger(
        context,
        title: 'Error',
        description: 'Failed to save LD: ${e.toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profileId == null ? 'Create LD' : 'Edit LD'),
      ),
      body: BlocConsumer<LdBloc, LdState>(
        listener: (context, state) {
          if (state is LdError) {
            ToastUtils.showToastDanger(
              context,
              title: 'Error',
              description: state.message,
            );
          }

          if (state is LdSaved) {
            ToastUtils.showToastSuccess(
              context,
              title: 'Success',
              description: state.message,
              message: 'Success',
            );
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is LdLoading) {
            print('state is LdLoading');
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LdLoaded) {
            _updateControllers(state.ld);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.isNewLd) ...[
                        CustomTextField(
                          controller: _controllers['maphieu']!,
                          labelText: 'Mã phiếu',
                          hintText: 'Mã phiếu',
                        ),
                        const SizedBox(height: 16),
                      ],
                      CustomTextField(
                        controller: _controllers['hoten']!,
                        labelText: 'Họ tên',
                        hintText: 'Họ tên',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _controllers['soCmnd']!,
                        labelText: 'Số CMND',
                        hintText: 'Số CMND',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _controllers['masoBhxh']!,
                        labelText: 'Mã số BHXH',
                        hintText: 'Mã số BHXH',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _controllers['diachiHk']!,
                        labelText: 'Địa chỉ hộ khẩu',
                        hintText: 'Địa chỉ hộ khẩu',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _controllers['diachiTt']!,
                        labelText: 'Địa chỉ thường trú',
                        hintText: 'Địa chỉ thường trú',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _controllers['viecdanglam']!,
                        labelText: 'Việc đang làm',
                        hintText: 'Việc đang làm',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _controllers['noilamviec']!,
                        labelText: 'Nơi làm việc',
                        hintText: 'Nơi làm việc',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _controllers['diachiNoilamviec']!,
                        labelText: 'Địa chỉ nơi làm việc',
                        hintText: 'Địa chỉ nơi làm việc',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _controllers['ghichu']!,
                        labelText: 'Ghi chú',
                        hintText: 'Ghi chú',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _controllers['tenNguoiViet']!,
                        labelText: 'Tên người viết',
                        hintText: 'Tên người viết',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _controllers['dienthoai']!,
                        labelText: 'Điện thoại',
                        hintText: 'Điện thoại',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField.email(
                        controller: _controllers['email']!,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _saveLd(state),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              state.isNewLd ? 'Create LD' : 'Save Changes',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Something went wrong'),
                ElevatedButton(
                  onPressed: () {
                    ToastUtils.showToastInfo(
                      context,
                      description: 'Reloading LD...',
                    );
                    _loadLd();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // void _loadProfile() {
  //   try {
  //     context.read<ProfileBloc>().add(LoadProfile(id: widget.profileId));
  //   } catch (e) {
  //     ToastUtils.showToastDanger(
  //       context,
  //       title: 'Error',
  //       description: 'Failed to load profile: ${e.toString()}',
  //     );
  //   }
  // }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
