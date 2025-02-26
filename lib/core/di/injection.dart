import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/bloc/chuc_danh/chuc_danh_bloc.dart';
import 'package:ttld/bloc/ntv/ntv_bloc.dart';
import 'package:ttld/core/services/ntv_api_service.dart';
import 'package:ttld/bloc/huyen/huyen_bloc.dart';
import 'package:ttld/bloc/nganh_nghe/nganh_nghe_bloc.dart';
import 'package:ttld/bloc/quocgia/quocgia_bloc.dart';
import 'package:ttld/bloc/tinh/tinh_bloc.dart';
import 'package:ttld/bloc/xa/xa_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/services/auth_api_service.dart';
import 'package:ttld/core/services/chuc_danh_api_service.dart';
import 'package:ttld/core/services/chuyenmon_api_service.dart';
import 'package:ttld/core/services/danhmuc_kcn_api_service.dart';
import 'package:ttld/core/services/doituongchinhsach_api_service.dart';
import 'package:ttld/core/services/hinhthuc_doanhnghiep_api_service.dart';
import 'package:ttld/core/services/hosoungvien_api_service.dart';
import 'package:ttld/core/services/huyen_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_api_service.dart';
import 'package:ttld/core/services/ntd_api_service.dart';
import 'package:ttld/core/services/quocgia_api_service.dart';
import 'package:ttld/core/services/thoigianhoatdong_api_service.dart';
import 'package:ttld/core/services/tinh_api_service.dart';
import 'package:ttld/core/services/tttantat_api_service.dart';
import 'package:ttld/core/services/vieclam_ungvien_api_service.dart';
import 'package:ttld/core/services/xa_api_service.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository_impl.dart';
import 'package:ttld/features/user_group/repository/group_repository.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_repository.dart';
import 'package:ttld/repositories/huyen/huyen_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_repository.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';
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
import 'package:ttld/repositories/ntv_repository.dart';
import 'package:ttld/repositories/tinh/tinh_repository.dart';
import 'package:ttld/repositories/xa/xa_repository.dart';
import 'package:ttld/bloc/kcn/kcn_cubit.dart';

final locator = GetIt.instance;

void setupLocator() async {
  // Register SharedPreferences as a singleton:
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => prefs);

  // Register FlutterSecureStorage as a singleton:
  locator.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());

  // Register ApiClient as a singleton:
  locator.registerLazySingleton<ApiClient>(() => ApiClient());

  // Register AuthApiService as a singleton:
  locator.registerLazySingleton<AuthApiService>(() => AuthApiService(locator<ApiClient>()));

  // Register repositories:
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepository(
          authApiService: locator<AuthApiService>(),
          prefs: locator<SharedPreferences>(),
          storage: locator<FlutterSecureStorage>()));
  locator.registerLazySingleton<LdRepository>(
      () => LdRepositoryImpl(locator<ApiClient>().dio));
  locator.registerLazySingleton<GroupRepository>(() => GroupRepository());

  //Register DanhMucRepository
  // locator.registerLazySingleton<DanhMucKcnRepository>(
  //     () => DanhMucRepositoryImpl(locator<ApiClient>().dio));

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
  locator.registerLazySingleton<TinhApiService>(
      () => TinhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TinhRepository>(
      () => TinhRepositoryImpl(tinhApiService: locator<TinhApiService>()));
  locator.registerLazySingleton<HuyenApiService>(
      () => HuyenApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HuyenRepository>(
      () => HuyenRepositoryImpl(huyenApiService: locator<HuyenApiService>()));
  locator.registerLazySingleton<XaApiService>(
      () => XaApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<XaRepository>(
      () => XaRepositoryImpl(xaApiService: locator<XaApiService>()));

  locator.registerFactory(
      () => TinhBloc(tinhRepository: locator<TinhRepository>()));
  locator.registerFactory(
      () => HuyenBloc(huyenRepository: locator<HuyenRepository>()));
  locator.registerFactory(() => XaBloc(xaRepository: locator<XaRepository>()));
  //KCN
  locator.registerLazySingleton<DanhMucKcnApiService>(
      () => DanhMucKcnApiService(locator<ApiClient>().dio));
  locator.registerFactory(
      () => KcnCubit(DanhMucKcnApiService(locator<ApiClient>().dio)));

  locator.registerLazySingleton<QuocGiaApiService>(
      () => QuocGiaApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<QuocGiaRepository>(
    () =>
        QuocGiaRepositoryImpl(quocGiaApiService: locator<QuocGiaApiService>()),
  );

  locator.registerFactory(
      () => QuocGiaBloc(quocGiaRepository: locator<QuocGiaRepository>()));

  //HinhThucDoanhNghiep

  //LoaiHinh

  //NganhNghe
  locator.registerLazySingleton<NganhNgheApiService>(
      () => NganhNgheApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NganhNgheRepository>(() =>
      NganhNgheRepositoryImpl(
          nganhNgheApiService: locator<NganhNgheApiService>()));
  locator.registerFactory(
      () => NganhNgheBloc(nganhNgheRepository: locator<NganhNgheRepository>()));

  // Chức Danh

  locator.registerLazySingleton<ChucDanhApiService>(
      () => ChucDanhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ChucDanhRepository>(() =>
      ChucDanhRepositoryImpl(
          chucDanhApiService: locator<ChucDanhApiService>()));
  locator.registerFactory(
      () => ChucDanhBloc(chucDanhRepository: locator<ChucDanhRepository>()));

  //HinhThucDoanhNghiep
  locator.registerLazySingleton<HinhThucDoanhNghiepApiService>(
      () => HinhThucDoanhNghiepApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HinhThucDoanhNghiepRepository>(() =>
      HinhThucDoanhNghiepRepositoryImpl(
          hinhThucDoanhNghiepApiService:
              locator<HinhThucDoanhNghiepApiService>()));

  //ThoiGianHoatDong
  locator.registerLazySingleton<ThoiGianHoatDongApiService>(
      () => ThoiGianHoatDongApiService(locator<ApiClient>().dio));

  //ThoiGianLamViec

  //NguonViecLam

  //NguonThuThap

  //DanToc

  //TonGiao

  //TrinhDoVanHoa

  //TrinhDoHocVan

  //TrinhDoTinHoc

  //TrinhDoNgoaiNgu

  //HinhThucDaoTao

  //HinhThucLoaiHinh

  //HinhThucDiaDiem

  //TinhTrangViecLam

  //LoaiViecLam

  // NTV
  locator.registerLazySingleton<NtvApiService>(
      () => NtvApiService(baseUrl: 'YOUR_BASE_URL')); // Replace with your base URL
  locator.registerLazySingleton<NtvRepository>(
      () => NtvRepository(apiService: locator<NtvApiService>()));
  locator.registerFactory(() => NtvBloc(ntvRepository: locator<NtvRepository>()));
}
