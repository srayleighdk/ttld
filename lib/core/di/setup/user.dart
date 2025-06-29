import 'package:ttld/blocs/nguon_thuthap/nguon_thuthap_bloc.dart';
import 'package:ttld/blocs/tblDmDoiTuongChinhSach/doituong_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/blocs/user_role_bloc/user_role_bloc.dart';
import 'package:ttld/blocs/user/user_bloc.dart';
import 'package:ttld/core/services/doituongchinhsach_api_service.dart';
import 'package:ttld/core/services/nguon_thuthap_api_service.dart';
import 'package:ttld/repositories/nguon_thuthap/nguon_thuthap_repository.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository_impl.dart'
    show DoiTuongRepositoryImpl;
import 'package:ttld/repositories/user/user_repository.dart';
import 'package:ttld/repositories/user_role_repository.dart';
import 'package:ttld/services/user_api_service.dart';
import 'package:ttld/services/user_role_service.dart';
import 'package:ttld/blocs/dan_toc/dan_toc_bloc.dart';
import 'package:ttld/repositories/dan_toc/dan_toc_repository.dart';
import 'package:ttld/core/services/dan_toc_api_service.dart';
import 'package:ttld/blocs/ton_giao/ton_giao_bloc.dart';
import 'package:ttld/repositories/ton_giao/ton_giao_repository.dart';
import 'package:ttld/core/services/ton_giao_api_service.dart';
import 'package:ttld/blocs/do_tuoi/do_tuoi_cubit.dart';
import 'package:ttld/repositories/do_tuoi/do_tuoi_repository.dart';
import 'package:ttld/blocs/don_vi/don_vi_bloc.dart';
import 'package:ttld/repositories/don_vi/don_vi_repository.dart';
import 'package:ttld/core/services/don_vi_api_service.dart';
import 'package:ttld/blocs/thoigianlamviec/thoigianlamviec_bloc.dart';
import 'package:ttld/core/services/thoigianlamviec_api_service.dart';
import 'package:ttld/repositories/thoigianlamviec/thoigianlamviec_repository.dart';

// Using locator from injection.dart

Future<void> setupUserLocator() async {
  // User
  locator.registerLazySingleton<UserApiService>(
      () => UserApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<UserRepository>(
      () => UserRepository(userApiService: locator<UserApiService>()));
  locator.registerLazySingleton<UserBloc>(
      () => UserBloc(userRepository: locator<UserRepository>()));

  // Dan Toc
  locator.registerLazySingleton<DanTocApiService>(
      () => DanTocApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<DanTocRepository>(() =>
      DanTocRepositoryImpl(danTocApiService: locator<DanTocApiService>()));
  locator.registerLazySingleton<DanTocBloc>(
      () => DanTocBloc(danTocRepository: locator<DanTocRepository>()));

  // Permission Role
  locator.registerLazySingleton<UserRoleService>(
      () => UserRoleService(locator<ApiClient>().dio));
  locator.registerLazySingleton<UserRoleRepository>(
      () => UserRoleRepository(locator<UserRoleService>()));
  locator.registerLazySingleton<UserRoleBloc>(
      () => UserRoleBloc(locator<UserRoleRepository>()));

  // Doi Tuong
  locator.registerLazySingleton<DoiTuongApiService>(
      () => DoiTuongApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<DoiTuongRepository>(
      () => DoiTuongRepositoryImpl(locator<DoiTuongApiService>()));
  locator.registerLazySingleton<DoiTuongBloc>(
      () => DoiTuongBloc(locator<DoiTuongRepository>()));

  // Nguon Thu Thap
  locator.registerLazySingleton<NguonThuThapApiService>(
      () => NguonThuThapApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NguonThuThapRepository>(
      () => NguonThuThapRepositoryImpl(locator<NguonThuThapApiService>()));
  locator.registerLazySingleton<NguonThuThapBloc>(
      () => NguonThuThapBloc(locator<NguonThuThapRepository>()));

  // Ton Giao
  locator.registerLazySingleton<TonGiaoApiService>(
      () => TonGiaoApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TonGiaoRepository>(() =>
      TonGiaoRepositoryImpl(tonGiaoApiService: locator<TonGiaoApiService>()));
  locator.registerLazySingleton<TonGiaoBloc>(
      () => TonGiaoBloc(tonGiaoRepository: locator<TonGiaoRepository>()));

  // Do Tuoi
  locator.registerLazySingleton<DoTuoiRepository>(
      () => DoTuoiRepositoryImpl(locator<ApiClient>()));
  locator.registerLazySingleton<DoTuoiCubit>(
      () => DoTuoiCubit(locator<DoTuoiRepository>()));

  // Don Vi
  locator.registerLazySingleton<DonViApiService>(
      () => DonViApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<DonViRepository>(
      () => DonViRepositoryImpl(donViApiService: locator<DonViApiService>()));
  locator.registerLazySingleton<DonViBloc>(
      () => DonViBloc(donViRepository: locator<DonViRepository>()));

  // Thoi Gian Lam Viec
  locator.registerLazySingleton<ThoiGianLamViecApiService>(
      () => ThoiGianLamViecApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<ThoiGianLamViecRepository>(() =>
      ThoiGianLamViecRepositoryImpl(
          thoiGianLamViecApiService: locator<ThoiGianLamViecApiService>()));
  locator.registerLazySingleton(() => ThoiGianLamViecBloc(
      thoiGianLamViecRepository: locator<ThoiGianLamViecRepository>()));
}
