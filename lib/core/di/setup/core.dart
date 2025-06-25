import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/core/api_client.dart';

final locator = GetIt.instance;

Future<void> setupCoreLocator() async {
  // Register SharedPreferences as a singleton only if not already registered:
  if (!locator.isRegistered<SharedPreferences>()) {
    final prefs = await SharedPreferences.getInstance();
    locator.registerLazySingleton<SharedPreferences>(() => prefs);
  }

  // Register FlutterSecureStorage as a singleton only if not already registered:
  if (!locator.isRegistered<FlutterSecureStorage>()) {
    locator.registerLazySingleton<FlutterSecureStorage>(
        () => FlutterSecureStorage());
  }

  // Register ApiClient as a singleton only if not already registered:
  if (!locator.isRegistered<ApiClient>()) {
    locator.registerLazySingleton<ApiClient>(
        () => ApiClient(locator<SharedPreferences>()));
  }
}
