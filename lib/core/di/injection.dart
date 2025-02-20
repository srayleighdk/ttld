import 'package:get_it/get_it.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/services/chuyenmon_api_service.dart';
import 'package:ttld/core/services/doituongchinhsach_api_service.dart';
import 'package:ttld/core/services/hosoungvien_api_service.dart';
import 'package:ttld/core/services/ntd_api_service.dart';
import 'package:ttld/core/services/tttantat_api_service.dart';
import 'package:ttld/core/services/vieclam_ungvien_api_service.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository_impl.dart';
import 'package:ttld/features/user_group/repository/group_repository.dart';
import 'package:ttld/repositories/tblDmChucDanh/danhmuc_repository.dart';
import 'package:ttld/repositories/tblDmChucDanh/danhmuc_repository_impl.dart';
import 'package:ttld/repositories/tblDmChuyenMon/chuyenmon_repository.dart';
import 'package:ttld/repositories/tblDmChuyenMon/chuyenmon_repository_impl.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository_impl.dart';
import 'package:ttld/repositories/tblDmTTtantat/tantat_repository.dart';
import 'package:ttld/repositories/tblDmTTtantat/tantat_repository_impl.dart';
import 'package:ttld/repositories/tblViecLamUngVien/vieclam_ungvien_repository.dart';
import 'package:ttld/repositories/tblViecLamUngVien/vieclam_ungvien_repository_impl.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository_impl.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Register ApiClient as a singleton:
  locator.registerLazySingleton<ApiClient>(() => ApiClient());

  // Register repositories:
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepository(locator<ApiClient>().dio));
  locator.registerLazySingleton<LdRepository>(
      () => LdRepositoryImpl(locator<ApiClient>().dio));
  locator.registerLazySingleton<GroupRepository>(() => GroupRepository());

  //Register DanhMucRepository
  locator.registerLazySingleton<DanhMucRepository>(
      () => DanhMucRepositoryImpl(locator<ApiClient>().dio));

  locator.registerLazySingleton<ChuyenMonApiService>(
      () => ChuyenMonApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ChuyenMonRepository>(
      () => ChuyenMonRepositoryImpl(locator<ChuyenMonApiService>()));

  //Register DoiTuongChinhSach dependencies:
  locator.registerLazySingleton<DoiTuongChinhSachApiService>(
      () => DoiTuongChinhSachApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<DoiTuongChinhSachRepository>(() =>
      DoiTuongChinhSachRepositoryImpl(locator<DoiTuongChinhSachApiService>()));

  locator.registerLazySingleton<TinhTrangTanTatApiService>(
      () => TinhTrangTanTatApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TinhTrangTanTatRepository>(() =>
      TinhTrangTanTatRepositoryImpl(locator<TinhTrangTanTatApiService>()));

  locator.registerLazySingleton<HoSoUngVienApiService>(
      () => HoSoUngVienApiService(locator<ApiClient>().dio));

  locator.registerLazySingleton<ViecLamUngVienApiService>(
      () => ViecLamUngVienApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ViecLamUngVienRepository>(() =>
      ViecLamUngVienRepositoryImpl(
          viecLamUngVienApiService: locator<ViecLamUngVienApiService>()));

  locator.registerLazySingleton<NTDApiService>(() => NTDApiService());
  locator.registerLazySingleton<NTDRepository>(
      () => NTDRepositoryImpl(locator<NTDApiService>()));

  //Register Tinh, Huyen, Xa dependencies:
  locator.registerLazySingleton<TinhApiService>(() => TinhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TinhRepository>(() => TinhRepositoryImpl(tinhApiService: locator<TinhApiService>()));
  locator.registerLazySingleton<HuyenApiService>(() => HuyenApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HuyenRepository>(() => HuyenRepositoryImpl(huyenApiService: locator<HuyenApiService>()));
  locator.registerLazySingleton<XaApiService>(() => XaApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<XaRepository>(() => XaRepositoryImpl(xaApiService: locator<XaApiService>()));

  locator.registerFactory(() => TinhBloc(tinhRepository: locator<TinhRepository>()));
  locator.registerFactory(() => HuyenBloc(huyenRepository: locator<HuyenRepository>()));
  locator.registerFactory(() => XaBloc(xaRepository: locator<XaRepository>()));

  // OPTIONAL: Register ForgotPasswordBloc here if you want GetIt to manage it too
  // locator.registerFactory(() => ForgotPasswordBloc(locator<ApiClient>().dio));
}
