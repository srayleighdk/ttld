import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/router/app_router.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';
import 'package:ttld/features/auth/bloc/login_bloc.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/pages/signup/bloc/signup_bloc.dart';
import 'package:ttld/themes/text/app_theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<AppTheme> themes = getAppThemes(appThemes);
    return ThemeProvider(
      themes: themes,
      child: ThemeConsumer(
        child: Builder(builder: (themeContext) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => AuthRepository(ApiClient().dio),
              )
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AuthBloc()..add(AuthCheckRequested()),
                ),
                BlocProvider(
                  create: (context) => SignupBloc(
                    authRepository: context.read<AuthRepository>(),
                  ),
                ),
                BlocProvider(
                  create: (context) =>
                      LoginBloc(authRepository: context.read<AuthRepository>()),
                )
              ],
              child: Builder(builder: (context) {
                final router = AppRouter(
                  authBloc: context.read<AuthBloc>(),
                ).router;
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeProvider.themeOf(themeContext).data,
                  // home: const MyHomePage(title: 'Flutter Demo Home Page'),
                  routerConfig: router,
                  builder: (context, child) {
                    return StyledToast(
                      locale: const Locale('en', 'US'),
                      child: child!,
                    );
                  },
                  // darkTheme: themes.darkTheme,
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
