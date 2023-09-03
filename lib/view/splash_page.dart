import 'package:micro_memo/importer.dart';

class SplashPage extends StatefulBaseWidget {
  static const String route = "/";

  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends BaseState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _fetchAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: Dimens.splashIconHeight,
          child: SvgPicture.asset("assets/images/memo_icon.svg"),
        ),
      ),
    );
  }

  _fetchAppSettings() {
    Repository.instance.fetchAppSettings().then((value) => {
      appSettings.notifier = SettingsNotifier(value),
      proceedNext()
    });
  }

  proceedNext() {
    if (lockOnLaunched) {
      LockPage.tryUnlock(context, closeable: false, onUnlocked: () {
        navigateToHome();
      });
    } else {
      navigateToHome();
    }
  }

  navigateToHome() {
    finish(context: context);
    navigate(context: context, path: HomePage.route);
  }
}