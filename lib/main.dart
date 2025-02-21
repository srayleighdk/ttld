import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:ttld/core/di/injection.dart'; // Import GetIt setup
import 'package:ttld/core/di/providers.dart';
import 'package:ttld/core/router/app_router.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/themes/text/app_theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  setupLocator(); // Initialize GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<AppTheme> themes = getAppThemes(appThemes);
    return ThemeProvider(
      themes: themes,
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) {
            return MultiBlocProvider(
              providers: getBlocProviders(), // Provide BLoCs
              child: Builder(
                builder: (context) {
                  final router = AppRouter(
                    authBloc: context.read<AuthBloc>(),
                    ldRepository:
                        locator<LdRepository>(), // Access repository via GetIt
                  ).router;
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    theme: ThemeProvider.themeOf(themeContext).data,
                    routerConfig: router,
                    builder: (context, child) {
                      return StyledToast(
                        locale: const Locale('vi', 'VN'),
                        child: child!,
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
