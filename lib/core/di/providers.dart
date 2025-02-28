import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/chuc_danh/chuc_danh_bloc.dart';
import 'package:ttld/bloc/huyen/huyen_bloc.dart';
import 'package:ttld/bloc/kcn/kcn_cubit.dart';
import 'package:ttld/bloc/quocgia/quocgia_bloc.dart';
import 'package:ttld/bloc/tinh/tinh_bloc.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/bloc/xa/xa_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/danhmuc_kcn_api_service.dart';
import 'package:ttld/core/services/hosoungvien_api_service.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/login_bloc.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/features/ds-ld/bloc/ld_bloc.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';
import 'package:ttld/features/user_group/bloc/group_bloc.dart';
import 'package:ttld/features/user_group/repository/group_repository.dart';
import 'package:ttld/pages/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:ttld/pages/hosoungvien/bloc/hosoungvien_bloc.dart';
import 'package:ttld/pages/signup/bloc/signup_bloc.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/huyen/huyen_repository.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';
import 'package:ttld/repositories/tblViecLamUngVien/vieclam_ungvien_repository.dart';
import 'package:ttld/repositories/tinh/tinh_repository.dart';
import 'package:ttld/repositories/xa/xa_repository.dart';
import 'package:ttld/bloc/ntv/ntv_bloc.dart'; // Import NtvBloc

import '../../bloc/tblViecLamUngVien/vieclam_ungvien_bloc.dart';

List<BlocProvider> getBlocProviders() {
  return [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
    ),
    BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(
        authRepository: locator<AuthRepository>(),
      ),
    ),
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        authRepository: locator<AuthRepository>(),
        authBloc: context.read<AuthBloc>(),
      ),
    ),
    BlocProvider<LdBloc>(
      create: (context) => LdBloc(
        locator<LdRepository>(),
      ),
    ),
    BlocProvider<GroupBloc>(
      create: (context) => GroupBloc(
        groupRepository: locator<GroupRepository>(),
      ),
    ),
    BlocProvider<ForgotPasswordBloc>(
      create: (context) => ForgotPasswordBloc(ApiClient().dio),
    ),
    BlocProvider<HoSoUngVienBloc>(
      create: (context) => HoSoUngVienBloc(
          hoSoUngVienApiService: locator<HoSoUngVienApiService>()),
    ),
    BlocProvider<ViecLamUngVienBloc>(
      create: (context) => ViecLamUngVienBloc(
          viecLamUngVienRepository: locator<ViecLamUngVienRepository>()),
    ),
    BlocProvider<NTDBloc>(
      create: (context) => NTDBloc(
        locator<NTDRepository>(),
      ),
    ),
    BlocProvider<TinhBloc>(
      create: (context) => TinhBloc(
        tinhRepository: locator<TinhRepository>(),
      ),
    ),
    BlocProvider<HuyenBloc>(
      create: (context) => HuyenBloc(
        huyenRepository: locator<HuyenRepository>(),
      ),
    ),
    BlocProvider<XaBloc>(
      create: (context) => XaBloc(
        xaRepository: locator<XaRepository>(),
      ),
    ),
    BlocProvider<QuocGiaBloc>(
      create: (context) => QuocGiaBloc(
        quocGiaRepository: locator<QuocGiaRepository>(),
      ),
    ),
    BlocProvider<ChucDanhBloc>(
      create: (context) => ChucDanhBloc(
        chucDanhRepository: locator<ChucDanhRepository>(),
      ),
    ),
    BlocProvider<KcnCubit>(
      create: (context) => KcnCubit(locator<DanhMucKcnApiService>()),
    ),
    BlocProvider<NtvBloc>( // Add NtvBloc
      create: (context) => NtvBloc(ntvRepository: locator<NtvRepository>()),
    ),
  ];
}
