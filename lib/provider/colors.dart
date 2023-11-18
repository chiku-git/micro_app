import 'package:micro_memo/importer.dart';

class AppColor {
  static AppColor of(BuildContext context) => AppColor._(context);

  AppColor._(this._context);

  static const Color gainsBoro = Color(0xffdcdcdc);

  final BuildContext _context;
  AppColorScheme get _scheme {
    return isDark(Theme.of(_context).brightness) ? _dark : _light;
  }

  ColorScheme get themeColors => _scheme.themeColorScheme;
  UIColorScheme get uiColors => _scheme.uiColorScheme;

  AppColorScheme get _light => AppColorScheme(
    themeColorScheme: Theme.of(_context).colorScheme,
    uiColorScheme: UIColorScheme(
        passcodeButtonTint: const Color(0xffdcdcdc),
        subTextColor: const Color(0xffa9a9a9),
        borderColor: const Color(0xffbfbfbf),
    ),
  );

  AppColorScheme get _dark => AppColorScheme(
    themeColorScheme: Theme.of(_context).colorScheme,
    uiColorScheme: UIColorScheme(
        passcodeButtonTint: const Color(0xff2c2b29),
        subTextColor: const Color(0xffa9a9a9),
        borderColor: const Color(0xffdcdcdc),
    ),
  );
}

class AppColorScheme {
  final ColorScheme themeColorScheme;
  final UIColorScheme uiColorScheme;

  AppColorScheme({
    required this.themeColorScheme,
    required this.uiColorScheme
  });
}

class UIColorScheme {
  final Color passcodeButtonTint;
  final Color subTextColor;
  final Color borderColor;

  UIColorScheme({
    required this.passcodeButtonTint,
    required this.subTextColor,
    required this.borderColor
  });
}
