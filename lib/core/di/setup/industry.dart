import 'package:ttld/blocs/chuc_danh/chuc_danh_bloc.dart';
import 'package:ttld/blocs/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_bloc.dart';
import 'package:ttld/blocs/loai_hinh/loai_hinh_bloc.dart';
import 'package:ttld/blocs/nganh_nghe/nganh_nghe_bloc.dart';
import 'package:ttld/blocs/nganh_nghe/nganh_nghe_capdo_bloc.dart';
import 'package:ttld/blocs/nganh_nghe/nganh_nghe_chuyennganh_bloc.dart';
import 'package:ttld/blocs/nganh_nghe/nganh_nghe_td_bloc.dart';
import 'package:ttld/blocs/nganh_nghe/nganh_nghe_bachoc_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/services/chuc_danh_api_service.dart';
import 'package:ttld/core/services/hinhthuc_doanhnghiep_api_service.dart';
import 'package:ttld/core/services/loai_hinh_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_capdo_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_chuyennganh_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_td_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_bachoc_api_service.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_repository.dart';
import 'package:ttld/repositories/loai_hinh/loai_hinh_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_capdo_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_chuyennganh_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_td_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_bachoc_repository.dart';
import 'package:ttld/core/di/injection.dart';

Future<void> setupIndustryLocator() async {
  // LoaiHinh
  locator.registerLazySingleton<LoaiHinhApiService>(
      () => LoaiHinhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<LoaiHinhRepository>(() =>
      LoaiHinhRepositoryImpl(
          loaiHinhApiService: locator<LoaiHinhApiService>()));
  locator.registerLazySingleton(
      () => LoaiHinhBloc(loaiHinhRepository: locator<LoaiHinhRepository>()));

  // NganhNghe
  locator.registerLazySingleton<NganhNgheApiService>(
      () => NganhNgheApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NganhNgheRepository>(() =>
      NganhNgheRepositoryImpl(
          nganhNgheApiService: locator<NganhNgheApiService>()));
  locator.registerLazySingleton(
      () => NganhNgheBloc(nganhNgheRepository: locator<NganhNgheRepository>()));

  // NganhNgheTD
  locator.registerLazySingleton<NganhNgheTDApiService>(
      () => NganhNgheTDApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NganhNgheTDRepository>(() =>
      NganhNgheTDRepositoryImpl(
          nganhNgheTDApiService: locator<NganhNgheTDApiService>()));
  locator.registerLazySingleton<NganhNgheTDBloc>(
      () => NganhNgheTDBloc(nganhNgheTDRepository: locator<NganhNgheTDRepository>()));

  // NganhNgheBacHoc
  locator.registerLazySingleton<NganhNgheBacHocApiService>(
      () => NganhNgheBacHocApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NganhNgheBacHocRepository>(() =>
      NganhNgheBacHocRepositoryImpl(
          nganhNgheBacHocApiService: locator<NganhNgheBacHocApiService>()));
  locator.registerLazySingleton<NganhNgheBacHocBloc>(
      () => NganhNgheBacHocBloc(nganhNgheBacHocRepository: locator<NganhNgheBacHocRepository>()));

  // Chuc Danh
  locator.registerLazySingleton<ChucDanhApiService>(
      () => ChucDanhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ChucDanhRepository>(() =>
      ChucDanhRepositoryImpl(
          chucDanhApiService: locator<ChucDanhApiService>()));
  locator.registerLazySingleton(
      () => ChucDanhBloc(chucDanhRepository: locator<ChucDanhRepository>()));

  // NganhNgheCapDo
  locator.registerLazySingleton<NganhNgheCapDoApiService>(
      () => NganhNgheCapDoApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NganhNgheCapDoRepository>(() =>
      NganhNgheCapDoRepositoryImpl(
          nganhNgheCapDoApiService: locator<NganhNgheCapDoApiService>()));
  locator.registerLazySingleton(() => NganhNgheCapDoBloc(
      nganhNgheCapDoRepository: locator<NganhNgheCapDoRepository>()));

  // NganhNgheChuyenNganh
  locator.registerLazySingleton<NganhNgheChuyenNganhApiService>(
      () => NganhNgheChuyenNganhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NganhNgheChuyenNganhRepository>(() =>
      NganhNgheChuyenNganhRepositoryImpl(
          nganhNgheChuyenNganhApiService:
              locator<NganhNgheChuyenNganhApiService>()));
  locator.registerLazySingleton(() => NganhNgheChuyenNganhBloc(
      nganhNgheChuyenNganhRepository:
          locator<NganhNgheChuyenNganhRepository>()));

  // HinhThucDoanhNghiep
  locator.registerLazySingleton<HinhThucDoanhNghiepApiService>(
      () => HinhThucDoanhNghiepApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HinhThucDoanhNghiepRepository>(() =>
      HinhThucDoanhNghiepRepositoryImpl(
          hinhThucDoanhNghiepApiService:
              locator<HinhThucDoanhNghiepApiService>()));
  locator.registerLazySingleton(() => HinhThucDoanhNghiepBloc(
      hinhThucDoanhNghiepRepository: locator<HinhThucDoanhNghiepRepository>()));
}
