import 'package:micro_memo/importer.dart';

class AppRouter {
  static AppRouter of(RouteSettings settings) {
    return AppRouter._(settings);
  }

  final RouteSettings settings;

  AppRouter._(this.settings);

  Route<dynamic>? getRoute() {
    switch (settings.name) {
      case SplashPage.route:
        return _SplashPageRoute();
      case HomePage.route:
        return _HomePageRoute();
      case MemoPage.route:
        final ivo = settings.arguments as MemoPageIVO;
        return _MemoPageRoute(ivo);
      case CreateMemoPage.route:
        final ivo = settings.arguments as MemoPageIVO;
        return _CreateMemoPageRoute(ivo);
      case CreateTemplatePage.route:
        final ivo = settings.arguments as MemoPageIVO;
        return _CreateTemplatePageRoute(ivo);
      case EditTemplatePage.route:
        final ivo = settings.arguments as MemoPageIVO;
        return _EditTemplatePageRoute(ivo);
      case RegisterTemplatePage.route:
        final ivo = settings.arguments as MemoPageIVO;
        return _RegisterTemplatePageRoute(ivo);
      case LockPage.route:
        throw Exception("use Lockpage#tryUnlock.");
      case PasscodeRegisterPage.route:
        final ivo = settings.arguments as PasscodeRegisterPageIVO;
        return _PasscodeRegisterPageRoute(ivo);
      case SettingsPage.route:
        return _SettingsPageRoute();
      case TemplateSelectionPage.route:
        return _TemplateSelectionPageRoute();
      case TemplateListPage.route:
        return _TemplateEditingPageRoute();
      default:
        return null;
    }
  }
}

class _SplashPageRoute extends MaterialPageRoute {
  _SplashPageRoute() : super(builder: (context)
    => const SplashPage()
  );
}

class _HomePageRoute extends MaterialPageRoute {
  _HomePageRoute() : super(builder: (context)
    => const HomePage()
  );
}

class _MemoPageRoute extends MaterialPageRoute {
  _MemoPageRoute(MemoPageIVO ivo) : super(builder: (context)
    => MemoPage(ivo: ivo)
  );
}

class _CreateMemoPageRoute extends MaterialPageRoute {
  _CreateMemoPageRoute(MemoPageIVO ivo) : super(builder: (context)
    => CreateMemoPage(ivo: ivo)
  );
}

class _CreateTemplatePageRoute extends MaterialPageRoute {
  _CreateTemplatePageRoute(MemoPageIVO ivo) : super(builder: (context)
    => CreateTemplatePage(ivo: ivo)
  );
}

class _EditTemplatePageRoute extends MaterialPageRoute {
  _EditTemplatePageRoute(MemoPageIVO ivo) : super(builder: (context)
    => EditTemplatePage(ivo: ivo)
  );
}

class _RegisterTemplatePageRoute extends MaterialPageRoute {
  _RegisterTemplatePageRoute(MemoPageIVO ivo) : super(builder: (context)
    => RegisterTemplatePage(ivo: ivo)
  );
}

class _PasscodeRegisterPageRoute extends MaterialPageRoute {
  _PasscodeRegisterPageRoute(PasscodeRegisterPageIVO ivo) : super(
            builder: (context) => PasscodeRegisterPage(ivo: ivo)
  );
}

class _SettingsPageRoute extends MaterialPageRoute {
  _SettingsPageRoute() : super(builder: (context)
    => const SettingsPage()
  );
}

class _TemplateSelectionPageRoute extends MaterialPageRoute {
  _TemplateSelectionPageRoute(): super(builder: (context)
    => TemplateSelectionPage()
  );
}

class _TemplateEditingPageRoute extends MaterialPageRoute {
  _TemplateEditingPageRoute(): super(builder: (context)
    => TemplateListPage()
  );
}
