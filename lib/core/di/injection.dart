import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/bloc/biendong/biendong_bloc.dart';
import 'package:ttld/bloc/chuc_danh/chuc_danh_bloc.dart';
import 'package:ttld/bloc/hinh_thuc_tuyen_dung/hinh_thuc_tuyen_dung_bloc.dart';
import 'package:ttld/bloc/kinh_nghiem_lam_viec/kinh_nghiem_lam_viec_bloc.dart';
import 'package:ttld/bloc/loai_hinh/loai_hinh_bloc.dart';
import 'package:ttld/bloc/loai_hop_dong_lao_dong/loai_hop_dong_lao_dong_bloc.dart';
import 'package:ttld/bloc/muc_dich_lam_viec/muc_dich_lam_viec_bloc.dart';
import 'package:ttld/bloc/nganh_nghe/nganh_nghe_chuyennganh_bloc.dart';
import 'package:ttld/bloc/ngoai_ngu/ngoai_ngu_cubit.dart';
import 'package:ttld/bloc/nganh_nghe/nganh_nghe_capdo_bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_bloc.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/bloc/tblViecLamUngVien/vieclam_ungvien_bloc.dart';
import 'package:ttld/bloc/tuyendung/tuyendung_bloc.dart';
import 'package:ttld/bloc/user/user_bloc.dart';
import 'package:ttld/blocs/user_role_bloc/user_role_bloc.dart';
import 'package:ttld/core/services/dan_toc_api_service.dart';
import 'package:ttld/core/services/hinh_thuc_dao_tao_api_service.dart';
import 'package:ttld/core/services/hinh_thuc_dia_diem_api_service.dart';
import 'package:ttld/core/services/hinh_thuc_loai_hinh_api_service.dart';
import 'package:ttld/core/services/hinh_thuc_tuyen_dung_api_service.dart';
import 'package:ttld/core/services/loai_hinh_api_service.dart';
import 'package:ttld/core/services/loai_hop_dong_lao_dong_api_service.dart';
import 'package:ttld/core/services/loai_vl_api_service.dart';
import 'package:ttld/core/services/muc_dich_lam_viec_api_service.dart';
import 'package:ttld/core/services/muc_luong_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_bachoc_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_capdo_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_chuyennganh_api_service.dart';
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
import 'package:ttld/core/services/tinh_trang_hd_api_service.dart';
import 'package:ttld/core/services/tinh_trangvl_api_service.dart';
import 'package:ttld/core/services/trinh_do_hoc_van_api_service.dart';
import 'package:ttld/core/services/trinh_do_ngoai_ngu_api_service.dart';
import 'package:ttld/core/services/kinh_nghiem_lam_viec_api_service.dart';
import 'package:ttld/core/services/trinh_do_tin_hoc_api_service.dart';
import 'package:ttld/core/services/trinh_do_van_hoa_api_service.dart';
import 'package:ttld/core/services/tt_tantat_api_service.dart';
import 'package:ttld/core/services/vieclam_ungvien_api_service.dart';
import 'package:ttld/core/services/xa_api_service.dart';
import 'package:ttld/cubit/tinhtrang_hd_cubit.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/login_bloc.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/core/services/tinh_thanh_api_service.dart';
import 'package:ttld/bloc/tinh_thanh/tinh_thanh_cubit.dart';
import 'package:ttld/features/ds-ld/bloc/ld_bloc.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository_impl.dart';
import 'package:ttld/features/user_group/bloc/group_bloc.dart';
import 'package:ttld/features/user_group/repository/group_repository.dart';
import 'package:ttld/pages/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:ttld/pages/hosoungvien/bloc/hosoungvien_bloc.dart';
import 'package:ttld/pages/signup/bloc/signup_bloc.dart';
import 'package:ttld/repositories/biendong_repository.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/dan_toc/dan_toc_repository.dart';
import 'package:ttld/repositories/do_tuoi/do_tuoi_repository.dart';
import 'package:ttld/repositories/hinh_thuc_dao_tao/hinh_thuc_dao_tao_repository.dart';
import 'package:ttld/repositories/hinh_thuc_dia_diem/hinh_thuc_dia_diem_repository.dart';
import 'package:ttld/repositories/hinh_thuc_loai_hinh/hinh_thuc_loai_hinh_repository.dart';
import 'package:ttld/repositories/hinh_thuc_tuyen_dung_repository.dart';
import 'package:ttld/repositories/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_repository.dart';
import 'package:ttld/repositories/huyen/huyen_repository.dart';
import 'package:ttld/repositories/kinh_nghiem_lam_viec_repository.dart';
import 'package:ttld/repositories/loai_hinh/loai_hinh_repository.dart';
import 'package:ttld/repositories/loai_hop_dong_lao_dong_repository.dart';
import 'package:ttld/repositories/loai_vl/loai_vl_repository.dart';
import 'package:ttld/repositories/muc_dich_lam_viec_repository.dart';
import 'package:ttld/repositories/muc_luong/muc_luong_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_bachoc_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_capdo_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_chuyennganh_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_td_repository.dart';
import 'package:ttld/repositories/ngoai_ngu/ngoai_ngu_repository.dart';
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
import 'package:ttld/repositories/tinh_trang_hd_repository.dart';
import 'package:ttld/repositories/tinh_trangvl/tinh_trangvl_repository.dart';
import 'package:ttld/repositories/trinh_do_hoc_van/trinh_do_hoc_van_repository.dart';
import 'package:ttld/repositories/trinh_do_ngoai_ngu/trinh_do_ngoai_ngu_repository.dart';
import 'package:ttld/repositories/trinh_do_tin_hoc/trinh_do_tin_hoc_repository.dart';
import 'package:ttld/repositories/trinh_do_van_hoa/trinh_do_van_hoa_repository.dart';
import 'package:ttld/repositories/tt_tantat/tt_tantat_repository.dart';
import 'package:ttld/repositories/tuyendung_repository.dart';
import 'package:ttld/repositories/user/user_repository.dart';
import 'package:ttld/repositories/user_role_repository.dart';
import 'package:ttld/repositories/xa/xa_repository.dart';
import 'package:ttld/bloc/kcn/kcn_cubit.dart';
import 'package:ttld/services/biendong_service.dart';
import 'package:ttld/services/tuyendung_service.dart';
import 'package:ttld/services/user_api_service.dart';
import 'package:ttld/services/user_role_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
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

