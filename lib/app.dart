import 'importer.dart';

class MicroMemoApp extends StatelessWidget {
  static final _themeNotifier = ThemeNotifier(false);
  static switchTheme(bool isDark) {
    _themeNotifier.switchTheme(isDark);
  }

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
    return FutureBuilder(
      future: Repository.instance.fetchAppSettings(),
      builder: (BuildContext context, AsyncSnapshot<AppSettingsModel> snapshot) {
        if (snapshot.hasData) {
          _themeNotifier.value = snapshot.data!.isDark;

          return ListenableBuilder(
            listenable: _themeNotifier,
            builder: (context, child) {
              return MaterialApp(
                  title: Strings.appTitle,
                  theme: _themeNotifier.isDark ? AppTheme.dark : AppTheme.light,
                  darkTheme: AppTheme.dark,
                  onGenerateRoute: (settings) => AppRouter.of(settings).getRoute(),
                  initialRoute: SplashPage.route,
              );
            }
          );
        } else {
          return Center(
              child: SizedBox(
              height: Dimens.splashIconHeight,
              child: SvgPicture.asset("assets/images/memo_icon.svg"),
              )
          );
        }
      },
    );
  }
}

class AppTheme {
  static ThemeData get light => _themeOf(brightness: Brightness.light);
  static ThemeData get dark  => _themeOf(brightness: Brightness.dark);

  static ThemeData _themeOf({required Brightness brightness}) {
    final colorScheme = isDark(brightness) ? darkColorScheme : lightColorScheme;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      fontFamily: 'IBMPlexSansJp',
      pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder()
            // Android以外は定義しない
          }
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: Dimens.fontSizeLarge),
        bodyMedium: TextStyle(fontSize: Dimens.fontSizeMedium),
      ),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          elevation: 1,
          shadowColor: colorScheme.primary
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(colorScheme.onSurface),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(colorScheme.onSurface),
        ),
      ),
    );
  }
}
