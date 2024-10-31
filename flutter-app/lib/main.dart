import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumpikometr/app_bloc_observer.dart';
import 'package:lumpikometr/error/view/error_page.dart';
import 'package:lumpikometr/home/view/home_page.dart';
import 'package:lumpikometr/login/login.dart';
import 'package:lumpikometr/splash/splash.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init((o) {
    o.dsn =
        'https://569cfc319a2945ed7a4c0cb944d7830f@o1414682.ingest.us.sentry.io/4507429884395520';
    // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
    // We recommend adjusting this value in production.
    o.tracesSampleRate = 1.0;
    // The sampling rate for profiling is relative to tracesSampleRate
    // Setting to 1.0 will profile 100% of sampled transactions:
    o.profilesSampleRate = 1.0;
  }, appRunner: () {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = const AppBlocObserver();
    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc()..add(LoginEvent()),
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      navigatorKey: _navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      builder: (context, child) => BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          switch (state) {
            case LoginLoadingState():
              _navigator.pushAndRemoveUntil(SplashPage.route(), (_) => false);
            case LoggedInState():
              _navigator.pushAndRemoveUntil(HomePage.route(), (_) => false);
            case LoggedOutState():
              _navigator.pushAndRemoveUntil(LoginPage.route(), (_) => false);
            case LoginErrorState():
              _navigator.pushAndRemoveUntil(ErrorPage.route(), (_) => false);
          }
        },
        child: child,
      ),
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
