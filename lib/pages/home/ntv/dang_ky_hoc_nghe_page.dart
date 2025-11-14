import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/hosoungvien_api_service.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/models/hoso_dtn/hoso_dtn_model.dart';
import 'package:ttld/pages/dang_ky_hoc_nghe/dang_ky_hoc_nghe_form.dart';
import 'package:ttld/utils/hoso_dtn_mapper.dart';

class DangKyHocNghePage extends StatefulWidget {
  const DangKyHocNghePage({super.key});

  static const String routePath = '/ntv_home/dang-ky-hoc-nghe';

  @override
  State<DangKyHocNghePage> createState() => _DangKyHocNghePageState();
}

class _DangKyHocNghePageState extends State<DangKyHocNghePage> {
  bool _isLoading = true;
  HosoDTN? _initialData;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final authState = locator<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _userId = authState.userId;
      
      try {
        // Fetch HoSoUngVien data for the current user
        final hosoUVService = locator<HoSoUngVienApiService>();
        final hosoUV = await hosoUVService.getHoSoUngVienByUserId(_userId!);

        // Pre-populate HosoDTN with HoSoUngVien data
        if (hosoUV != null && HosoDTNMapper.hasEssentialData(hosoUV)) {
          _initialData = HosoDTNMapper.fromHoSoUngVien(hosoUV);
          
          if (mounted) {
            // Show summary of pre-filled data
            final summary = HosoDTNMapper.getPrefilledSummary(hosoUV);
            ToastUtils.showInfoToast(context, summary);
          }
        }
      } catch (e) {
        // If error loading profile, just show empty form
        if (mounted) {
          ToastUtils.showWarningToast(
            context,
            'Không thể tải dữ liệu hồ sơ. Vui lòng nhập thủ công.',
          );
        }
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DangKyHocNgheForm(existingData: _initialData);
  }
}
