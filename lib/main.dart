import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:mcp_toolkit/mcp_toolkit.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/router/app_router.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/themes/text/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/enums/region.dart';
import 'features/auth/bloc/auth_bloc.dart'; // For Region enum

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      MCPToolkitBinding.instance
        ..initialize() // Initializes the Toolkit
        ..initializeFlutterToolkit(); // Adds Flutter related methods to the MCP server
      await dotenv.load(fileName: ".env");
      await setupLocator(); // Initialize GetIt

      // Read region from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? regionStr = prefs.getString('selected_region');
      Region initialRegion = Region.binhDinh;
      if (regionStr != null) {
        switch (regionStr) {
          case 'lamDong':
            initialRegion = Region.lamDong;
            break;
          case 'binhThuan':
            initialRegion = Region.binhThuan;
            break;
          case 'binhDinh':
            initialRegion = Region.binhDinh;
            break;
        }
      }
      runApp(MyApp(initialRegion: initialRegion));
    },
    (error, stack) {
      // You can place it in your error handling tool, or directly in the zone. The most important thing is to have it - otherwise the errors will not be captured and MCP server will not return error results.
      MCPToolkitBinding.instance.handleZoneError(error, stack);
    },
  );
}

class MyApp extends StatelessWidget {
  final Region initialRegion;
  const MyApp({super.key, required this.initialRegion});

  @override
  Widget build(BuildContext context) {
    List<AppTheme> themes = getAppThemes(appThemes);
    return ThemeProvider(
      themes: themes,
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) {
            // Access AuthBloc directly from GetIt instead of context
            final router = AppRouter(
              authBloc: locator<AuthBloc>(),
              initialRegion: initialRegion,
            ).router;
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Thị Trường Lao Động',
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
      ),
    );
  }
}
