import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/bloc/chuc_danh/chuc_danh_bloc.dart';
import 'package:ttld/core/services/dan_toc_api_service.dart';
import 'package:ttld/core/services/hinh_thuc_dao_tao_api_service.dart';
import 'package:ttld/core/services/hinh_thuc_dia_diem_api_service.dart';
import 'package:ttld/core/services/hinh_thuc_loai_hinh_api_service.dart';
import 'package:ttld/core/services/loai_vl_api_service.dart';
import 'package:ttld/core/services/muc_luong_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_bachoc_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_td_api_service.dart';
import 'package:ttld/core/services/nguon_thuthap_api_service.dart';
import 'package:ttld/core/services/nguon_vieclam_api_service.dart';
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
import 'package:ttld/core/services/thoigianlamviec_api_service.dart';
import 'package:ttld/core/services/tinh_api_service.dart';
import 'package:ttld/core/services/tinh_trangvl_api_service.dart';
import 'package:ttld/core/services/trinh_do_hoc_van_api_service.dart';
import 'package:ttld/core/services/trinh_do_ngoai_ngu_api_service.dart';
import 'package:ttld/core/services/trinh_do_tin_hoc_api_service.dart';
import 'package:ttld/core/services/trinh_do_van_hoa_api_service.dart';
import 'package:ttld/core/services/tt_tantat_api_service.dart';
import 'package:ttld/core/services/vieclam_ungvien_api_service.dart';
import 'package:ttld/core/services/xa_api_service.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/core/services/tinh_thanh_api_service.dart';
import 'package:ttld/bloc/tinh_thanh/tinh_thanh_cubit.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository_impl.dart';
import 'package:ttld/features/user_group/repository/group_repository.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/dan_toc/dan_toc_repository.dart';
import 'package:ttld/repositories/hinh_thuc_dao_tao/hinh_thuc_dao_tao_repository.dart';
import 'package:ttld/repositories/hinh_thuc_dia_diem/hinh_thuc_dia_diem_repository.dart';
import 'package:ttld/repositories/hinh_thuc_loai_hinh/hinh_thuc_loai_hinh_repository.dart';
import 'package:ttld/repositories/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_repository.dart';
import 'package:ttld/repositories/huyen/huyen_repository.dart';
import 'package:ttld/repositories/loai_vl/loai_vl_repository.dart';
import 'package:ttld/repositories/muc_luong/muc_luong_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_bachoc_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_td_repository.dart';
import 'package:ttld/repositories/nguon_thuthap/nguon_thuthap_repository.dart';
import 'package:ttld/repositories/nguon_vieclam/nguon_vieclam_repository.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';
import 'package:ttld/repositories/tblDmChuyenMon/chuyenmon_repository.dart';
import 'package:ttld/repositories/tblDmChuyenMon/chuyenmon_repository_impl.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository_impl.dart';
import 'package:ttld/repositories/tblHoSoUngVien/ntv_repository.dart';
import 'package:ttld/repositories/tblViecLamUngVien/vieclam_ungvien_repository.dart';
import 'package:ttld/repositories/tblViecLamUngVien/vieclam_ungvien_repository_impl.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository_impl.dart';
import 'package:ttld/repositories/thoigianlamviec/thoigianlamviec_repository.dart';
import 'package:ttld/repositories/tinh/tinh_repository.dart';
import 'package:ttld/repositories/tinh_trangvl/tinh_trangvl_repository.dart';
import 'package:ttld/repositories/trinh_do_hoc_van/trinh_do_hoc_van_repository.dart';
import 'package:ttld/repositories/trinh_do_ngoai_ngu/trinh_do_ngoai_ngu_repository.dart';
import 'package:ttld/repositories/trinh_do_tin_hoc/trinh_do_tin_hoc_repository.dart';
import 'package:ttld/repositories/trinh_do_van_hoa/trinh_do_van_hoa_repository.dart';
import 'package:ttld/repositories/tt_tantat/tt_tantat_repository.dart';
import 'package:ttld/repositories/xa/xa_repository.dart';
import 'package:ttld/bloc/kcn/kcn_cubit.dart';

