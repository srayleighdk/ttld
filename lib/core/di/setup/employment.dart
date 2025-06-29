import 'package:get_it/get_it.dart';
import 'package:ttld/blocs/biendong/biendong_bloc.dart';
import 'package:ttld/blocs/hinh_thuc_lam_viec/hinh_thuc_lam_viec_bloc.dart';
import 'package:ttld/blocs/hinh_thuc_tuyen_dung/hinh_thuc_tuyen_dung_bloc.dart';
import 'package:ttld/blocs/loai_hop_dong_lao_dong/loai_hop_dong_lao_dong_bloc.dart';
import 'package:ttld/blocs/muc_dich_lam_viec/muc_dich_lam_viec_bloc.dart';
import 'package:ttld/blocs/muc_luong/muc_luong_bloc.dart';
import 'package:ttld/blocs/tuyendung/tuyendung_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/repositories/muc_luong/muc_luong_repository.dart';
import 'package:ttld/core/services/muc_luong_api_service.dart';
import 'package:ttld/core/services/hinh_thuc_lam_viec_api_service.dart';
import 'package:ttld/core/services/hinh_thuc_tuyen_dung_api_service.dart';
import 'package:ttld/core/services/loai_hop_dong_lao_dong_api_service.dart';
import 'package:ttld/core/services/muc_dich_lam_viec_api_service.dart';
import 'package:ttld/repositories/biendong_repository.dart';
import 'package:ttld/repositories/hinh_thuc_lam_viec_repository.dart';
import 'package:ttld/repositories/hinh_thuc_tuyen_dung_repository.dart';
import 'package:ttld/repositories/loai_hop_dong_lao_dong_repository.dart';
import 'package:ttld/repositories/muc_dich_lam_viec_repository.dart';
import 'package:ttld/repositories/tuyendung_repository.dart';
import 'package:ttld/services/biendong_service.dart';
import 'package:ttld/services/tuyendung_service.dart';

final locator = GetIt.instance;

Future<void> setupEmploymentLocator() async {
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

  // Bien Dong
  locator.registerLazySingleton<BienDongService>(
      () => BienDongService(locator<ApiClient>().dio));
  locator.registerLazySingleton<BienDongRepository>(
      () => BienDongRepository(locator<BienDongService>()));
  locator
      .registerLazySingleton(() => BienDongBloc(locator<BienDongRepository>()));

  // Loai Hop Dong Lao Dong
  locator.registerLazySingleton<LoaiHopDongLaoDongApiService>(
      () => LoaiHopDongLaoDongApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<LoaiHopDongLaoDongRepository>(() =>
      LoaiHopDongLaoDongRepositoryImpl(
          locator<LoaiHopDongLaoDongApiService>()));
  locator.registerLazySingleton(
      () => LoaiHopDongLaoDongBloc(locator<LoaiHopDongLaoDongRepository>()));

  // Muc Dich Lam Viec
  locator.registerLazySingleton<MucDichLamViecApiService>(
      () => MucDichLamViecApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<MucDichLamViecRepository>(
      () => MucDichLamViecRepositoryImpl(locator<MucDichLamViecApiService>()));
  locator.registerLazySingleton(
      () => MucDichLamViecBloc(locator<MucDichLamViecRepository>()));

  // Muc Luong
  locator.registerLazySingleton<MucLuongApiService>(
      () => MucLuongApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<MucLuongRepository>(() =>
      MucLuongRepositoryImpl(
          mucLuongApiService: locator<MucLuongApiService>()));
  locator.registerLazySingleton(
      () => MucLuongBloc(mucLuongRepository: locator<MucLuongRepository>()));

  // Hinh Thuc Lam Viec
  locator.registerLazySingleton<HinhThucLamViecApiService>(
      () => HinhThucLamViecApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HinhThucLamViecRepository>(
      () => HinhThucLamViecRepository(locator<HinhThucLamViecApiService>()));
  locator.registerLazySingleton(
      () => HinhThucLamViecBloc(locator<HinhThucLamViecRepository>()));

  
}
