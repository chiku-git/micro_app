import 'package:micro_memo/importer.dart';

bool isNotNull(dynamic value) {
  return !isNull(value);
}

bool isNull(dynamic value) {
  return value == null;
}

void checkNonNull(List<dynamic> values) {
  for (var value in values) {
    if (isNull(value)) {
      throw Error();
    }
  }
}

bool isOK(dynamic value) {
  return isNotNull(value) && value.runtimeType == bool && value;
}

Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double getScreenHeight(BuildContext context) {
  return getScreenSize(context).height;
}

double getScreenWidth(BuildContext context) {
  return getScreenSize(context).width;
}

bool isDark(Brightness brightness) {
return brightness == Brightness.dark;
}

runOnDelayed({required int millis, required Function action}) {
  Future.delayed(Duration(milliseconds: millis), () => action.call());
}