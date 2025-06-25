import 'package:get_it/get_it.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/trinh_do_hoc_van/trinh_do_hoc_van_bloc.dart';
import 'package:ttld/blocs/trinh_do_ngoai_ngu/trinh_do_ngoai_ngu_bloc.dart';
import 'package:ttld/blocs/trinh_do_tin_hoc/trinh_do_tin_hoc_bloc.dart';
import 'package:ttld/blocs/trinh_do_van_hoa/trinh_do_van_hoa_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/blocs/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/blocs/tblViecLamUngVien/vieclam_ungvien_bloc.dart';
import 'package:ttld/core/services/hosoungvien_api_service.dart';
import 'package:ttld/core/services/ntd_api_service.dart';
import 'package:ttld/core/services/ntv_api_service.dart';
import 'package:ttld/core/services/trinh_do_hoc_van_api_service.dart';
import 'package:ttld/core/services/trinh_do_ngoai_ngu_api_service.dart';
import 'package:ttld/core/services/trinh_do_tin_hoc_api_service.dart';
import 'package:ttld/core/services/trinh_do_van_hoa_api_service.dart';
import 'package:ttld/core/services/vieclam_ungvien_api_service.dart';
import 'package:ttld/pages/hosoungvien/bloc/hosoungvien_bloc.dart';
import 'package:ttld/repositories/tblHoSoUngVien/ntv_repository.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository_impl.dart';
import 'package:ttld/repositories/tblViecLamUngVien/vieclam_ungvien_repository.dart';
import 'package:ttld/repositories/tblViecLamUngVien/vieclam_ungvien_repository_impl.dart';
import 'package:ttld/repositories/trinh_do_hoc_van/trinh_do_hoc_van_repository.dart';
import 'package:ttld/repositories/trinh_do_ngoai_ngu/trinh_do_ngoai_ngu_repository.dart';
import 'package:ttld/repositories/trinh_do_tin_hoc/trinh_do_tin_hoc_repository.dart';
import 'package:ttld/repositories/trinh_do_van_hoa/trinh_do_van_hoa_repository.dart';

final locator = GetIt.instance;

Future<void> setupProfileLocator() async {
  // HoSoUngVien
  locator.registerLazySingleton<HoSoUngVienApiService>(
      () => HoSoUngVienApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton(() =>
      HoSoUngVienBloc(hoSoUngVienApiService: locator<HoSoUngVienApiService>()));

  // ViecLamUngVien
  locator.registerLazySingleton<ViecLamUngVienApiService>(
      () => ViecLamUngVienApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ViecLamUngVienRepository>(() =>
      ViecLamUngVienRepositoryImpl(
          viecLamUngVienApiService: locator<ViecLamUngVienApiService>()));
  locator.registerLazySingleton(() => ViecLamUngVienBloc(
      viecLamUngVienRepository: locator<ViecLamUngVienRepository>()));

  // NTD
  locator.registerLazySingleton<NTDApiService>(() => NTDApiService());
  locator.registerLazySingleton<NTDRepository>(
      () => NTDRepositoryImpl(locator<NTDApiService>()));
  locator.registerLazySingleton(() => NTDBloc(locator<NTDRepository>()));

  // NTV
  locator.registerLazySingleton<NTVApiService>(() => NTVApiService());
  locator.registerLazySingleton<NTVRepository>(
      () => NTVRepository(locator<NTVApiService>()));
  locator.registerLazySingleton(() => NTVBloc(locator<NTVRepository>()));

  // Trinh Do Tin Hoc
  locator.registerLazySingleton<TrinhDoTinHocApiService>(
      () => TrinhDoTinHocApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TrinhDoTinHocRepository>(
      () => TrinhDoTinHocRepositoryImpl(locator<TrinhDoTinHocApiService>()));
  locator.registerLazySingleton(
      () => TrinhDoTinHocBloc(locator<TrinhDoTinHocRepository>()));

  // Trinh Do Ngoai Ngu
  locator.registerLazySingleton<TrinhDoNgoaiNguApiService>(
      () => TrinhDoNgoaiNguApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TrinhDoNgoaiNguRepository>(() =>
      TrinhDoNgoaiNguRepositoryImpl(locator<TrinhDoNgoaiNguApiService>()));
  locator.registerLazySingleton(
      () => TrinhDoNgoaiNguBloc(locator<TrinhDoNgoaiNguRepository>()));
  // Trinh Do Hoc Van
  locator.registerLazySingleton<TrinhDoHocVanApiService>(
      () => TrinhDoHocVanApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TrinhDoHocVanRepository>(
      () => TrinhDoHocVanRepositoryImpl(locator<TrinhDoHocVanApiService>()));
  locator.registerLazySingleton(
      () => TrinhDoHocVanBloc(locator<TrinhDoHocVanRepository>()));

  // Trinh Do Van Hoa
  locator.registerLazySingleton<TrinhDoVanHoaApiService>(
      () => TrinhDoVanHoaApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TrinhDoVanHoaRepository>(
      () => TrinhDoVanHoaRepositoryImpl(locator<TrinhDoVanHoaApiService>()));
  locator.registerLazySingleton(
      () => TrinhDoVanHoaBloc(locator<TrinhDoVanHoaRepository>()));
}