final locator = GetIt.instance;

void setupLocator() async {
  // Register SharedPreferences as a singleton:
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => prefs);

  // Register FlutterSecureStorage as a singleton:
  locator.registerLazySingleton<FlutterSecureStorage>(
      () => FlutterSecureStorage());

  // Register ApiClient as a singleton:
  locator.registerLazySingleton<ApiClient>(() => ApiClient());

  // Register AuthApiService as a singleton:
  locator.registerLazySingleton<AuthApiService>(
      () => AuthApiService(locator<ApiClient>()));

  // Register repositories:
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository(
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
  locator.registerLazySingleton<DoiTuongApiService>(
      () => DoiTuongApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<DoiTuongRepository>(
      () => DoiTuongRepositoryImpl(locator<DoiTuongApiService>()));

  locator.registerLazySingleton<HoSoUngVienApiService>(
      () => HoSoUngVienApiService(locator<ApiClient>().dio));

  locator.registerLazySingleton<ViecLamUngVienApiService>(
      () => ViecLamUngVienApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ViecLamUngVienRepository>(() =>
      ViecLamUngVienRepositoryImpl(
          viecLamUngVienApiService: locator<ViecLamUngVienApiService>()));

  // NTD
  locator.registerLazySingleton<NTDApiService>(() => NTDApiService());
  locator.registerLazySingleton<NTDRepository>(
      () => NTDRepositoryImpl(locator<NTDApiService>()));

  // NTV
  locator.registerLazySingleton<NTVApiService>(
      () => NTVApiService()); // Replace with your base URL
  locator.registerLazySingleton<NTVRepository>(
      () => NTVRepository(locator<NTVApiService>()));

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

  //ThoiGianHoatDong
  locator.registerLazySingleton<ThoiGianHoatDongApiService>(
      () => ThoiGianHoatDongApiService(locator<ApiClient>().dio));

  //ThoiGianLamViec
  locator.registerLazySingleton<ThoiGianLamViecApiService>(
      () => ThoiGianLamViecApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ThoiGianLamViecRepository>(() =>
      ThoiGianLamViecRepositoryImpl(
          thoiGianLamViecApiService: locator<ThoiGianLamViecApiService>()));

  //NguonViecLam
  locator.registerLazySingleton<NguonViecLamApiService>(
      () => NguonViecLamApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NguonViecLamRepository>(() =>
      NguonViecLamRepositoryImpl(
          nguonViecLamApiService: locator<NguonViecLamApiService>()));

  //NguonThuThap
  locator.registerLazySingleton<NguonThuThapApiService>(
      () => NguonThuThapApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NguonThuThapRepository>(() =>
      NguonThuThapRepositoryImpl(
          nguonThuThapApiService: locator<NguonThuThapApiService>()));

  //DanToc
  locator.registerLazySingleton<DanTocApiService>(
      () => DanTocApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<DanTocRepository>(() =>
      DanTocRepositoryImpl(danTocApiService: locator<DanTocApiService>()));

  //TonGiao

  //TrinhDoVanHoa
  locator.registerLazySingleton<TrinhDoVanHoaApiService>(
      () => TrinhDoVanHoaApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TrinhDoVanHoaRepository>(() =>
      TrinhDoVanHoaRepositoryImpl(
          trinhDoVanHoaApiService: locator<TrinhDoVanHoaApiService>()));

  //TrinhDoHocVan
  locator.registerLazySingleton<TrinhDoHocVanApiService>(
      () => TrinhDoHocVanApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TrinhDoHocVanRepository>(() =>
      TrinhDoHocVanRepositoryImpl(
          trinhDoHocVanApiService: locator<TrinhDoHocVanApiService>()));

  //TrinhDoTinHoc
  locator.registerLazySingleton<TrinhDoTinHocApiService>(
      () => TrinhDoTinHocApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TrinhDoTinHocRepository>(() =>
      TrinhDoTinHocRepositoryImpl(
          trinhDoTinHocApiService: locator<TrinhDoTinHocApiService>()));

  //TrinhDoNgoaiNgu
  locator.registerLazySingleton<TrinhDoNgoaiNguApiService>(
      () => TrinhDoNgoaiNguApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TrinhDoNgoaiNguRepository>(() =>
      TrinhDoNgoaiNguRepositoryImpl(
          trinhDoNgoaiNguApiService: locator<TrinhDoNgoaiNguApiService>()));

  //HinhThucDaoTao
  locator.registerLazySingleton<HinhThucDaoTaoApiService>(
      () => HinhThucDaoTaoApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HinhThucDaoTaoRepository>(() =>
      HinhThucDaoTaoRepositoryImpl(
          hinhThucDaoTaoApiService: locator<HinhThucDaoTaoApiService>()));

  //HinhThucLoaiHinh
  locator.registerLazySingleton<HinhThucLoaiHinhApiService>(
      () => HinhThucLoaiHinhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HinhThucLoaiHinhRepository>(() =>
      HinhThucLoaiHinhRepositoryImpl(
          hinhThucLoaiHinhApiService: locator<HinhThucLoaiHinhApiService>()));

  //HinhThucDiaDiem
  locator.registerLazySingleton<HinhThucDiaDiemApiService>(
      () => HinhThucDiaDiemApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HinhThucDiaDiemRepository>(() =>
      HinhThucDiaDiemRepositoryImpl(
          hinhThucDiaDiemApiService: locator<HinhThucDiaDiemApiService>()));

  //TinhTrangViecLam
  locator.registerLazySingleton<TinhTrangVLApiService>(
      () => TinhTrangVLApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TinhTrangVLRepository>(() =>
      TinhTrangVLRepositoryImpl(
          tinhTrangVLApiService: locator<TinhTrangVLApiService>()));

  //LoaiViecLam
  locator.registerLazySingleton<LoaiVLApiService>(
      () => LoaiVLApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<LoaiVLRepository>(() =>
      LoaiVLRepositoryImpl(loaiVLApiService: locator<LoaiVLApiService>()));

  //TinhTrangTanTat
  locator.registerLazySingleton<TTTanTatApiService>(
      () => TTTanTatApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TTTanTatRepository>(() =>
      TTTanTatRepositoryImpl(
          ttTanTatApiService: locator<TTTanTatApiService>()));
  //TinhThanh
  locator.registerLazySingleton<TinhThanhApiService>(
      () => TinhThanhApiService(locator<ApiClient>().dio));
  locator.registerFactory(() =>
      TinhThanhCubit(tinhThanhApiService: locator<TinhThanhApiService>()));

  //NganhNgheBacHoc
  locator.registerLazySingleton<NganhNgheBacHocApiService>(
      () => NganhNgheBacHocApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NganhNgheBacHocRepository>(() =>
      NganhNgheBacHocRepositoryImpl(
          nganhNgheBacHocApiService: locator<NganhNgheBacHocApiService>()));
  //NganhNgheTD
  locator.registerLazySingleton<NganhNgheTDApiService>(
      () => NganhNgheTDApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NganhNgheTDRepository>(() =>
      NganhNgheTDRepositoryImpl(
          nganhNgheTDApiService: locator<NganhNgheTDApiService>()));

  //MucLuongMM
  locator.registerLazySingleton<MucLuongApiService>(
      () => MucLuongApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<MucLuongRepository>(() =>
      MucLuongRepositoryImpl(
          mucLuongApiService: locator<MucLuongApiService>()));
  //HinhThucDoanhNghiep
  locator.registerLazySingleton<HinhThucDoanhNghiepApiService>(
      () => HinhThucDoanhNghiepApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HinhThucDoanhNghiepRepository>(() =>
      HinhThucDoanhNghiepRepositoryImpl(
          hinhThucDoanhNghiepApiService:
              locator<HinhThucDoanhNghiepApiService>()));
}
