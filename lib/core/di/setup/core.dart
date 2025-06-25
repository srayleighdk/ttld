import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/di/injection.dart'; // Import locator from central location

Future<void> setupCoreLocator() async {
  // This function needs to be async because of SharedPreferences.getInstance()
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
