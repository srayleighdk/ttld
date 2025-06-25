import 'package:get_it/get_it.dart';
import 'package:ttld/blocs/nguon_thuthap/nguon_thuthap_bloc.dart';
import 'package:ttld/blocs/tblDmDoiTuongChinhSach/doituong_bloc.dart';
import 'package:ttld/core/api_client.dart';
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

final locator = GetIt.instance;

Future<void> setupUserLocator() async {
  // User
  locator.registerLazySingleton<UserApiService>(
      () => UserApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<UserRepository>(
      () => UserRepository(userApiService: locator<UserApiService>()));
  locator.registerLazySingleton(
      () => UserBloc(userRepository: locator<UserRepository>()));

  // Dan Toc
  locator.registerLazySingleton<DanTocApiService>(
      () => DanTocApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<DanTocRepository>(() =>
      DanTocRepositoryImpl(danTocApiService: locator<DanTocApiService>()));
  locator.registerLazySingleton(
      () => DanTocBloc(danTocRepository: locator<DanTocRepository>()));

  // Permission Role
  locator.registerLazySingleton<UserRoleService>(
      () => UserRoleService(locator<ApiClient>().dio));
  locator.registerLazySingleton<UserRoleRepository>(
      () => UserRoleRepository(locator<UserRoleService>()));
  locator
      .registerLazySingleton(() => UserRoleBloc(locator<UserRoleRepository>()));

  // Doi Tuong
  locator.registerLazySingleton<DoiTuongApiService>(
      () => DoiTuongApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<DoiTuongRepository>(
      () => DoiTuongRepositoryImpl(locator<DoiTuongApiService>()));
  locator
      .registerLazySingleton(() => DoiTuongBloc(locator<DoiTuongRepository>()));

  // Nguon Thu Thap
  locator.registerLazySingleton<NguonThuThapApiService>(
      () => NguonThuThapApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<NguonThuThapRepository>(
      () => NguonThuThapRepositoryImpl(locator<NguonThuThapApiService>()));
  locator.registerLazySingleton(
      () => NguonThuThapBloc(locator<NguonThuThapRepository>()));
}
