import 'package:get_it/get_it.dart';
import 'package:ttld/blocs/dn_dk_pgd/dn_dk_pgd_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/services/dn_dk_pgd_service.dart';
import 'package:ttld/repositories/dn_dk_pgd_repository.dart';

Future<void> setupDnDkPgdLocator(GetIt locator) async {
  // Register service
  locator.registerLazySingleton<DnDkPgdService>(
    () => DnDkPgdService(locator<ApiClient>().dio),
  );

  // Register repository
  locator.registerLazySingleton<DnDkPgdRepository>(
    () => DnDkPgdRepository(locator<DnDkPgdService>()),
  );

  // Register bloc
  locator.registerFactory<DnDkPgdBloc>(
    () => DnDkPgdBloc(locator<DnDkPgdRepository>()),
  );
}
