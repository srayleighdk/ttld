import 'package:get_it/get_it.dart';
import 'package:ttld/blocs/huyen/huyen_bloc.dart';
import 'package:ttld/blocs/quocgia/quocgia_bloc.dart';
import 'package:ttld/blocs/tinh/tinh_bloc.dart';
import 'package:ttld/blocs/xa/xa_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/services/huyen_api_service.dart';
import 'package:ttld/core/services/quocgia_api_service.dart';
import 'package:ttld/core/services/tinh_api_service.dart';
import 'package:ttld/core/services/tinh_moi_api_service.dart';
import 'package:ttld/core/services/xa_api_service.dart';
import 'package:ttld/core/services/xa_moi_api_service.dart';
import 'package:ttld/repositories/huyen/huyen_repository.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';
import 'package:ttld/repositories/tinh/tinh_repository.dart';
import 'package:ttld/repositories/xa/xa_repository.dart';

final locator = GetIt.instance;

Future<void> setupLocationLocator() async {
  // Register Tinh, Huyen, Xa dependencies:
  locator.registerLazySingleton<TinhApiService>(
      () => TinhApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<TinhRepository>(
      () => TinhRepositoryImpl(tinhApiService: locator<TinhApiService>()));
  locator.registerLazySingleton(
      () => TinhBloc(tinhRepository: locator<TinhRepository>()));

  locator.registerLazySingleton<HuyenApiService>(
      () => HuyenApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<HuyenRepository>(
      () => HuyenRepositoryImpl(huyenApiService: locator<HuyenApiService>()));
  locator.registerLazySingleton(
      () => HuyenBloc(huyenRepository: locator<HuyenRepository>()));

  locator.registerLazySingleton<XaApiService>(
      () => XaApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<XaRepository>(
      () => XaRepositoryImpl(xaApiService: locator<XaApiService>()));
  locator.registerLazySingleton(
      () => XaBloc(xaRepository: locator<XaRepository>()));

  // TinhMoi and XaMoi API Services
  locator.registerLazySingleton<TinhMoiApiService>(
      () => TinhMoiApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<XaMoiApiService>(
      () => XaMoiApiService(locator<ApiClient>().dio));

  // QuocGia
  locator.registerLazySingleton<QuocGiaApiService>(
      () => QuocGiaApiService(locator<ApiClient>().dio));
  locator.registerLazySingleton<QuocGiaRepository>(() =>
      QuocGiaRepositoryImpl(quocGiaApiService: locator<QuocGiaApiService>()));
  locator.registerLazySingleton(
      () => QuocGiaBloc(quocGiaRepository: locator<QuocGiaRepository>()));
}
