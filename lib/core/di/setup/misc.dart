import 'package:get_it/get_it.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/blocs/chapnoi/chapnoi_bloc.dart';
import 'package:ttld/blocs/kcn/kcn_cubit.dart';
import 'package:ttld/blocs/kieuchapnoi/kieuchapnoi_cubit.dart';
import 'package:ttld/blocs/kinh_nghiem_lam_viec/kinh_nghiem_lam_viec_bloc.dart';
import 'package:ttld/blocs/ky_nang_mem/ky_nang_mem_bloc.dart';
import 'package:ttld/blocs/ngoai_ngu/ngoai_ngu_cubit.dart';
import 'package:ttld/blocs/sgdvl/sgdvl_bloc.dart';
import 'package:ttld/blocs/uv_dk_sgd/uv_dk_sgd_bloc.dart';
import 'package:ttld/services/chapnoi_api_service.dart';
import 'package:ttld/core/services/danhmuc_kcn_api_service.dart';
import 'package:ttld/core/services/kinh_nghiem_lam_viec_api_service.dart';
import 'package:ttld/core/services/sgdvl_api_service.dart';
import 'package:ttld/core/services/tinh_thanh_api_service.dart';
import 'package:ttld/core/services/tinh_trang_hd_api_service.dart';
import 'package:ttld/core/services/uv_dk_sgd_api_service.dart';
import 'package:ttld/cubit/tinhtrang_hd_cubit.dart';
import 'package:ttld/features/user_group/bloc/group_bloc.dart';
import 'package:ttld/features/user_group/repository/group_repository.dart';
import 'package:ttld/repositories/chapnoi_repository.dart';
import 'package:ttld/repositories/kieuchapnoi_repository.dart';
import 'package:ttld/repositories/kinh_nghiem_lam_viec_repository.dart';
import 'package:ttld/repositories/ky_nang_mem_repository.dart';
import 'package:ttld/repositories/ngoai_ngu/ngoai_ngu_repository.dart';
import 'package:ttld/repositories/sgdvl_repository.dart';
import 'package:ttld/repositories/tinh_trang_hd_repository.dart';
import 'package:ttld/repositories/user/user_repository.dart';
import 'package:ttld/repositories/uv_dk_sgd_repository.dart';
import 'package:ttld/blocs/hinh_thuc_loai_hinh/hinh_thuc_loai_hinh_bloc.dart';
import 'package:ttld/repositories/hinh_thuc_loai_hinh/hinh_thuc_loai_hinh_repository.dart';
import 'package:ttld/core/services/hinh_thuc_loai_hinh_api_service.dart';
import 'package:ttld/services/api/ky_nang_mem_api_service.dart';
import 'package:ttld/blocs/tinh_thanh/tinh_thanh_cubit.dart';

final locator = GetIt.instance;

Future<void> setupMiscLocator() async {
  // KCN
  locator.registerLazySingleton<DanhMucKcnApiService>(
      () => DanhMucKcnApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton(
      () => KcnCubit(DanhMucKcnApiService(locator<ApiClient>().dio)));

  // TinhThanh
  locator.registerLazySingleton<TinhThanhApiService>(
      () => TinhThanhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton(() =>
      TinhThanhCubit(tinhThanhApiService: locator<TinhThanhApiService>()));

  // Tinh Trang Hop Dong Cubit
  locator.registerLazySingleton<TinhTrangHdApiService>(
      () => TinhTrangHdApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TinhTrangHdRepository>(
      () => TinhTrangHdRepositoryImpl(locator<TinhTrangHdApiService>()));
  locator.registerLazySingleton(
      () => TinhTrangHdCubit(locator<TinhTrangHdRepository>()));

  // NgoaiNgu
  locator.registerLazySingleton<NgoaiNguRepository>(
      () => NgoaiNguRepositoryImpl(locator<ApiClient>()));
  locator.registerFactory(() => NgoaiNguCubit(locator<NgoaiNguRepository>()));

  // KinhNghiemLamViec
  locator.registerLazySingleton<KinhNghiemLamViecApiService>(
      () => KinhNghiemLamViecApiService(locator<ApiClient>()));
  locator.registerLazySingleton<KinhNghiemLamViecRepository>(() =>
      KinhNghiemLamViecRepositoryImpl(locator<KinhNghiemLamViecApiService>()));
  locator.registerFactory(
      () => KinhNghiemLamViecBloc(locator<KinhNghiemLamViecRepository>()));

  // Ky Nang Mem
  locator.registerLazySingleton<KyNangMemApiService>(
      () => KyNangMemApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<KyNangMemRepository>(
      () => KyNangMemRepository(locator<KyNangMemApiService>()));
  locator.registerLazySingleton(
      () => KyNangMemBloc(locator<KyNangMemRepository>()));

  // ChapNoi dependencies
  locator.registerLazySingleton<ChapNoiApiService>(
      () => ChapNoiApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ChapNoiRepository>(
      () => ChapNoiRepository(locator<ChapNoiApiService>()));
  locator
      .registerLazySingleton(() => ChapNoiBloc(locator<ChapNoiRepository>()));

  // KieuChapNoi
  locator.registerLazySingleton<KieuChapNoiRepository>(
      () => KieuChapNoiRepository(locator<ApiClient>()));
  locator.registerFactory(
      () => KieuChapNoiCubit(locator<KieuChapNoiRepository>()));

  // SGDVL
  locator.registerLazySingleton<SGDVLApiService>(
      () => SGDVLApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<SGDVLRepository>(
      () => SGDVLRepositoryImpl(sgdvlApiService: locator<SGDVLApiService>()));
  locator.registerLazySingleton(() => SGDVLBloc(locator<SGDVLRepository>()));

  // UvDkSGD
  locator.registerLazySingleton<UvDkSGDApiService>(
      () => UvDkSGDApiServiceImpl(locator<ApiClient>().dio));
  locator.registerLazySingleton<UvDkSGDRepository>(
      () => UvDkSGDRepositoryImpl(locator<UvDkSGDApiService>()));
  locator.registerFactory<UvDkSGDBloc>(
      () => UvDkSGDBloc(locator<UvDkSGDRepository>()));

  // Hinh Thuc Loai Hinh
  locator.registerLazySingleton<HinhThucLoaiHinhApiService>(
      () => HinhThucLoaiHinhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HinhThucLoaiHinhRepository>(() =>
      HinhThucLoaiHinhRepositoryImpl(
          hinhThucLoaiHinhApiService: locator<HinhThucLoaiHinhApiService>()));
  locator.registerLazySingleton(() => HinhThucLoaiHinhBloc(
      hinhThucLoaiHinhRepository: locator<HinhThucLoaiHinhRepository>()));

  // GroupBloc and related
  locator.registerLazySingleton<GroupRepository>(
      () => GroupRepository(userRepository: locator<UserRepository>()));
  locator.registerLazySingleton(
      () => GroupBloc(groupRepository: locator<GroupRepository>()));
}
