import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/services/auth_api_service.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/login_bloc.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/pages/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:ttld/pages/signup/bloc/signup_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/core/di/injection.dart'; // Import locator from central location

// This function doesn't contain any async operations, so it doesn't need to be async
// but we keep it async for consistency with other setup functions
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
  locator.registerLazySingleton<AuthBloc>(
      () => AuthBloc(authRepository: locator<AuthRepository>()));
  locator.registerLazySingleton<SignupBloc>(
      () => SignupBloc(authRepository: locator<AuthRepository>()));
  locator.registerLazySingleton<LoginBloc>(() => LoginBloc(
        authRepository: locator<AuthRepository>(),
        authBloc: locator<AuthBloc>(),
      ));
  locator.registerLazySingleton<ForgotPasswordBloc>(
      () => ForgotPasswordBloc(locator<ApiClient>().dio));
}
