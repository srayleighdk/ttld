import 'package:get_it/get_it.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/services/auth_api_service.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/login_bloc.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/pages/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:ttld/pages/signup/bloc/signup_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupAuthLocator() async {
  // Register AuthApiService as a singleton:
  locator.registerLazySingleton<AuthApiService>(
      () => AuthApiService(locator<ApiClient>()));

  // Register repositories:
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository(
      authApiService: locator<AuthApiService>(),
      prefs: locator<SharedPreferences>(),
      storage: locator<FlutterSecureStorage>()));

  // Register blocs:
  locator.registerLazySingleton(() => AuthBloc());
  locator.registerLazySingleton(
      () => SignupBloc(authRepository: locator<AuthRepository>()));
  locator.registerLazySingleton(() => LoginBloc(
        authRepository: locator<AuthRepository>(),
        authBloc: locator<AuthBloc>(),
      ));
  locator.registerLazySingleton(
      () => ForgotPasswordBloc(locator<ApiClient>().dio));
}
