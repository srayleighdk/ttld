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
import 'package:ttld/blocs/tinh_trangvl/tinh_trangvl_bloc.dart';
import 'package:ttld/repositories/tinh_trangvl/tinh_trangvl_repository.dart';
import 'package:ttld/core/services/tinh_trangvl_api_service.dart';
import 'package:ttld/core/services/ve_tinh_api_service.dart';
import 'package:ttld/core/services/status_vieclam_api_service.dart';
import 'package:ttld/models/ve_tinh_model.dart';
import 'package:ttld/repositories/ve_tinh/ve_tinh_repository.dart';
import 'package:ttld/models/status_vieclam_model.dart';
import 'package:ttld/repositories/status_vieclam/status_vieclam_repository.dart';
import 'package:ttld/core/services/bac_mon_dao_tao_api_service.dart';
import 'package:ttld/models/bac_mon_dao_tao_model.dart';
import 'package:ttld/repositories/bac_mon_dao_tao/bac_mon_dao_tao_repository.dart';
import 'package:ttld/core/services/chuyen_nganh_dao_tao_api_service.dart';
import 'package:ttld/models/chuyen_nganh_dao_tao_model.dart';
import 'package:ttld/repositories/chuyen_nganh_dao_tao/chuyen_nganh_dao_tao_repository.dart';
import 'package:ttld/core/services/status_dg_api_service.dart';
import 'package:ttld/models/status_dg_model.dart';
import 'package:ttld/core/services/ca_lam_viec_api_service.dart';
import 'package:ttld/models/ca_lam_viec_model.dart';
import 'package:ttld/repositories/ca_lam_viec/ca_lam_viec_repository.dart';
import 'package:ttld/repositories/status_dg/status_dg_repository.dart';
import 'package:ttld/core/services/nguyen_nhan_that_nghiep_api_service.dart';
import 'package:ttld/models/nguyen_nhan_that_nghiep_model.dart';
import 'package:ttld/repositories/nguyen_nhan_that_nghiep/nguyen_nhan_that_nghiep_repository.dart';
import 'package:ttld/core/services/bhtn_khoadaotao_api_service.dart';
import 'package:ttld/core/services/dky_hoc_nghe_api_service.dart';
import 'package:ttld/core/services/hoso_xkld_api_service.dart';
import 'package:ttld/models/bhtn_khoadaotao/bhtn_khoadaotao_model.dart';
import 'package:ttld/repositories/bhtn_khoadaotao_repository.dart';

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

  // Tinh Trang Viec Lam
  locator.registerLazySingleton<TinhTrangVLApiService>(
      () => TinhTrangVLApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TinhTrangVLRepository>(() =>
      TinhTrangVLRepositoryImpl(
          tinhTrangVLApiService: locator<TinhTrangVLApiService>()));
  locator.registerLazySingleton<TinhTrangVLBloc>(() =>
      TinhTrangVLBloc(tinhTrangVLRepository: locator<TinhTrangVLRepository>()));

  // VeTinh
  locator.registerLazySingleton<VeTinhApiService>(
      () => VeTinhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<VeTinhRepository>(
      () => VeTinhRepositoryImpl(apiService: locator<VeTinhApiService>()));

  // Status Viec Lam (TblDmStatusViecLam) - using /common/status-vl
  locator.registerLazySingleton<StatusViecLamApiService>(
      () => StatusViecLamApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<StatusViecLamRepository>(() =>
      StatusViecLamRepositoryImpl(
          apiService: locator<StatusViecLamApiService>()));

  // Bac Mon Dao Tao (TblDmBacMonDaoTao) - using /common/bac-hoc
  locator.registerLazySingleton<BacMonDaoTaoApiService>(
      () => BacMonDaoTaoApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<BacMonDaoTaoRepository>(() =>
      BacMonDaoTaoRepositoryImpl(
          apiService: locator<BacMonDaoTaoApiService>()));

  // Chuyen Nganh Dao Tao (TblDmBacDaoTaoC3) - using /common/chuyen-nganh
  locator.registerLazySingleton<ChuyenNganhDaoTaoApiService>(
      () => ChuyenNganhDaoTaoApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ChuyenNganhDaoTaoRepository>(() =>
      ChuyenNganhDaoTaoRepositoryImpl(
          apiService: locator<ChuyenNganhDaoTaoApiService>()));

  // Status DG (TblDmStatusDG) - using /common/status-dg
  locator.registerLazySingleton<StatusDgApiService>(
      () => StatusDgApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<StatusDgRepository>(
      () => StatusDgRepositoryImpl(apiService: locator<StatusDgApiService>()));

  // Ca Lam Viec (TblDmCaLamViec) - using /bo-sung/ca-lam
  locator.registerLazySingleton<CaLamViecApiService>(
      () => CaLamViecApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<CaLamViecRepository>(() =>
      CaLamViecRepositoryImpl(
          caLamViecApiService: locator<CaLamViecApiService>()));

  // Nguyen Nhan That Nghiep (TblDmNguyenNhanThatNghiep) - using /common/nguyen-nhan-tn
  locator.registerLazySingleton<NguyenNhanThatNghiepApiService>(
      () => NguyenNhanThatNghiepApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NguyenNhanThatNghiepRepository>(() =>
      NguyenNhanThatNghiepRepositoryImpl(
          apiService: locator<NguyenNhanThatNghiepApiService>()));

  // BHTN Khoa Dao Tao
  locator.registerLazySingleton<BhtnKhoadaotaoApiService>(
      () => BhtnKhoadaotaoApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<BhtnKhoadaotaoRepository>(() =>
      BhtnKhoadaotaoRepositoryImpl(
          bhtnKhoadaotaoApiService: locator<BhtnKhoadaotaoApiService>()));

  // Dang Ky Hoc Nghe
  locator.registerLazySingleton<DkyHocNgheApiService>(
      () => DkyHocNgheApiService(locator<ApiClient>().dio));

  // Hoso XKLD
  locator.registerLazySingleton<HosoXkldApiService>(
      () => HosoXkldApiService(locator<ApiClient>().dio));

  // Don't register empty list here - let misc_data_init.dart handle it after API call
}
