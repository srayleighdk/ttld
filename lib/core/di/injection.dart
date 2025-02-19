import 'package:get_it/get_it.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/services/chuyenmon_api_service.dart';
import 'package:ttld/core/services/doituongchinhsach_api_service.dart';
import 'package:ttld/core/services/hosoungvien_api_service.dart';
import 'package:ttld/core/services/tttantat_api_service.dart';
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

  // OPTIONAL: Register ForgotPasswordBloc here if you want GetIt to manage it too
  // locator.registerFactory(() => ForgotPasswordBloc(locator<ApiClient>().dio));
}