// NgoaiNgu
  locator.registerLazySingleton<NgoaiNguRepository>(
      () => NgoaiNguRepositoryImpl(locator<ApiClient>()));

  // DoTuoi
  locator.registerLazySingleton<DoTuoiRepository>(
      () => DoTuoiRepositoryImpl(locator<ApiClient>()));

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

  locator.registerLazySingleton(
      () => TinhBloc(tinhRepository: locator<TinhRepository>()));

  locator.registerLazySingleton(
      () => HuyenBloc(huyenRepository: locator<HuyenRepository>()));
  locator.registerLazySingleton(
      () => XaBloc(xaRepository: locator<XaRepository>()));

  //KCN
  locator.registerLazySingleton<DanhMucKcnApiService>(
      () => DanhMucKcnApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton(
      () => KcnCubit(DanhMucKcnApiService(locator<ApiClient>().dio)));

  locator.registerLazySingleton<QuocGiaApiService>(
      () => QuocGiaApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<QuocGiaRepository>(
    () =>
        QuocGiaRepositoryImpl(quocGiaApiService: locator<QuocGiaApiService>()),
  );

  locator.registerLazySingleton(
      () => QuocGiaBloc(quocGiaRepository: locator<QuocGiaRepository>()));

  //HinhThucDoanhNghiep

  //LoaiHinh
  locator.registerLazySingleton<LoaiHinhApiService>(
      () => LoaiHinhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<LoaiHinhRepository>(() =>
      LoaiHinhRepositoryImpl(
          loaiHinhApiService: locator<LoaiHinhApiService>()));
  locator.registerLazySingleton(
      () => LoaiHinhBloc(loaiHinhRepository: locator<LoaiHinhRepository>()));

  //NganhNghe
  locator.registerLazySingleton<NganhNgheApiService>(
      () => NganhNgheApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NganhNgheRepository>(() =>
      NganhNgheRepositoryImpl(
          nganhNgheApiService: locator<NganhNgheApiService>()));
  locator.registerLazySingleton(
      () => NganhNgheBloc(nganhNgheRepository: locator<NganhNgheRepository>()));

  // Chức Danh

  locator.registerLazySingleton<ChucDanhApiService>(
      () => ChucDanhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ChucDanhRepository>(() =>
      ChucDanhRepositoryImpl(
          chucDanhApiService: locator<ChucDanhApiService>()));
  locator.registerLazySingleton(
      () => ChucDanhBloc(chucDanhRepository: locator<ChucDanhRepository>()));

  //ThoiGianHoatDong
  locator.registerLazySingleton<ThoiGianHoatDongApiService>(
      () => ThoiGianHoatDongApiService(locator<ApiClient>().dio));

  // KinhNghiemLamViec
  locator.registerLazySingleton<KinhNghiemLamViecApiService>(
      () => KinhNghiemLamViecApiService(locator<ApiClient>()));
  locator.registerLazySingleton<KinhNghiemLamViecRepository>(() =>
      KinhNghiemLamViecRepositoryImpl(locator<KinhNghiemLamViecApiService>()));

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
  locator.registerLazySingleton(() =>
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

// Add missing ones from getBlocProviders
  locator.registerLazySingleton(() => AuthBloc());
  locator.registerLazySingleton(
      () => SignupBloc(authRepository: locator<AuthRepository>()));
  locator.registerLazySingleton(() => LoginBloc(
        authRepository: locator<AuthRepository>(),
        authBloc: locator<
            AuthBloc>(), // Note: This assumes AuthBloc is registered first
      ));
  locator.registerLazySingleton(() => LdBloc(locator<LdRepository>()));
  locator.registerLazySingleton(
      () => GroupBloc(groupRepository: locator<GroupRepository>()));
  locator.registerLazySingleton(
      () => ForgotPasswordBloc(locator<ApiClient>().dio));
  locator.registerLazySingleton(() =>
      HoSoUngVienBloc(hoSoUngVienApiService: locator<HoSoUngVienApiService>()));
  locator.registerLazySingleton(() => ViecLamUngVienBloc(
      viecLamUngVienRepository: locator<ViecLamUngVienRepository>()));

  locator.registerLazySingleton(() => NTVBloc(locator<NTVRepository>()));

  locator.registerLazySingleton(() => NTDBloc(locator<NTDRepository>()));

  //NganhNgheCapDo
  locator.registerLazySingleton<NganhNgheCapDoApiService>(
      () => NganhNgheCapDoApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NganhNgheCapDoRepository>(() =>
      NganhNgheCapDoRepositoryImpl(
          nganhNgheCapDoApiService: locator<NganhNgheCapDoApiService>()));
  locator.registerLazySingleton(() => NganhNgheCapDoBloc(
      nganhNgheCapDoRepository: locator<NganhNgheCapDoRepository>()));
  locator.registerFactory(() => NgoaiNguCubit(locator<NgoaiNguRepository>()));
  locator.registerFactory(
      () => KinhNghiemLamViecBloc(locator<KinhNghiemLamViecRepository>()));

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

  // Muc Dich Lam Viec
  locator.registerLazySingleton<MucDichLamViecApiService>(
      () => MucDichLamViecApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<MucDichLamViecRepository>(
      () => MucDichLamViecRepositoryImpl(locator<MucDichLamViecApiService>()));
  locator.registerLazySingleton(
      () => MucDichLamViecBloc(locator<MucDichLamViecRepository>()));

  // Hinh Thuc Tuyen Dung
  locator.registerLazySingleton<HinhThucTuyenDungApiService>(
      () => HinhThucTuyenDungApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HinhThucTuyenDungRepository>(() =>
      HinhThucTuyenDungRepositoryImpl(locator<HinhThucTuyenDungApiService>()));
  locator.registerLazySingleton(
      () => HinhThucTuyenDungBloc(locator<HinhThucTuyenDungRepository>()));

  // Tuyen Dung
  locator.registerLazySingleton<TuyenDungApiService>(
      () => TuyenDungApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TuyenDungRepository>(
      () => TuyenDungRepository(locator<TuyenDungApiService>()));
  locator.registerLazySingleton(
      () => TuyenDungBloc(locator<TuyenDungRepository>()));

  //Bien Dong
  locator.registerLazySingleton<BienDongService>(
      () => BienDongService(locator<ApiClient>().dio));
  locator.registerLazySingleton<BienDongRepository>(
      () => BienDongRepository(locator<BienDongService>()));
  locator
      .registerLazySingleton(() => BienDongBloc(locator<BienDongRepository>()));

  //Loai Hop Dong Lao Dong
  locator.registerLazySingleton<LoaiHopDongLaoDongApiService>(
      () => LoaiHopDongLaoDongApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<LoaiHopDongLaoDongRepository>(() =>
      LoaiHopDongLaoDongRepositoryImpl(
          locator<LoaiHopDongLaoDongApiService>()));
  locator.registerLazySingleton(
      () => LoaiHopDongLaoDongBloc(locator<LoaiHopDongLaoDongRepository>()));

  // Tinh Trang Hop Dong Cubit
  locator.registerLazySingleton<TinhTrangHdApiService>(
      () => TinhTrangHdApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TinhTrangHdRepository>(
      () => TinhTrangHdRepositoryImpl(locator<TinhTrangHdApiService>()));
  locator.registerLazySingleton(
      () => TinhTrangHdCubit(locator<TinhTrangHdRepository>()));

  // User
  locator.registerLazySingleton<UserApiService>(
      () => UserApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<UserRepository>(
      () => UserRepository(userApiService: locator<UserApiService>()));
  locator.registerLazySingleton(
      () => UserBloc(userRepository: locator<UserRepository>()));

  // Permission Role
  locator.registerLazySingleton<UserRoleService>(
      () => UserRoleService(locator<ApiClient>().dio));
  locator.registerLazySingleton<UserRoleRepository>(
      () => UserRoleRepository(locator<UserRoleService>()));
  locator
      .registerLazySingleton(() => UserRoleBloc(locator<UserRoleRepository>()));
}
