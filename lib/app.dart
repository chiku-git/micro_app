import 'importer.dart';

class MicroMemoApp extends StatelessWidget {

  MicroMemoApp({super.key}) {
    _onAppLaunched();
  }

  /// アプリ起動時の処理
  void _onAppLaunched() {
    SharedPreferenceManager.init();
    Repository.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      onGenerateRoute: (settings) => AppRouter.of(settings).getRoute(),
      initialRoute: SplashPage.route
    );
  }
}

class AppTheme {
  static ThemeData common() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'IBMPlexSansJp',
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder()
        }
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: Dimens.fontSizeLarge),
        bodyMedium: TextStyle(fontSize: Dimens.fontSizeMedium),
      ),
    );
  }

  static ThemeData light() {
    return common().copyWith();
  }

  static ThemeData dark() {
    return common().copyWith();
  }
}
